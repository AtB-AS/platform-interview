# platform-interview

## Problem statement
You are assigned as a platform administrator for two tenants `tenant-a` and `tenant-b`.

You have the following constraints:
Both tenants need the following workload running:

Workload X
* Container image: europe-west1-docker.pkg.dev/platform-interview-8e2f/docker/workload-x:latest
* Needs to be exposed to the internet over HTTP
* Listens to `0.0.0.0:8080` by default
* Configuration:
  * Environment variable `NS`: the current namespace

`tenant-b` needs the following workload running:
Workload Y
* Container image: europe-west1-docker.pkg.dev/platform-interview-8e2f/docker/workload-y:latest
* Needs access to a secret.
