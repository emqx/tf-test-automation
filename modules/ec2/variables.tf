variable "namespace" {
  type = string
}

variable "sg_ids" {
  type = list(string)
}

variable "instance_count" {
  type = number
}

variable "subnet_ids" {
  type = list(string)
}

variable "associate_public_ip_address" {
  type = bool
}

variable "instance_type" {
  type = string
}

variable "private_key" {
  type = string
}

variable "emqx_package" {
  type = string
}

variable "key_name" {
  type = string
}

variable "emqx_lic" {
  type = string
}

variable "os" {
  type = string
}