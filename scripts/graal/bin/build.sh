#!/bin/sh

# Set distribution folder from first argument, otherwise default to `dist`
DIST_FOLDER=dist
if [ $# -gt 0 ] ; then
    DIST_FOLDER=$1
fi

# Set application version
APP_VER="`cat VERSION.txt`"

# Set artifact name
APP_NAME=http4s-graal-assembly-${APP_VER}
APP_JAR=${APP_NAME}.jar

# Set runtime port
APP_PORT=9080

# Build the Docker image
sudo docker build \
  --build-arg APP_NAME=${APP_NAME}\
  --build-arg APP_PORT=${APP_PORT} \
  --no-cache \
  -t http4s-zulu8:latest \
  -f scripts/docker/zulu8/Dockerfile \
  ${DIST_FOLDER}

# Run the Docker image in a container
sudo docker run \
  -d \
  -p ${APP_PORT}:${APP_PORT} \
  --cpus="1" \
  --memory="4g" --memory-swap="4g" \
  http4s-zulu8:latest
