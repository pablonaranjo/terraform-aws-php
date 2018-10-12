FROM richarvey/nginx-php-fpm

RUN apk add alpine-sdk
RUN apk add iptables
RUN apk add msmtp
RUN apk add php-pgsql
RUN apk add php7-pdo_pgsql
RUN apk add postgresql-dev
RUN apk --update add postgresql

RUN docker-php-ext-install pgsql

RUN ln -sf /usr/bin/msmtp /usr/sbin/sendmail
RUN echo "nginx ALL=(ALL) NOPASSWD: /sbin/iptables" >> /etc/sudoers

COPY msmtprc /etc/msmtprc
COPY index.php /var/www/html/index.php
COPY default.conf /etc/nginx/sites-available/default.conf
COPY blacklisted.php /var/www/html/blacklisted/index.php
