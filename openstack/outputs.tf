#######################################################################################
# Output Values
#######################################################################################

output "gpu_info" {
  description = "GPU configuration"
  value       = "NVIDIA A40-8Q with 8GB VRAM"
}

output "instance_id" {
  description = "Instance ID"
  value       = openstack_compute_instance_v2.gpu_instance.id
}

output "instance_name" {
  description = "Instance name"
  value       = openstack_compute_instance_v2.gpu_instance.name
}

output "public_ip" {
  description = "Public IP address"
  value       = openstack_networking_floatingip_v2.ip_address.address
}

output "ssh_command" {
  description = "SSH command to connect"
  value       = "ssh ubuntu@${openstack_networking_floatingip_v2.ip_address.address}"
}
