#!/bin/sh

# Pull latest Portainer image and create data volume
# See: https://portainer.io/install.html
setup_portainer() {
    (docker pull portainer/portainer:latest \
        && docker volume create portainer_data)
}

# Run
# ~~~~~~
setup_portainer
