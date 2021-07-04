#cloud-config
# vim: syntax=yaml
#

yum_repos:
  # The name of the repository
  tailscale:
    # Any repository configuration options
    # See: man yum.conf
    #
    # This one is required!
    baseurl: https://pkgs.tailscale.com/stable/centos/7/$basearch
    enabled: true
    failovermethod: priority
    gpgcheck: false
    gpgkey: https://pkgs.tailscale.com/stable/centos/7/repo.gpg
    name: Tailscale

#cloud-config
package_upgrade: true

packages:
    - docker
    - yum-utils
    - tailscale

# create the docker group
groups:
    - docker

# Add default auto created user to docker group
system_info:
    default_user:
        groups: [docker]

# assign a VM's default user, which is opc, to the docker group
users:
    - default
    - name: opc
      groups: docker

runcmd:
  - service docker start 
  - service tailscaled start
  - [ tailscale, up, --authkey, "${tailscale_key}" ]
  - touch ~opc/userdata.`date +%s`.end
