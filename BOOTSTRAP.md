### Create project, vpc and cluster
Customize `terraform/terraform.tfvars` to your choosing and run `terraform apply`.

### Cluster bootstrap
1. Get credentials: `$ gcloud container clusters get-credentials --region=europe-west1 interview --project=platform-interview-3568`
2. Switch kube context: `$ kubectl config use-context gke_platform-interview-3568_europe-west1_interview`
3. Apply bootstrap configuration: `$ cd manifests/bootstrap && kubectl apply -k .`
4. Patch in a github personal access token to the repository secret: 
```sh
$ kubectl patch secrets platform-interview-repo \
  -n argocd \
  -p "{\"stringData\":{\"username\":\"GITHUB_USERNAME\",\"password\":\"PERSONAL_ACCESS_TOKEN\"}}"
```

### Argo CD
1. Port-forward to UI: `$ kubectl port-forward service/argocd-server -n argocd 8080:80`
2. Log in with user `admin`, password `mittatb`


