#
# mysql
#

FROM mysql:5.6
MAINTAINER KUBO Atsuhiro <kubo@iteman.jp>

# MySQL
ADD config/characterset.cnf /etc/mysql/conf.d/characterset.cnf
ADD bin/configure-character-set-and-timezone.sh /tmp/configure-character-set-and-timezone.sh
RUN cat /tmp/configure-character-set-and-timezone.sh /entrypoint.sh | sed -e 's/^#!\/bin\/bash//' > /new-entrypoint.sh
RUN sed -i '1i #!/bin/bash' /new-entrypoint.sh && cp /new-entrypoint.sh /entrypoint.sh && rm /new-entrypoint.sh
