# terraform-examples

Examples of how to build infrastructure-as-code using Terraform

## OpenStack

Examples specific to OpenStack


### OpenStack Setup

After creating a Python virtual environment in the `rd-openstack-cli` directory:
```
source / ... /rd-openstack-cli/venv/bin/activate
source / ... /rd-openstack-cli/bbc-openrc.sh <BBC USERNAME>_project
```

## Setup Instructions for Each Example

```
terraform init  # only do this the first time
```
```
terraform plan  # if you want to see changes without applying
```
```
terraform apply  # respond yes to confirm changes
```
```
terraform destroy  # undo apply step and remove resources
```
