FROM    oracle/graalvm-ce:1.0.0-rc14 as builder
LABEL   maintainer="Herdy Handoko <herdy.handoko@gmail.com>"
LABEL   description="http4s Graal builder"

ARG     APP_NAME
ENV     APP_NAME ${APP_NAME:-http4s-graal-assembly}

WORKDIR builder
COPY    project/*.properties project/*.scala project/*.sbt project/
COPY    src/ src/
COPY    build.sbt VERSION.txt ./
RUN     (SBT_VERSION=$(cat project/build.properties | cut -d '=' -f 2 | tr -d '[:space:]') \
          && curl -L -O https://piccolo.link/sbt-${SBT_VERSION}.tgz \
          && tar -xzf sbt-${SBT_VERSION}.tgz \
          && ./sbt/bin/sbt -mem 4096 sbtVersion)
RUN     ./sbt/bin/sbt -mem 4096 clean assembly
RUN     native-image -H:+ReportUnsupportedElementsAtRuntime -jar target/scala-2.12/${APP_NAME}.jar

# ~~~~~~

FROM    oraclelinux:7-slim
LABEL   maintainer="Herdy Handoko <herdy.handoko@gmail.com>"
LABEL   description="http4s Graal native image web service"

ARG     APP_NAME
ENV     APP_NAME ${APP_NAME:-http4s-graal-assembly}
ARG     APP_PORT
ENV     APP_PORT ${APP_PORT:-8080}

WORKDIR app
COPY    --from=builder builder/${APP_NAME} .

EXPOSE  $APP_PORT
CMD     ./${APP_NAME}
