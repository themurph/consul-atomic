#FROM docker-registry.usersys.redhat.com/atomicga/rhel-server-docker-7.1-9.x86_64
FROM centos

MAINTAINER Chris Murphy <chmurphy@redhat.com>

ENV CONSUL_VERSION 0.5.0
ENV container docker

LABEL Version=1.0
LABEL Vendor="Red Hat"

#LABEL INSTALL="docker run --rm --privileged -v /:/host -e HOST=/    host -e IMAGE=IMAGE -e NAME=NAME IMAGE /usr/bin/install.sh"
#LABEL UNINSTALL="docker run --rm --privileged -v /:/host -e HOST=/  host -e IMAGE=IMAGE -e NAME=NAME IMAGE /usr/bin/uninstall.sh"
#LABEL ONETIME=docker run -p 8500:8500 -p 53:53/udp --name atomic-node1 -h atomic-node1 -v /consul/data:/consul/data:rw -v /consul/config:/consul/config:rw atomic-consul -server -bootstrap -data-dir=/consul/data -ui-dir=/consul/ui
#LABEL RUN="docker run --privileged -p 8400:8400 -p 8500:8500 -p 8600:53/udp --name HOST -h HOST -v /consul/data:/consul/data:rw -v /consul/config:/consul/config consul-template.cfg:/etc/consul-template/config.cfg -v /var/lib/etcd:/var/lib/etcd IMAGE"


RUN cd /tmp \
    && yum -y update \
    && yum install -y wget unzip \
    && wget https://dl.bintray.com/mitchellh/consul/${CONSUL_VERSION}_linux_amd64.zip \
    && unzip ${CONSUL_VERSION}_linux_amd64.zip \
    && mv -vf consul /usr/bin/consul \
    && chmod 755 /usr/bin/consul \
    && wget https://dl.bintray.com/mitchellh/consul/${CONSUL_VERSION}_web_ui.zip \
    && unzip ${CONSUL_VERSION}_web_ui.zip \
    && mkdir -p /consul/ui /consul/data /consul/config \
    && mv -vf dist/* /consul/ui/ \
    && rm ${CONSUL_VERSION}_web_ui.zip dist/.gitkeep \
    && rmdir dist \
    && yum clean all

EXPOSE 8300 8301 8301/udp 8302 8302/udp 8400 8500 8600

VOLUME ["/consul/data"]

ENTRYPOINT ["/usr/bin/consul", "agent", "-config-dir=/consul/config"]

CMD ["/usr/bin/consul", "agent", "-server", "-bootstrap", "-config-dir /consul/config", "-data-dir /consul/data", "-ui-dir /conlul/ui"]

#CMD ["/usr/bin/consul", "agent", "-config-dir=/consul/config"]
