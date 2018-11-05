#!/bin/sh

# Variables
# ~~~~~~
# Colours
C_RESET='\033[0m'
C_RED='\033[0;31m'
C_GREEN='\033[0;32m'
C_YELLOW='\033[1;33m'

# Temp folder
TEMP_DIR=tmp

# Gatling path
GATLING_DIR=scripts/gatling
GATLING_VERSION=`cat ${GATLING_DIR}/VERSION.txt`
GATLING_HOME=${GATLING_DIR}/sdk/gatling-charts-highcharts-bundle-${GATLING_VERSION}

# Gatling download
GATLING_FILE=gatling-charts-highcharts-bundle-${GATLING_VERSION}-bundle.zip
GATLING_SITE=https://repo1.maven.org/maven2/io/gatling/highcharts/gatling-charts-highcharts-bundle/${GATLING_VERSION}/${GATLING_FILE}

# Download Gatling SDK
setup_gatling() {
    if [ ! -d "${GATLING_HOME}" ] ; then
        if [ ! -f "${TEMP_DIR}/${GATLING_FILE}" ] ; then
            echo "${C_YELLOW}Downloading Gatling zip${C_RESET}"
            (mkdir -p ${TEMP_DIR} \
                && cd ${TEMP_DIR} \
                && curl -L -O ${GATLING_SITE})
        fi

        echo "${C_YELLOW}Unpacking Gatling${C_RESET}"
        (mkdir -p ${GATLING_HOME} \
            && cd ${TEMP_DIR} \
            && unzip ${GATLING_FILE} -d ../${GATLING_DIR}/sdk)
    else
        echo "${C_YELLOW}Skipping setup: Gatling already downloaded${C_RESET}"
    fi

    if [ -d "${GATLING_HOME}/user-files/simulations/computerdatabase" ] ; then
        echo "${C_YELLOW}Removing default simulations${C_RESET}"
        rm -rf ${GATLING_HOME}/user-files/simulations/computerdatabase
    fi

    echo "${C_YELLOW}Copying http4s-graal simulations to 'user-files'${C_RESET}"
    cp -rf ${GATLING_DIR}/simulations ${GATLING_HOME}/user-files
}

# Run
# ~~~~~~
setup_gatling
