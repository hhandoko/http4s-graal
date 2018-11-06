FROM    oracle/graalvm-ce:1.0.0-rc9 as builder
LABEL   maintainer="Herdy Handoko <herdy.handoko@gmail.com>"
LABEL   description="http4s Graal native image builder"

ARG     APP_NAME
ENV     APP_NAME ${APP_NAME:-http4s-graal-assembly}

WORKDIR builder
ADD     ${APP_NAME}.jar .
RUN     native-image -H:+ReportUnsupportedElementsAtRuntime -jar ${APP_NAME}.jar

# ~~~~~~

FROM    oracle/graalvm-ce:1.0.0-rc9
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
