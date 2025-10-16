# openstack-examples
Examples of how to build infrastructure-as-code in OpenStack using Terraform


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
terraform apply  # respond yes to confirm changes
```
```
terraform destroy  # undo apply step and remove resources
```
