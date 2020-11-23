variable "account_id" {}
variable "access_key_id" {}
variable "secret_key_id" {}
variable "region" {
  default = "eu-west-2"
}

variable "ssh_privkey_filename" {
  description = "The name of the file containning the private ssh key"
  default     = "outscale_sutKeyPair.rsa.txt"
}

variable "vm_type" {}
variable "client_vm_type" {}
variable "lb_vm_type" {}
