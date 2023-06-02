FROM eclipse-mosquitto:1.6

# Generated SSL certificates will be placed inside $CERTS_ROOT/certs
ENV CERTS_ROOT /etc/mosquitto

RUN apk update && apk add --no-cache curl python3 openssl ca-certificates bash \
	&& rm -rf /var/cache/apk/*

ADD ./createCerts.sh ${CERTS_ROOT}/createCerts.sh
ADD ./docker-entrypoint-custom.sh /
ADD ./mosquitto.conf /mosquitto/config/mosquitto.conf

ENTRYPOINT [ "/docker-entrypoint-custom.sh"]