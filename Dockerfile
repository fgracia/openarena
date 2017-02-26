FROM debian:jessie

MAINTAINER Frederic GRACIA <gracia.frederic@gmail.com>

# Install packages
RUN apt-get update && apt-get install -y curl unzip

# Download and unzip OpenArena
RUN curl -o /tmp/openarena.zip http://download.tuxfamily.org/openarena/rel/088/openarena-0.8.8.zip
RUN cd /tmp && unzip /tmp/openarena.zip -d /opt && rm -f openarena.zip

# Add config files
ADD ./conf/server1.cfg /opt/openarena-0.8.8/baseoa/server1.cfg
ADD ./conf/maprotation1.cfg /opt/openarena-0.8.8/baseoa/maprotation1.cfg
ADD ./conf/motd.cfg /opt/openarena-0.8.8/baseoa/motd.cfg

# Add startup script
ADD startup.sh /opt/startup.sh
RUN chmod +x /opt/startup.sh

# Expose ports
EXPOSE 27950/udp
EXPOSE 27960/udp

# Run startup script
CMD /opt/startup.sh
