#######################################################################################
# Networking
#######################################################################################

# Find what key you use with OpenStack through the web UI
variable "key_name" {
  description = "SSH key pair name"
  type        = string
  default     = "OPENSTACK_KEY_NAME"
}

# Visit https://whatismyipaddress.com/ to find your home IP address
variable "home_ip_address" {
  description = "Your local IP address for home access"
  type        = string
  default     = "YOUR.HOME.IP.HERE"
}

variable "instance_name" {
  description = "Name for the GPU instance"
  type        = string
  default     = "example-gpu-instance"
}

variable "flavor_name" {
  description = "GPU flavor - A40-8Q recommended"
  type        = string
  default     = "gpu8.A40-8Q"
}

variable "image_name" {
  description = "Name of the OS image - MUST be Ubuntu 20.04"
  type        = string
  default     = "ubuntu-20.04-server-amd64.raw"
}

variable "network_name" {
  description = "Private network name"
  type        = string
  default     = "example-instance-network"
}

variable "subnet_cidr" {
  description = "CIDR for private subnet"
  type        = string
  default     = "192.168.100.0/24"
}
