#!/bin/sh

# Variables
# ~~~~~~
# Colours
C_RESET='\033[0m'
C_RED='\033[0;31m'
C_GREEN='\033[0;32m'
C_YELLOW='\033[1;33m'

# Gatling path
GATLING_DIR=scripts/gatling
GATLING_VERSION=`cat ${GATLING_DIR}/VERSION.txt`
GATLING_HOME=${GATLING_DIR}/sdk/gatling-charts-highcharts-bundle-${GATLING_VERSION}

# Run gatling simulations
run_gatling() {
    ${GATLING_HOME}/bin/gatling.sh
}

# Run
# ~~~~~~
run_gatling
