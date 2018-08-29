ARG PYTHON_VERSION=3.5
ARG ALPINE_VERSION=3.6
FROM alpine:${ALPINE_VERSION} AS client
ARG ORACLE_VERSION=12.2.0.1.0
ARG ORACLE_ZIP_INTERNAL_FOLDER=instantclient_12_2
WORKDIR /root
ENV CLIENT_ZIP=instantclient-basiclite-linux.x64-${ORACLE_VERSION}.zip
ENV SDK_ZIP=instantclient-sdk-linux.x64-${ORACLE_VERSION}.zip

RUN apk --no-cache add unzip
COPY ${CLIENT_ZIP} .
COPY ${SDK_ZIP} .
RUN unzip ${CLIENT_ZIP}
RUN unzip ${SDK_ZIP}
RUN mv ${ORACLE_ZIP_INTERNAL_FOLDER} oracle

FROM python:${PYTHON_VERSION}-alpine${ALPINE_VERSION}
LABEL maintainer=john@jjgoodwin.com
ARG ORACLE_VERSION=12.2.0.1.0
ENV HOME /root
ENV ORACLE_HOME /opt/oracle
ENV TNS_ADMIN ${ORACLE_HOME}/network/admin
VOLUME ["${TNS_ADMIN}"]

COPY --from=client /root/oracle ${ORACLE_HOME}
RUN apk --no-cache add libaio \
	# Install Oracle Instant Client
	&& mkdir -p /etc/ld.so.conf.d \
	&& echo ${ORACLE_HOME} > /etc/ld.so.conf.d/oracle.conf \
	&& mkdir -p ${TNS_ADMIN} \
	&& ldconfig /etc/ld.so.conf.d/
