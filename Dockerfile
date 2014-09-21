# Couchbase
#
# VERSION 1.0

FROM ubuntu:12.04
MAINTAINER Ian Blenke <ian@blenke.com>

ENV CB_VERSION 2.2.0
ENV CB_RELEASE_URL http://packages.couchbase.com/releases
ENV CB_PACKAGE couchbase-server-community_${CB_VERSION}_x86_64.deb
ENV CB_USERNAME Administrator
ENV CB_PASSWORD couchbase

# Install couchbase
RUN apt-get update && \
    export DEBIAN_FRONTEND=noninteractive && \
    apt-get install -y wget apt-utils librtmp0 && \
    export FILE=`mktemp` && \
    wget $CB_RELEASE_URL/$CB_VERSION/$CB_PACKAGE -qO $FILE && \
    dpkg -i $FILE && \
    rm $FILE

RUN ln -s /opt/couchbase/bin/couchbase-cli /usr/local/bin/

# Put start script
ADD sources/couchbase-start /usr/local/bin/

# See http://docs.couchbase.com/couchbase-manual-2.5/cb-install/#xdcr
EXPOSE 8091 8092 4369 11209 11210 11211 21100:21299

USER root
CMD couchbase-start
