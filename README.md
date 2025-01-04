## How to run and deploy this application.

clone the repo,
cd into the `kubernetes/terraform` directory. 
- run `terraform init`
- run `terraform plan`
- run `terraform apply` and enter yes

this will create the namespace: `swish-proj ` in which the deployment and service will be created in.

It creates the deployment `python-r-app` with 2 replicas and creates a service that exposes the deployment.

One can also expose a deployment by running.
`kubectl expose deployment <deployment-name> --type=NodePort --port=8080 --target-port=8080`
This creates a service, but it is better to use the Kubernetes declarative method used in the terraform cmds above.

---