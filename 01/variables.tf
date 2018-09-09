variable "region" {
  default = "eu-central-1"
}

variable "ubuntu_amis" {
  type = "map"
}

variable "admin_outside_ip"{
  default = "84.194.116.132/32"
}