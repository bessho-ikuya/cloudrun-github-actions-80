FROM php:8-fpm-buster AS runner

USER root

WORKDIR /var/www

RUN apt-get update \
  && apt-get install --no-install-recommends -y \
  nginx \
  curl \
  gcc \
  less \
  libzip-dev \
  ssl-cert \
  unzip \
  vim \
  mariadb-client \
  libfreetype6-dev \
  libjpeg62-turbo-dev \
  libpng-dev \
  && docker-php-ext-install sockets zip mysqli pdo_mysql \
  && docker-php-ext-enable mysqli sockets \
  && docker-php-ext-configure gd --with-freetype --with-jpeg \
  && docker-php-ext-install -j$(nproc) gd;

# laravelソースコード
COPY ./laravel ./

COPY ./php/php.ini /usr/local/etc/php/php.ini
COPY ./php/php-fpm.conf /usr/local/etc/php-fpm.d/docker.conf
COPY ./web/default.conf /etc/nginx/nginx.conf
COPY ./scripts ./scripts

RUN chmod -R a+w storage/ bootstrap/cache scripts

EXPOSE 80

CMD [ "sh", "./scripts/deploy.sh" ]