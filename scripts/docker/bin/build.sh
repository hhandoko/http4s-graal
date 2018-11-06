#!/bin/sh

# Variables
# ~~~~~~
# Colours
C_RESET='\033[0m'
C_RED='\033[0;31m'
C_GREEN='\033[0;32m'
C_YELLOW='\033[1;33m'

# Set distribution folder from first argument, otherwise default to `dist`
DIST_FOLDER=dist

# Set application version
APP_VER="`cat VERSION.txt`"

# Set artifact name
APP_NAME=http4s-graal-assembly-${APP_VER}
APP_JAR=${APP_NAME}.jar

# Set runtime port
APP_PORT=9080

# Set default image to build
APP_DEFAULT_IMAGE=zulu8
APP_IMAGE=$APP_DEFAULT_IMAGE

# Read arguments to pass to Docker image build
while getopts "i:d:" opts ; do
    case $opts in
        i)
            APP_IMAGE=${OPTARG}
            ;;
        d)
            DIST_FOLDER=${OPTARG}
            ;;
    esac
done

validate_image_prerequisites() {
    case $APP_IMAGE in
        zulu8)
            echo "${C_YELLOW}Selected '$APP_IMAGE' image${C_RESET}"
            if [ ! -f "${DIST_FOLDER}/${APP_JAR}" ] ; then
                echo "${C_RED}App jar is not found in '${DIST_FOLDER}'${C_RESET}"
                echo "Please run './scripts/graal/bin/dist.sh' to package the uber-jar"
                exit 1
            fi
            ;;
        graal)
            echo "${C_YELLOW}Selected '$APP_IMAGE' image${C_RESET}"
            if [ ! -f "${DIST_FOLDER}/${APP_NAME}" ] ; then
                echo "${C_RED}App executable is not found in '${DIST_FOLDER}'${C_RESET}"
                echo "Please run './scripts/graal/bin/dist.sh' to package the native executable"
                exit 1
            fi
            ;;
        *)
            echo "${C_RED}Unknown image '$APP_IMAGE' selected${C_RESET}"
            echo "Valid options are: graal, zulu8"
            exit 1
            ;;
    esac
}

# Build the Docker image
run_docker_build() {
    echo "${C_YELLOW}Building http4s '$APP_IMAGE' image${C_RESET}"
    sudo docker build \
      --build-arg APP_NAME=${APP_NAME}\
      --build-arg APP_PORT=${APP_PORT} \
      --no-cache \
      -t http4s-${APP_IMAGE}:latest \
      -f scripts/docker/dockerfiles/${APP_IMAGE}/Dockerfile \
      ${DIST_FOLDER}
}

# Run
# ~~~~~~
validate_image_prerequisites
run_docker_build
