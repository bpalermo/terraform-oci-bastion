# general oci parameters
variable "compartment_id" {
  description = "compartment id where to create all resources"
  type        = string
}

variable "label_prefix" {
  description = "a string that will be prepended to all resources"
  type        = string
  default     = ""
}

variable "bastion_access" {
  description = "CIDR block in the form of a string to which ssh access to the bastion must be restricted to. *_ANYWHERE_* is equivalent to 0.0.0.0/0 and allows ssh access from anywhere."
  default     = "0.0.0.0/0"
  type        = string
}

variable "ig_route_id" {
  description = "the route id to the internet gateway"
  type        = string
}

variable "net_num" {
  description = "0-based index of the bastion subnet when the VCN's CIDR is masked with the corresponding newbit value."
  default     = 0
  type        = number
}

variable "new_bits" {
  description = "The difference between the VCN's netmask and the desired bastion subnet mask"
  default     = 13
  type        = number
}

variable "vcn_id" {
  description = "The id of the VCN to use when creating the bastion resources."
  type        = string
}

variable "bastion_type" {
  description = "Whether to make the bastion host public or private."
  default     = "STANDARD"
  type        = string
}

# tagging
variable "tags" {
  description = "Freeform tags for bastion"
  type        = map(string)
}
