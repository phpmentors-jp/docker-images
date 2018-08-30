#
# tomcat-app
#

FROM tomcat:7.0-jre8
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
RUN apt-get install -y openjdk-8-jdk

# Supervisor
RUN mkdir -p /var/log/supervisor
ADD supervisor/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Maven
ENV MAVEN_VERSION 3.3.9
ENV MAVEN_HOME /usr/share/maven
RUN curl -fsSLk https://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar xzf - -C /usr/share && mv /usr/share/apache-maven-$MAVEN_VERSION $MAVEN_HOME

# Tomcat
RUN sed -i "s/\(<tomcat-users>\)/\\1\\n  <role rolename=\"manager-gui\"\/>\\n  <role rolename=\"manager-script\"\/>\\n  <user username=\"admin\" password=\"\" roles=\"manager-gui,manager-script\"\/>/" /usr/local/tomcat/conf/tomcat-users.xml

# Tomcat application
ADD app/init /usr/local/sbin/app-init
RUN chmod 755 /usr/local/sbin/app-init
ADD app/mvn /usr/local/bin/mvn
RUN chmod 755 /usr/local/bin/mvn
ADD app/tomcat-jpda /usr/local/sbin/tomcat-jpda
RUN chmod 755 /usr/local/sbin/tomcat-jpda

# System
RUN dpkg-reconfigure -f noninteractive locales
ADD system/init /usr/local/sbin/system-init
RUN chmod 755 /usr/local/sbin/system-init
ADD system/locale.sh /usr/local/sbin/system-locale.sh
ADD system/timezone.sh /usr/local/sbin/system-timezone.sh

# Others
RUN mkdir -p /var/app
RUN echo "This file is a placeholder to expose /var/app directory after creating a new container from Kitematic." > /var/app/.placeholder
VOLUME ["/var/app"]

# Command
CMD ["/usr/local/sbin/system-init"]
