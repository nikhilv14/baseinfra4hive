#variable "inputs" {}

#variable "tf_bucket_region" {}

#variable "tf_bucket_name" {}

variable "name" {
  type = string
}

variable "region" {
  description = "Region to instantiate resources in"
  type        = string
}

variable "environment" {
  description = "Environment to instantiate resources"
  type        = string
}

variable "vpcid" {
  description = "vpc id"
  type        = string
}

variable "subnetid" {
  description = "subnet id"
  type        = string
}

variable ec2s {
  type = map(map(string))
}