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

# ~~~~~~

FROM    oracle/graalvm-ce:1.0.0-rc14
LABEL   maintainer="Herdy Handoko <herdy.handoko@gmail.com>"
LABEL   description="http4s on Graal VM web service"

ARG     APP_NAME
ENV     APP_NAME ${APP_NAME:-http4s-graal-assembly}
ARG     APP_PORT
ENV     APP_PORT ${APP_PORT:-8080}

WORKDIR app
COPY    --from=builder builder/target/scala-2.12/${APP_NAME}.jar .

EXPOSE  $APP_PORT
CMD     java -Xmx4096m -jar ${APP_NAME}.jar
