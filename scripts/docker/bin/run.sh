#!/bin/sh

# Variables
# ~~~~~~
# Colours
C_RESET='\033[0m'
C_RED='\033[0;31m'
C_GREEN='\033[0;32m'
C_YELLOW='\033[1;33m'

# Set runtime port
APP_PORT=9080

# Set default image to build
APP_DEFAULT_IMAGE=zulu8
APP_IMAGE=$APP_DEFAULT_IMAGE

# Read arguments to pass to Docker image run
while getopts "i:" opts ; do
    case $opts in
        i)
            APP_IMAGE=${OPTARG}
            ;;
    esac
done

# Run the Docker image in a container
run_docker_run() {
    sudo docker run \
      -d \
      -p ${APP_PORT}:${APP_PORT} \
      --cpus="1" \
      --memory="4g" --memory-swap="4g" \
      http4s-${APP_IMAGE}:latest
}

# Run
# ~~~~~~
run_docker_run
