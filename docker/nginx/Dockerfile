FROM alpine:3.22

RUN apk update && apk add --no-cache nginx openssl && mkdir /etc/nginx/ssl \ 
    && openssl req -x509 -nodes -days 365 -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=lflayeux.42.fr/UID=lflayeux" \
    && apk del openssl

COPY ./nginx.conf /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]