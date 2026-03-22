FROM alpine:3.22

RUN apk update && apk add --no-cache python3

COPY ./srcs/ /var/www/static/

CMD [ "python3" , "-m", "http.server", "8081","--directory", "/var/www/static/" ]