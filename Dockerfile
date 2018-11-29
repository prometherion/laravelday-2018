FROM composer:1.7.3 AS composer

FROM php:7.2-fpm-alpine AS build
WORKDIR /var/www
USER www-data
COPY --from=composer /usr/bin/composer /usr/bin/composer
COPY --chown=www-data ./ ./
RUN composer install --no-ansi --no-dev --no-interaction --optimize-autoloader

FROM php:7.2-fpm-alpine
RUN echo 'cgi.fix_pathinfo=0'>/usr/local/etc/php/php.ini
WORKDIR /var/www
USER www-data
COPY --from=build --chown=www-data /var/www ./