resource "oci_core_security_list" "this" {
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  display_name   = var.label_prefix == "" ? "bastion" : "${var.label_prefix}-bastion"
  freeform_tags  = var.tags

  egress_security_rules {
    protocol    = local.all_protocols
    destination = local.anywhere
  }

  ingress_security_rules {
    # allow ssh
    protocol = local.tcp_protocol
    source   = var.bastion_access

    tcp_options {
      min = local.ssh_port
      max = local.ssh_port
    }
  }
}

resource "oci_core_subnet" "this" {
  compartment_id             = var.compartment_id
  vcn_id                     = var.vcn_id
  cidr_block                 = cidrsubnet(data.oci_core_vcn.this.cidr_block, var.new_bits, var.net_num)
  display_name               = var.label_prefix == "" ? "bastion" : "${var.label_prefix}-bastion"
  dns_label                  = "bastion"
  freeform_tags              = var.tags
  prohibit_public_ip_on_vnic = false
  prohibit_internet_ingress  = false
  route_table_id             = var.ig_route_id
  security_list_ids          = [oci_core_security_list.this.id]
}

resource "oci_bastion_bastion" "this" {
  compartment_id   = var.compartment_id
  bastion_type     = var.bastion_type
  target_subnet_id = oci_core_subnet.this.id

  client_cidr_block_allow_list = [
    var.bastion_access
  ]

  freeform_tags = var.tags
}
