FROM    azul/zulu-openjdk:8
LABEL   maintainer="Herdy Handoko <herdy.handoko@gmail.com>"
LABEL   description="http4s on Azul Zulu 8 web service"

ARG     APP_NAME
ENV     APP_NAME ${APP_NAME:-http4s-graal-assembly}
ARG     APP_PORT
ENV     APP_PORT ${APP_PORT:-8080}

WORKDIR app
ADD     ${APP_NAME}.jar .

EXPOSE  $APP_PORT
CMD     java -jar ${APP_NAME}.jar
