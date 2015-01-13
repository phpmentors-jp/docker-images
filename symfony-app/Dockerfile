#
# symfony-app
#

FROM ubuntu:14.04
MAINTAINER KUBO Atsuhiro <kubo@iteman.jp>

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y apt-utils
RUN apt-get install -y supervisor
RUN apt-get install -y apache2-mpm-prefork
RUN apt-get install -y mysql-client-core-5.6
RUN apt-get install -y php5 php5-curl php5-intl php5-mysql php5-xdebug
RUN apt-get install -y git
RUN apt-get install -y less vim-tiny
RUN apt-get install -y apg
RUN apt-get install -y sudo

# Supervisor
RUN mkdir -p /var/log/supervisor
ADD supervisor/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Apache2
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
EXPOSE 80
ADD apache2/app.conf /etc/apache2/sites-available/000-default.conf
ADD apache2/apache2.sh /usr/local/sbin/symfony-app-apache2.sh
RUN chmod 755 /usr/local/sbin/symfony-app-apache2.sh

# PHP5
ADD php5/app.ini /etc/php5/apache2/conf.d/90-app.ini
ADD php5/app.ini /etc/php5/cli/conf.d/90-app.ini

# Symfony application
ADD app/app-init.sh /usr/local/sbin/symfony-app-init.sh
RUN chmod 755 /usr/local/sbin/symfony-app-init.sh
ADD app/composer /usr/local/bin/composer
RUN chmod 755 /usr/local/bin/composer
RUN chown root.root /usr/local/bin/composer
ADD app/console /usr/local/bin/console
RUN chmod 755 /usr/local/bin/console
RUN chown root.root /usr/local/bin/console
ENV APP_RUN_MODE dev

# Others
ENV HOME /root
WORKDIR /root

# Command
CMD ["/usr/bin/supervisord"]
