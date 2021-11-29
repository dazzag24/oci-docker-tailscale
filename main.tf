# Configure the OCI provider with an API Key
# tenancy_ocid is the compartment OCID for the root compartment
provider "oci" {
  tenancy_ocid = var.tenancy_ocid
  user_ocid = var.user_ocid
  fingerprint = var.fingerprint
  private_key_path = var.private_key_path
  region = var.region
}

# Get a list of Availability Domains
data "oci_identity_availability_domains" "ads" {
  compartment_id = var.tenancy_ocid
}

# Output the result
/* output "show-ads" {
  value = data.oci_identity_availability_domains.ads.availability_domains
} */

data "template_file" "setup-vaultwarden" {
  template = file("./user_data/vaultwarden.yaml")  
  vars = {
    tailscale_key = var.tailscale_key
    caddy_domain_name = var.caddy_domain_name
    caddy_acme_reg_email = var.caddy_acme_reg_email
    duckdns_token = var.duckdns_token
    duckdns_domain = var.duckdns_domain
  }
} 

resource "oci_core_instance" "ampere_instance" {
    # Required
    availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
    compartment_id = var.tenancy_ocid
    
    # Display name of instance
    display_name = "vaultwarden-ampere"
    shape = "VM.Standard.A1.Flex"
    shape_config {
        # baseline_ocpu_utilization = var.instance_shape_config_baseline_ocpu_utilization
        memory_in_gbs = var.instance_shape_config_memory_in_gbs
        ocpus = var.instance_shape_config_ocpus
    }
    source_details {
        source_id = var.os_image_source_id
        source_type = "image"
    }
 
    # Optional - Public Subnet of VNIC that has already been created.
    create_vnic_details {
        assign_public_ip = true
        hostname_label = "vaultwarden"
        subnet_id = var.vnic_subnetid
    }

    metadata = {
        user_data = base64encode(data.template_file.setup-vaultwarden.rendered)
        ssh_authorized_keys = var.ssh_public_key
    }
    preserve_boot_volume = false
}
