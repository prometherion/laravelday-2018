FROM composer:1.7.3 AS composer

FROM php:7.2-fpm-alpine
WORKDIR /var/www
COPY --from=composer /usr/bin/composer /usr/bin/composer
RUN echo 'cgi.fix_pathinfo=0'>/usr/local/etc/php/php.ini
COPY --chown=www-data ./ ./