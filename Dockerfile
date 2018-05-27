FROM php:5.6-apache

RUN export APACHE_RUN_USER=root

# install the PHP extensions we need
RUN apt-get update && \
    # apt-get install -y libpng-dev libjpeg-dev sqlite3 libsqlite3-dev && \
    apt-get install -y libpng-dev libjpeg-dev && \
    rm -rf /var/lib/apt/lists/* && \
    docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr && \
    docker-php-ext-install gd mysqli opcache

# set recommended PHP.ini settings
# see https://secure.php.net/manual/en/opcache.installation.php
RUN { \
        echo 'opcache.memory_consumption=128'; \
        echo 'opcache.interned_strings_buffer=8'; \
        echo 'opcache.max_accelerated_files=4000'; \
        echo 'opcache.revalidate_freq=2'; \
        echo 'opcache.fast_shutdown=1'; \
        echo 'opcache.enable_cli=1'; \
    } > /usr/local/etc/php/conf.d/opcache-recommended.ini

RUN a2enmod rewrite expires headers

VOLUME /var/www/html

ENTRYPOINT apache2-foreground


# docker run -it --rm \
#     -p 3000:80 \
#     -v {$ pwd}:/var/www/html/ \
#     maxmilhas:php5