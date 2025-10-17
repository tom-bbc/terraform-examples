terraform {
  required_version = ">= 1.7.5"

  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.43"
    }
  }
}
