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
    - python3-devel

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

output : { all : '| tee -a /var/log/cloud-init-output.log' }

runcmd:
  - [ service, docker, start ] 
  - [ systemctl, enable, --now, tailscaled ]
  #- [ tailscale, up, --authkey, "${tailscale_key}" ]
  - [ wget, -O, /home/opc/caddy, "https://caddyserver.com/api/download?os=linux&arch=arm64&p=github.com%2Fcaddy-dns%2Fduckdns&idempotency=54695838413980" ]
  - [ chmod, a+x, /home/opc/caddy ]
  - [ chown, opc:opc, /home/opc/caddy ]
  - [ python3.6, -m, pip, install, -U, pip ]
  - [ su, opc, -c, "python3.6 -m pip install setuptools cryptography docker-compose" ]
  - [ su, opc, -c, "docker pull vaultwarden/server:latest" ]
  #- [ docker-compose, up, -d ]

final_message: "The system is finally up, after $UPTIME seconds"

