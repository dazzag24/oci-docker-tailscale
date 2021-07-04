# Outputs.tf Output the "list" of all availability domains.
/* output "all-availability-domains-for-your-compartment" {
  value = data.oci_identity_availability_domains.ads.availability_domains[0]
} 
 */
 # Output the "name" of the availability domain that will be used.
/* output "The-first-availability-domain-with-the-following-name-is-used-for-the-compute-instance" {
  value = data.oci_identity_availability_domains.ads.availability_domains[0].name
}  */
#Outputs for compute instance
output "public-ip-for-compute-instance" {
  value = oci_core_instance.ampere_instance.public_ip
} 
/* output "instance-name" {
  value = oci_core_instance.ampere_instance.display_name
} 
output "instance-OCID" {
  value = oci_core_instance.ampere_instance.id
} 
output "instance-region" {
  value = oci_core_instance.ampere_instance.region
} 
output "instance-shape" {
  value = oci_core_instance.ampere_instance.shape
} 
output "instance-state" {
  value = oci_core_instance.ampere_instance.state
} 
output "instance-OCPUs" {
  value = oci_core_instance.ampere_instance.shape_config[0].ocpus
} 
output "instance-memory-in-GBs" {
  value = oci_core_instance.ampere_instance.shape_config[0].memory_in_gbs
} 
output "time-created" {
  value = oci_core_instance.ampere_instance.time_created
} */
