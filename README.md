# Description
This repository contains a demo materials used for the following talks:
* TBD

## Additional materials
* [Presentation](https://docs.google.com/presentation/d/1FF2bA9-Nalt5FLEQcJYjZsuYHekxjBIn/edit?usp=share_link&ouid=105692284649335634634&rtpof=true&sd=true)

## Prerequisites
* [Azure account](https://azure.microsoft.com/en-us/free/)
* [Cloudflare account](https://www.cloudflare.com/)
* [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
* [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
* [Helm](https://helm.sh/docs/intro/install/)
* [Kustomize](https://kustomize.io/)
* [Taskfile](https://taskfile.dev/#/installation)
## Provisioning
First, you need to authenticate to Azure using Azure CLI or get a service principal credentials. Also, you need to create a Cloudflare API token.
Then, copy the example `.tfvars` file and fill all required variables:
```shell
$ cp _terraform/terraform.tfvars.example _terraform/terraform.tfvars
```
Now the environment is ready to be provisioned. Run the following commands to create the infrastructure:
```shell
$ terraform -chdir=_terraform plan
$ terraform -chdir=_terraform apply
```
## Usage
Then, modify secondary clusters credentials in the [./argocd/values.yaml](./argocd/values.yaml) file (lines 8,10,49,56). All required parameters can be found via the `terraform output` command.

When we have the infrastructure ready, we can bootstrap our ArgoCD cluster, run the following command:
```shell
$ task bootstrap
```
Finally, we can apply one of ArgoCD [patterns](./patterns/):
```shell
$ task app-of-apps
```
or
```shell
$ task application-sets
```

For further customization, please check the directory of a pattern you've insterested in.
