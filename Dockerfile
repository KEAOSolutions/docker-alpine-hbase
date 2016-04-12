FROM ukhomeoffice/openjdk8:latest

ARG HBASE_VERSION=1.1.4
ENV HBASE_VERSION $HBASE_VERSION
ARG HBASE_DOWNLOAD_URL=http://www.mirrorservice.org/sites/ftp.apache.org/hbase/${HBASE_VERSION}/hbase-${HBASE_VERSION}-bin.tar.gz
ENV HBASE_DOWNLOAD_URL $HBASE_DOWNLOAD_URL
ENV HBASE_HOME=/usr/share/hbase

RUN apk add --update curl bash
RUN curl -s ${HBASE_DOWNLOAD_URL} | tar zx -C /usr/share && \
    ln -s /usr/share/hbase-${HBASE_VERSION} $HBASE_HOME && \
    adduser -DH -s /sbin/nologin hbase && \
    chown -R hbase:hbase /usr/share/hbase
COPY hbase-site.xml /usr/share/hbase/conf/hbase-site.xml
COPY run.sh /usr/share/hbase/bin/run.sh
RUN chmod +x /usr/share/hbase/bin/run.sh
RUN apk del curl && \
    rm -rf /var/cache/apk/*

ENV PATH /usr/share/hbase/bin:$PATH

WORKDIR /usr/share/hbase

VOLUME /hbase-data

EXPOSE 34110 2181 16010
ENTRYPOINT ["run.sh"]
