FROM centos:7
MAINTAINER Tobias Brunner <tobias@tobru.ch>

ENV OTR_STORAGEDIR="/var/spool/owntracks/recorder/store"

RUN curl -o /etc/yum.repos.d/mosquitto.repo http://download.opensuse.org/repositories/home:/oojah:/mqtt/CentOS_CentOS-7/home:oojah:mqtt.repo && \
    curl -o /etc/yum.repos.d/owntracks.repo http://repo.owntracks.org/centos/owntracks.repo && \
    curl -o /usr/local/bin/dumb-init -L https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64 && \
    chmod +x /usr/local/bin/dumb-init && \
    yum -y install ot-recorder && \
    yum clean all && \
    mkdir -p /var/spool/owntracks/recorder/store && \
    chgrp -R 0 /var/spool/owntracks/recorder/store && \
    chmod -R g+rwX /var/spool/owntracks/recorder/store

VOLUME /var/spool/owntracks/recorder/store
EXPOSE 8083

COPY recorder-health.sh /usr/local/sbin/recorder-health.sh
HEALTHCHECK CMD /usr/local/sbin/recorder-health.sh

ENTRYPOINT ["dumb-init", "/usr/sbin/ot-recorder", "--http-host", "0.0.0.0"]
