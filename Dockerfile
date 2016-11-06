FROM ubuntu:16.04
ENV DEBIAN_FRONTEND noninteractive


EXPOSE 8080

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y python-twisted

COPY . /app/
WORKDIR /app/

RUN useradd eth-proxy && echo "eth-proxy:eth-proxy" | chpasswd
RUN chown -R eth-proxy:eth-proxy /app
USER eth-proxy

# Metadata params
ARG BUILD_DATE
ARG VERSION
ARG VCS_URL
ARG VCS_REF
# Metadata
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="eth-proxy" \
      org.label-schema.description="Running ethminer in docker container" \
      org.label-schema.url="https://etherchain.org/" \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vendor="AnyBucket" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0" \
      com.microscaling.docker.dockerfile="/Dockerfile"

ENTRYPOINT ["python", "/app/eth-proxy.py"]
CMD [""]
