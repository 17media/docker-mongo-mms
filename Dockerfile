FROM        ubuntu:16.04

ARG         MMS_VERSION=latest

RUN         apt-get update && \
            apt-get install -y curl logrotate && \
            curl -L https://cloud.mongodb.com/download/agent/monitoring/mongodb-mms-monitoring-agent_${MMS_VERSION}_$(dpkg --print-architecture).ubuntu1604.deb > /tmp/mongodb-mms.deb && \
            dpkg -i /tmp/mongodb-mms.deb && \
            rm -rf /tmp/* && \
            rm -rf /var/lib/apt/lists/*

COPY        entrypoint.sh /
RUN         chmod +x /entrypoint.sh

ENTRYPOINT  ["/entrypoint.sh"]
CMD         ["mongodb-mms-monitoring-agent", "-conf", "/etc/mongodb-mms/monitoring-agent.config"]
