# networks
resource "openstack_networking_network_v2" "bosh" {
  region         = "${var.region_name}"
  name           = "bosh-test"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "bosh_subnet" {
  region           = "${var.region_name}"
  network_id       = "${openstack_networking_network_v2.bosh.id}"
  cidr             = "10.0.1.0/24"
  ip_version       = 4
  name             = "bosh-test_sub"
  gateway_ip       = "10.0.1.1"
  enable_dhcp      = "true"
  allocation_pool {
    start = "10.0.1.200"
    end   = "10.0.1.254"
  }
}

# router

resource "openstack_networking_router_v2" "bosh_router" {
  region           = "${var.region_name}"
  name             = "bosh-test-router"
  admin_state_up   = "true"
  external_network_id = "${var.ext_net_id}"
}

resource "openstack_networking_router_interface_v2" "bosh_port" {
  region    = "${var.region_name}"
  router_id = "${openstack_networking_router_v2.bosh_router.id}"
  subnet_id = "${openstack_networking_subnet_v2.bosh_subnet.id}"
}
