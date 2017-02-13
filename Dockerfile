FROM blitznote/debootstrap-amd64:16.04
MAINTAINER Karl Tiedt <ktiedt@gmail.com>

#Based on the work of needo <needo@superhero.org>
#
#########################################
##        ENVIRONMENTAL CONFIG         ##
#########################################

# Set correct environment variables
ENV DEBIAN_FRONTEND noninteractive
ENV HOME            /root

#########################################
##  FILES, SERVICES AND CONFIGURATION  ##
#########################################

# Add services to runit
COPY couchpotato.sh /etc/service/couchpotato/run
COPY edge.sh /etc/my_init.d/edge.sh

# Configure and setup everything
RUN useradd ktiedt -u 1000 \
    && apt-get update -q && apt-get install -qy \
        software-properties-common \
    && add-apt-repository "deb http://us.archive.ubuntu.com/ubuntu/ xenial universe multiverse" \
    && add-apt-repository "deb http://us.archive.ubuntu.com/ubuntu/ xenial-updates universe multiverse" \
    && apt-get update -q \
    && apt-get install -qy \
        git \
        python \
        unrar \
    && mkdir -p /opt \
    && cd /opt \
    && git clone https://github.com/ktiedt/CouchPotatoServer.git couchpotato \
    && cd couchpotato \
    && git checkout QualityPluginFix \
    && git pull \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* /var/cache/* /var/tmp/* \
    && chmod +x /etc/service/*/run /etc/my_init.d/* \
    && chown -R ktiedt:ktiedt /opt

#########################################
##         EXPORTS AND VOLUMES         ##
#########################################

VOLUME /config
VOLUME /media

EXPOSE 5050

# Start the service
ENTRYPOINT ["/bin/bash", "/etc/service/couchpotato/run"]
