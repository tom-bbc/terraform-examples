#######################################################################################
# GPU Instance
#######################################################################################

# Get the Ubuntu 20.04 image
data "openstack_images_image_v2" "ubuntu" {
  name        = var.image_name
  most_recent = true
}

# Get the GPU flavor
data "openstack_compute_flavor_v2" "gpu_flavor" {
  name = var.flavor_name
}

# Create the GPU instance
resource "openstack_compute_instance_v2" "gpu_instance" {
  name            = var.instance_name
  flavor_id       = data.openstack_compute_flavor_v2.gpu_flavor.id
  key_pair        = var.key_name
  security_groups = [openstack_networking_secgroup_v2.gpu_sg.name]

  block_device {
    uuid                  = data.openstack_images_image_v2.ubuntu.id
    source_type           = "image"
    destination_type      = "volume"
    volume_size           = 100
    boot_index            = 0
    delete_on_termination = true
  }

  network {
    uuid = openstack_networking_network_v2.network.id
  }

  metadata = {
    gpu_enabled = "true"
    purpose     = "nerfstudio"
  }


depends_on = [
    openstack_networking_router_interface_v2.router_interface
  ]
}


#######################################################################################
# Volume & IP Address
#######################################################################################

# Create GPU driver volume from GRID drivers image
resource "openstack_blockstorage_volume_v3" "gpu_drivers" {
  name        = "gpu_drivers"
  size        = 2
  image_id    = "f34eed36-61da-4e46-84f6-6c381c7fe9e3"  # GPU_GRID_drivers image
  description = "NVIDIA GRID drivers for GPU instance"
}

# Attach GPU driver disk
resource "openstack_compute_volume_attach_v2" "gpu_drivers_attach" {
  instance_id = openstack_compute_instance_v2.gpu_instance.id
  volume_id   = openstack_blockstorage_volume_v3.gpu_drivers.id
}

# Allocate floating IP
resource "openstack_networking_floatingip_v2" "ip_address" {
  pool = "PUBLIC_INTERNET"
}

# Associate floating IP with instance
resource "openstack_compute_floatingip_associate_v2" "ip_address_attach" {
  floating_ip = openstack_networking_floatingip_v2.ip_address.address
  instance_id = openstack_compute_instance_v2.gpu_instance.id
}
