#############
# Networking
##########£##
resource "openstack_networking_network_v2" "network" {
  name           = var.network_name
  admin_state_up = true
}

resource "openstack_networking_subnet_v2" "subnet" {
  name       = "${var.network_name}-subnet"
  network_id = openstack_networking_network_v2.network.id
  cidr       = var.subnet_cidr
  ip_version = 4
  dns_nameservers = ["8.8.8.8", "8.8.4.4"]
}

data "openstack_networking_network_v2" "external" {
  name = "PUBLIC_INTERNET"
}


resource "openstack_networking_router_v2" "router" {
  name                = "${var.network_name}-router"
  admin_state_up      = true
  external_network_id = data.openstack_networking_network_v2.external.id
}

resource "openstack_networking_router_interface_v2" "router_interface" {
  router_id = openstack_networking_router_v2.router.id
  subnet_id = openstack_networking_subnet_v2.subnet.id
}

#################
# Security Group
#################
resource "openstack_networking_secgroup_v2" "gpu_sg" {
  name        = "${var.instance_name}-sg"
  description = "Security group for Nerfstudio GPU instance"
}

# Allow SSH from BBC IP addresses
resource "openstack_networking_secgroup_rule_v2" "ssh_bbc" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "132.185.0.0/16"
  security_group_id = openstack_networking_secgroup_v2.gpu_sg.id
}


# Allow SSH from your home IP (REPLACE WITH YOUR IP)
resource "openstack_networking_secgroup_rule_v2" "ssh_home" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "YOUR.HOME.IP.HERE/32"  # REPLACE WITH YOUR IP
  security_group_id = openstack_networking_secgroup_v2.gpu_sg.id
}

# Allow ICMP (ping) from BBC network
resource "openstack_networking_secgroup_rule_v2" "icmp" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  remote_ip_prefix  = "132.185.0.0/16"
  security_group_id = openstack_networking_secgroup_v2.gpu_sg.id
}
