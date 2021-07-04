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

data "template_file" "setup-docker-compose" {
  template = file("./user_data/oci-init.yaml.tpl")  
  vars = {
    tailscale_key = var.tailscale_key
  }
} 

resource "oci_core_instance" "ampere_instance" {
    # Required
    availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
    compartment_id = var.tenancy_ocid
    
    # Display name of instance
    display_name = "test-ampere-instance"
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
        hostname_label = "ampere"
        subnet_id = var.vnic_subsetid
    }

    metadata = {
        user_data = base64encode(data.template_file.setup-docker-compose.rendered)
        ssh_authorized_keys = var.ssh_public_key
    }
    preserve_boot_volume = false
}
