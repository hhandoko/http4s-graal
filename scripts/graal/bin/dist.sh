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
if [ $# -gt 0 ] ; then
    DIST_FOLDER=$1
fi

# Set application version
APP_VERSION="`cat VERSION.txt`"

# Set artifact name
APP_NAME=http4s-graal-assembly-${APP_VERSION}
APP_JAR=${APP_NAME}.jar

# Graal version and path
GRAAL_DIR=scripts/graal
GRAAL_VERSION=`cat ${GRAAL_DIR}/VERSION.txt`
GRAAL_HOME=${GRAAL_DIR}/sdk/graalvm-${GRAAL_VERSION}

# Create distribution folder if it doesn't exist, and clear the contents
clean_dist_folder() {
    mkdir -p ${DIST_FOLDER}
    rm -rf ${DIST_FOLDER}/*
}

# Create an uber-jar and copy the artifact to the distribution folder
create_assembly() {
    echo "${C_YELLOW}Packaging into uber-jar${C_RESET}"
    sbt -mem 2048 assembly
    cp target/scala-2.12/${APP_JAR} ${DIST_FOLDER}
}

# Create native image in the distribution folder
create_native() {
    if [ ! -d "${GRAAL_HOME}" ] ; then
        echo "${C_RED}GRAAL_HOME does not exist${C_RESET}"
        echo "Please run './scripts/graal/setup.sh' to setup Graal"
        exit 1
    fi

    echo "${C_YELLOW}Packaging into native image${C_RESET}"
    (cd ${DIST_FOLDER} \
        && ../${GRAAL_HOME}/bin/native-image -H:+ReportUnsupportedElementsAtRuntime -jar ${APP_JAR})
}

# Run
# ~~~~~~
clean_dist_folder
create_assembly
create_native
