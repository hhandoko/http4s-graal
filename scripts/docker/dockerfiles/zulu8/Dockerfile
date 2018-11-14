FROM    azul/zulu-openjdk:8 as builder
LABEL   maintainer="Herdy Handoko <herdy.handoko@gmail.com>"
LABEL   description="http4s Azul Zulu 8 builder"

ARG     APP_NAME
ENV     APP_NAME ${APP_NAME:-http4s-graal-assembly}

RUN     (apt-get update \
          && apt-get -qq -y install curl)

WORKDIR builder
COPY    project/*.properties project/*.scala project/*.sbt project/
COPY    src/ src/
COPY    build.sbt VERSION.txt ./
RUN     (SBT_VERSION=$(cat project/build.properties | cut -d '=' -f 2 | tr -d '[:space:]') \
          && curl -L -O https://piccolo.link/sbt-${SBT_VERSION}.tgz \
          && tar -xzf sbt-${SBT_VERSION}.tgz \
          && ./sbt/bin/sbt -mem 4096 sbtVersion)
RUN     ./sbt/bin/sbt -mem 4096 clean assembly

# ~~~~~~

FROM    azul/zulu-openjdk:8
LABEL   maintainer="Herdy Handoko <herdy.handoko@gmail.com>"
LABEL   description="http4s on Azul Zulu 8 web service"

ARG     APP_NAME
ENV     APP_NAME ${APP_NAME:-http4s-graal-assembly}
ARG     APP_PORT
ENV     APP_PORT ${APP_PORT:-8080}

WORKDIR app
COPY    --from=builder builder/target/scala-2.12/${APP_NAME}.jar .

EXPOSE  $APP_PORT
CMD     java -Xmx4096m -jar ${APP_NAME}.jar
