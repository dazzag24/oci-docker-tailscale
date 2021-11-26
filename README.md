# Description

This repo demonstrates how to use terraform and cloud-init to install and configure vaultwarden on an ARM Ampere instance. This instance type is "always free" on the Oracle cloud [free tier](https://docs.oracle.com/en-us/iaas/Content/FreeTier/freetier.htm).

In order to run vaultwarden we need to install and configure:

docker
docker-compose
caddy

We also install tailscale because it will allow us to access vaultwaden without using an public IP.


## Notes

https://gist.github.com/RagedUnicorn/a70f8540c68e0a41e3e097a2e29130f1


## OCI CLI

Install the OCI CLI
https://learncodeshare.net/2020/03/06/install-and-configure-the-oracle-cloud-command-line-interface/

Using defaults to avoid having to specify the compartment_id repeatedly:
https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/cliconfigure.htm#UsingaFileforCLIConfigurations

Get public IP
https://learncodeshare.net/2020/06/18/create-and-use-an-oracle-cloud-compute-instance-from-the-command-line/

export COMPUTE_IP=$(oci compute instance list-vnics \
  --instance-id "${COMPUTE_OCID}" \
  --query 'data[0]."public-ip"' \
  --raw-output)

echo $COMPUTE_IP

or via Python API:
https://github.com/oracle/oci-python-sdk/blob/master/examples/get_all_instance_ip_addresses_and_dns_info.py


