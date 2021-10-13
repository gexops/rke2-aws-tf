

variable "s3_bucket_name" {
  type = string
  description = "S3 Bucket Name to use / create for RKE2"
  default = null
}

variable "s3_force_delete_enabled" {
  type = bool
  description = "Enable / Disable S3 Force Delete. Disable if you intend on using the bucket for other storage. Default = True"
  default = true
}


variable "name" {
  type = string
}

variable "token" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
