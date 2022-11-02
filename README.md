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

## Kubeconfig
Use the following kubeconfig:
```yaml
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUVMVENDQXBXZ0F3SUJBZ0lSQVBvSjJGeTlLMkszYVExQks4cGw4YkV3RFFZSktvWklodmNOQVFFTEJRQXcKTHpFdE1Dc0dBMVVFQXhNa016UTFZbU5qTlRNdE9XTmlNeTAwT1dVNExXRTVOek10TW1JMlpXVTFObU0xTVRaaApNQ0FYRFRJeU1URXdNakV4TVRrMU9Wb1lEekl3TlRJeE1ESTFNVEl4T1RVNVdqQXZNUzB3S3dZRFZRUURFeVF6Ck5EVmlZMk0xTXkwNVkySXpMVFE1WlRndFlUazNNeTB5WWpabFpUVTJZelV4Tm1Fd2dnR2lNQTBHQ1NxR1NJYjMKRFFFQkFRVUFBNElCandBd2dnR0tBb0lCZ1FERDd0NzJVUzdnQ2h2N1o1ck9RZWo1UmxDeXgyT2F5eUFUaHpnZwpwb1c1RUJOVHZpa294SHBHS3VCanhiWDRFd0tSWCtwSzRZK3lYQWJzbC9nTXJoRExXdXkzVk1nNjk5enk5Q3pwCjZQaTloOHZ4Z3k3V0JSY3JmcVk3ZldNbzFNMnJpVy9nQjJnb1crQmtYdzRLNm1iclM1aDVjdVRCcFhWYVlEWWMKWm50Mk1oUjQ2NmR6U1ZyeENEZXJyZHk0N2JKc2lKQkFjbWJvcTc0RUVvT1BZM0kwaGxEakU5SEVBekZ4YzlBbwpRQmJGUjUwaU1PRmQxc3YvOHRLWVNwTXErSldZUDVyM3BJUXNCdFVnd0tlM3lJdGl3dENXNUxXRHBmWEl6SFZvCjhiNzExeEozejJqcEhKU1JubHRlSmZCTXhKQ25LRjk0MXJPN2V5M0VISmNSbVNJL2RTb0lOK0hoM3doN25qZ2YKZDJENXJqclJWSVhsYXNoK09yL2pzUFV1a1o3dTNvUU9XTm9CUzI1czFlVVFGcHIvWEsvd0JiMGxrYXRqa1JDSAozVHhDMjR2NmNNeWQrbEZKbk5iajJNdHlWeFJmYnVLWjJ6OHBJdW9BQWxpd2k2RlhwcnVmbXZQWW1mSlBuSjlsCmpNWU8xSlNCS2szWmRud2ltalQ0VVJMMXpJRUNBd0VBQWFOQ01FQXdEZ1lEVlIwUEFRSC9CQVFEQWdJRU1BOEcKQTFVZEV3RUIvd1FGTUFNQkFmOHdIUVlEVlIwT0JCWUVGSEZXU0NOckh4anBFKzhXci9idW05WVRGamF4TUEwRwpDU3FHU0liM0RRRUJDd1VBQTRJQmdRQ3JTUTlGdEM2dUQ2c3ZkK3FtRks3T3g2c0VDdXRqMGhWQ2RDemRFcWFNCldQdGFlSTlvLzdnTXJWSnhvMEhJbHVsdTdVaE9xWnJMSmw3aWZlNnc4VUFzdm1RQ0lKZVFJQU1pdmJLY1l5bVIKMjYwRFJKL2s5Vy9sTkQ0d2t4TDFvdEpGUjNLUnlra2J5S2ZZc2Rad2ZrbFQ0QlhyK1JBS0lTaDQ3REljSm5MNApBelBDM2ZuKzlDc0RwMHczWWttbWlJTEt2YnRJRDB3QWRLcDlHNXhSWUd0dlpDdHRnWG9DMTJWV1IrY0gwQ2hQClJWYVVZSEp1S3ZPRTdxbks0MWh4Ymd2ZkcvcTUrT3JlQmZmMHlOcFV1cDdGWlJuTUZ0R2V1N1oxQWVGODBGUUcKRTlQKzJycmUzUFpSb0QrNHRtZFY2Q3d0WXN1WkVzMEM5eUFoMDJPL3RaM2NsMFVockplZCttRFlDbS9mYUk5VQpRZEhIS21FdWdIR2dZaG5WMWRUbm1hcmc2YzZVYlpjNHZVNHM2OThyTjRFQTB2ek9qU1BtZ2FNQ01pQXVmRVpWCmx0RnJYZno1UUhnOUNrMTQ2NXQ2QXA0K1dGY1RNZDk1V2R1MVgyL0xrZ2M3QUs1SHlRTmROL2dFMXljMlF3eGMKK1RsUDYyNkxIeGNBeFNPSktNb0Z3Qk09Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K
    server: https://35.205.76.145
  name: gke_platform-interview-8e2f_europe-west1_interview
contexts:
- context:
    cluster: gke_platform-interview-8e2f_europe-west1_interview
    user: gke_platform-interview-8e2f_europe-west1_interview
  name: gke_platform-interview-8e2f_europe-west1_interview
current-context: gke_platform-interview-8e2f_europe-west1_interview
kind: Config
preferences: {}
users:
- name: gke_platform-interview-8e2f_europe-west1_interview
  user:
    token: ya29.c.b0AUFJQsFzMDeLsnTpaz2TsHmcHYWUUI24YYF-S6CdXtrCJPciz3e4A8jL4q2rCOLzhfITeaWmOIZW71m9y88wsbclOj3T72tU9Tu3l8DC5YGXAwoUB6IUynoh13SMSehXYAVa_ifm5h99tuG7x1fuRH23TCnz3ZxwbuyLuaNqtbBPsycaCMOs7qfhQwAyxR-LPU49Dks_7e8_e1xrVMyCXMm-Lp18tbxwbtt0MO9OJ6xW7Dvdln0rccXvaw49jDbM9OVkyGXXbz4t_pr6xT6oO0yOkxKfFnTtURK4-tTL7IQnzwz5BGbMdE9N-Zdyo6YHY-yWcFMWSF8EzFVzaGM5vOEuL8ZeogETqnwFOpAHFgtRPWKkfqMQQyc2yirdcdsQrI0MYKhIQb1xSiau_w9mE4F0F8kUuNiUEVPY7fl8YJH4vl0yoU8mcwYT9jM7bdQYUdo6ez6KT1dx6XXilptYsk4L...............................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................
```

Store this in a file and point the environment variable KUBECONFIG to it, eg:
`$ export KUBECONFIG=~/kubeconfig_platform_interview`

