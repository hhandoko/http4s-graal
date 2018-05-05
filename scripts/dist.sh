#!/bin/sh

# Variables
# ~~~~~~
# Set distribution folder from first argument, otherwise default to `dist`
DIST_FOLDER=dist
if [ $# -gt 0 ] ; then
    DIST_FOLDER=$1
fi

# Set application version
APP_VERSION="`cat VERSION.txt`"

# Set artifact name
APP_JAR=http4s-graal-assembly-${APP_VERSION}.jar

# Compile and Packaging
# ~~~~~~
# Create distribution folder if it doesn't exist, and clear the contents
mkdir -p ${DIST_FOLDER}
rm -rf ${DIST_FOLDER}/*

# Create an uber-jar and copy the artifact to the distribution folder
sbt -mem 2048 assembly
cp target/scala-2.12/${APP_JAR} ${DIST_FOLDER}

# Create native image in the distribution folder
native-image -H:+ReportUnsupportedElementsAtRuntime -jar ${APP_JAR}
