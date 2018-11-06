FROM    oracle/graalvm-ce:1.0.0-rc9

ARG     APP_NAME
ENV     APP_NAME ${APP_NAME:-http4s-graal-assembly}
ARG     APP_PORT
ENV     APP_PORT ${APP_PORT:-8080}

WORKDIR app
ADD     ${APP_NAME}.jar .
RUN     native-image -H:+ReportUnsupportedElementsAtRuntime -jar ${APP_NAME}.jar

EXPOSE  $APP_PORT
CMD     ./${APP_NAME}
