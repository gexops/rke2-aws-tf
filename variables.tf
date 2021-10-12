variable "cluster_name" {
  description = "Name of the rkegov cluster to create"
  type        = string
}

variable "unique_suffix" {
  description = "Enables/disables generation of a unique suffix to cluster name"
  type        = bool
  default     = true
}

variable "vpc_id" {
  description = "VPC ID to create resources in"
  type        = string
}

variable "subnets" {
  description = "List of subnet IDs to create resources in"
  type        = list(string)
}

variable "tags" {
  description = "Map of tags to add to all resources created"
  default     = {}
  type        = map(string)
}

#
# Server pool variables
#
variable "instance_type" {
  type        = string
  default     = "t3a.medium"
  description = "Server pool instance type"
}

variable "ami" {
  description = "Server pool ami"
  type        = string
}

variable "iam_instance_profile" {
  description = "Server pool IAM Instance Profile, created if left blank (default behavior)"
  type        = string
  default     = ""
}

variable "iam_permissions_boundary" {
  description = "If provided, the IAM role created for the servers will be created with this permissions boundary attached."
  type        = string
  default     = null
}

variable "block_device_mappings" {
  description = "Server pool block device mapping configuration"
  type        = map(string)
  default = {
    "size"      = 30
    "encrypted" = false
  }
}

variable "extra_block_device_mappings" {
  description = "Used to specify additional block device mapping configurations"
  type        = list(map(string))
  default = [
  ]
}

variable "servers" {
  description = "Number of servers to create"
  type        = number
  default     = 1
}

variable "asg" {
  type = object({
    min     = number
    max     = number
  })
  default = {
    min     = 1
    max     = 7
  }
}

variable "spot_allocation_strategy" {
  default = "lowest-price"
  type    = string
  description = "Valid Values: lowest-price, capacity-optimized, capacity-optimized-prioritized. Default: lowest-price"
}

variable "spot_instance_pools" {
  default = 2
  type    = number
  description = "Number of Spot pools per availability zone to allocate capacity. Default: 2"
}

variable "spot_max_price" {
  default = ""
  type    = string
  description = "Maximum price per unit hour that the user is willing to pay for the Spot instances. Default: an empty string which means the on-demand price."
}

variable "on_demand_base_capacity" {
  default = 0
  type    = number
  description = "Absolute minimum amount of desired capacity that must be fulfilled by on-demand instances Default: 0"
}

variable "on_demand_percentage_above_base_capacity" {
  default = 0
  type    = number
  description = "Percentage split between on-demand and Spot instances above the base on-demand capacity. 100 = all on demand. 0 = all spot. Default: 0"
}


variable "extra_instance_types" {
  type = list(object({
    instance_type = string
    weighted_capacity = number
  }))
  //type = list(map(string))
  default = []
}

variable "capacity_rebalance" {
  default = false
  type    = bool
}

variable "spot" {
  description = "Toggle spot requests for server pool"
  type        = bool
  default     = false
}

variable "ssh_authorized_keys" {
  description = "Server pool list of public keys to add as authorized ssh keys"
  type        = list(string)
  default     = []
}

variable "extra_security_group_ids" {
  description = "List of additional security group IDs"
  type        = list(string)
  default     = []
}

#
# Controlplane Variables
#
variable "controlplane_enable_cross_zone_load_balancing" {
  description = "Toggle between controlplane cross zone load balancing"
  default     = true
  type        = bool
}

variable "controlplane_internal" {
  description = "Toggle between public or private control plane load balancer"
  default     = true
  type        = bool
}

variable "controlplane_allowed_cidrs" {
  description = "Server pool security group allowed cidr ranges"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

#
# RKE2 Variables
#
variable "rke2_version" {
  description = "Version to use for RKE2 server nodes"
  type        = string
  default     = "v1.19.7+rke2r1"
}

variable "rke2_config" {
  description = "Server pool additional configuration passed as rke2 config file, see https://docs.rke2.io/install/install_options/server_config for full list of options"
  type        = string
  default     = ""
}

variable "download" {
  description = "Toggle best effort download of rke2 dependencies (rke2 and aws cli), if disabled, dependencies are assumed to exist in $PATH"
  type        = bool
  default     = true
}

variable "pre_userdata" {
  description = "Custom userdata to run immediately before rke2 node attempts to join cluster, after required rke2, dependencies are installed"
  type        = string
  default     = ""
}

variable "post_userdata" {
  description = "Custom userdata to run immediately after rke2 node attempts to join cluster"
  type        = string
  default     = ""
}

variable "enable_ccm" {
  description = "Toggle enabling the cluster as aws aware, this will ensure the appropriate IAM policies are present"
  type        = bool
  default     = false
}
