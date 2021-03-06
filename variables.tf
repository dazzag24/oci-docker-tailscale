#*************************************
#           TF Requirements
#*************************************
variable "region" {
  default = "uk-london-1"
}
variable "instance_shape_config_ocpus" {
  default = 1
}
variable "instance_shape_config_memory_in_gbs" {
  default = 4
}
variable "tenancy_ocid" {
  type = string
}
variable "vnic_subnetid" {
  type = string
}
variable "user_ocid" {
  type = string
}
variable "private_key_path" {
  type = string
}
variable "fingerprint"{
  type = string
}
variable "compartment_ocid" {
  type = string
}
variable "ssh_public_key" {      
  type = string
}
variable "ssh_private_key" { 
  type = string
}
variable "tailscale_key" {
  type = string
}
variable "os_image_source_id" {
  type = string
}
variable "duckdns_token" {
  type = string
}
variable "duckdns_domain" {
  type = string
}
variable "caddy_acme_reg_email" {
  type = string
}
variable "caddy_domain_name" {
  type = string
}



