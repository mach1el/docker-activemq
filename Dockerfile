FROM openjdk:bullseye

ENV ACTIVEMQ_VERSION 5.16.6
ENV ACTIVEMQ apache-activemq-$ACTIVEMQ_VERSION
ENV ACTIVEMQ_HOME /opt/activemq

RUN wget -O $ACTIVEMQ-bin.tar.gz https://dlcdn.apache.org//activemq/$ACTIVEMQ_VERSION/apache-activemq-$ACTIVEMQ_VERSION-bin.tar.gz && \
    tar -xvzf $ACTIVEMQ-bin.tar.gz && \
    rm -f $ACTIVEMQ-bin.tar.gz && \
    mv $ACTIVEMQ $ACTIVEMQ_HOME && \
    useradd -r -M -d $ACTIVEMQ_HOME activemq && \
    chown -R activemq:activemq $ACTIVEMQ_HOME && \
    chown -h activemq:activemq $ACTIVEMQ_HOME 

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

USER activemq

WORKDIR $ACTIVEMQ_HOME
ENTRYPOINT ["/entrypoint.sh"]