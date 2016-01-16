#
# node-browser-app
#

FROM node:5.4.1
MAINTAINER KUBO Atsuhiro <kubo@iteman.jp>

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y locales
RUN apt-get install -y apt-utils
RUN apt-get install -y supervisor
RUN apt-get install -y git
RUN apt-get install -y less vim-tiny
RUN apt-get install -y sudo

# Supervisor
RUN mkdir -p /var/log/supervisor
ADD supervisor/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# System
RUN dpkg-reconfigure -f noninteractive locales
ADD system/init /usr/local/sbin/system-init
RUN chmod 755 /usr/local/sbin/system-init
ADD system/locale.sh /usr/local/sbin/system-locale.sh
ADD system/timezone.sh /usr/local/sbin/system-timezone.sh

# Others
RUN mkdir /var/app
RUN echo "This file is a placeholder to expose /var/app directory after creating a new container from Kitematic." > /var/app/.placeholder
RUN mkdir /var/deploy
RUN echo "This file is a placeholder to expose /var/app directory after creating a new container from Kitematic." > /var/deploy/.placeholder
VOLUME ["/var/app", "/var/deploy"]

# Command
CMD ["/usr/local/sbin/system-init"]
