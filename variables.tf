variable "instance_name" {
  description = "Name for the GPU instance"
  type        = string
  default     = "nerfstudio-gpu"
}

variable "image_name" {
  description = "Name of the OS image - MUST be Ubuntu 20.04"
  type        = string
  default     = "ubuntu-20.04-server-amd64.raw"
}

variable "flavor_name" {
  description = "GPU flavor - A40-8Q recommended"
  type        = string
  default     = "gpu8.A40-8Q"
}


variable "key_name" {
  description = "SSH key pair name"
  type        = string
  default     = "your-keypair-name"  # REPLACE WITH YOUR KEYPAIR NAME
}

variable "network_name" {
  description = "Private network name"
  type        = string
  default     = "nerfstudio-network"
}

variable "subnet_cidr" {
  description = "CIDR for private subnet"
  type        = string
  default     = "192.168.100.0/24"
}
