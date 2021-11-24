# Description

This repo demonstrates how to use terraform and cloud-init to install and configure vaultwarden on an ARM Ampere instance. This instance type is "always free" on Oracle cloud.

In order to run vaultwarden we need to install and configure:

docker
docker-compose
caddy

We also install tailscale because it will allow us to access vaultwaden without using an public IP.


## Notes

https://gist.github.com/RagedUnicorn/a70f8540c68e0a41e3e097a2e29130f1



