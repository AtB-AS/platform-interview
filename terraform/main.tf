locals {
  subnet_01 = "${var.network_name}-subnet-01"
}

// PROJECT
module "host_project" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 13.1"

  name                           = var.project_name
  random_project_id              = true
  org_id                         = var.organization_id
  billing_account                = var.billing_account
  enable_shared_vpc_host_project = true
  default_service_account        = "keep"

  activate_apis = [
    "artifactregistry.googleapis.com",
    "dns.googleapis.com",
    "container.googleapis.com",
    "compute.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "secretmanager.googleapis.com"
  ]
}

// NETWORKING
module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 4.1"

  project_id                             = module.host_project.project_id
  network_name                           = "shared-network"
  delete_default_internet_gateway_routes = false

  subnets = [
    {
      subnet_name           = local.subnet_01
      subnet_ip             = "10.100.0.0/20"
      subnet_region         = var.region
      subnet_private_access = true
    },
  ]

  secondary_ranges = {
    (local.subnet_01) = [
      {
        range_name    = "gke-pods-europe-west1"
        ip_cidr_range = "10.0.0.0/17"
      },
      {
        range_name    = "gke-services-europe-west1"
        ip_cidr_range = "10.1.0.0/22"
      }
    ]
  }
}

resource "google_compute_router" "router" {
  name    = "nat-router-${module.vpc.network_name}"
  region  = module.vpc.subnets_regions[0]
  network = module.vpc.network_name
  project = module.vpc.project_id
}

resource "google_compute_router_nat" "router_nat" {
  name                               = "nat-router-${module.vpc.network_name}-nat"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  project                            = module.vpc.project_id

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

// ARTIFACT REGISTRY
resource "google_artifact_registry_repository" "docker" {
  location      = var.region
  repository_id = "docker"
  description   = "Docker repository"
  format        = "DOCKER"
  project       = module.host_project.project_id
}

data "google_service_account" "compute_default" {
  account_id = "${module.host_project.project_number}-compute@developer.gserviceaccount.com"
}

resource "google_artifact_registry_repository_iam_member" "artifact_registry_readers" {
  project    = google_artifact_registry_repository.docker.project
  location   = google_artifact_registry_repository.docker.location
  repository = google_artifact_registry_repository.docker.name
  role       = "roles/artifactregistry.reader"
  member     = "serviceAccount:${data.google_service_account.compute_default.email}"
}

resource "google_artifact_registry_repository_iam_member" "artifact_registry_writers" {
  project    = google_artifact_registry_repository.docker.project
  location   = google_artifact_registry_repository.docker.location
  repository = google_artifact_registry_repository.docker.name
  role       = "roles/artifactregistry.writer"
  member     = "user:torbjorn@mittatb.no"
}

// CLUSTER
data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

module "gke" {
  source                          = "terraform-google-modules/kubernetes-engine/google//modules/beta-autopilot-private-cluster"
  version                         = "23.1.0"
  project_id                      = module.host_project.project_id
  name                            = "interview"
  regional                        = true
  region                          = var.region
  network                         = var.network_name
  subnetwork                      = "${var.network_name}-subnet-01"
  ip_range_pods                   = "gke-pods-europe-west1"
  ip_range_services               = "gke-services-europe-west1"
  release_channel                 = "REGULAR"
  enable_private_endpoint         = false
  create_service_account          = true
  horizontal_pod_autoscaling      = true
  enable_vertical_pod_autoscaling = true
  enable_private_nodes            = true
  datapath_provider               = "ADVANCED_DATAPATH"
  master_ipv4_cidr_block          = "172.16.0.0/28"
}
