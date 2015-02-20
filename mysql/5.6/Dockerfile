#
# mysql
#

FROM mysql:5.6
MAINTAINER KUBO Atsuhiro <kubo@iteman.jp>

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y locales
RUN apt-get install -y apt-utils

# MySQL
ADD config/characterset.cnf /etc/mysql/conf.d/characterset.cnf
ADD mysql/init /usr/local/sbin/mysql-init
RUN sed -i 's/^\(#!\/bin\/bash\)/\1\n\/usr\/local\/sbin\/system-init/' /entrypoint.sh

# System
RUN dpkg-reconfigure -f noninteractive locales
ADD system/init /usr/local/sbin/system-init
RUN chmod 755 /usr/local/sbin/system-init
ADD system/locale.sh /usr/local/sbin/system-locale.sh
ADD system/timezone.sh /usr/local/sbin/system-timezone.sh
