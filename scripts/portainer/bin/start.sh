#!/bin/sh

# Run Portainer container
# See: https://portainer.io/install.html
docker_run() {
    docker run \
        -d `# Run detached` \
        -p 9000:9000 `# Bind and expose port` \
        -v /var/run/docker.sock:/var/run/docker.sock `# Mount Docker socket to access APIs` \
        -v portainer_data:/data portainer/portainer `# Mount volume`
}

# Run
# ~~~~~~
docker_run
