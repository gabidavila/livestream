FROM php:7.3-apache
COPY --from=composer /usr/bin/composer /usr/bin/composer
ADD https://raw.githubusercontent.com/mlocati/docker-php-extension-installer/master/install-php-extensions /usr/local/bin/
RUN chmod uga+x /usr/local/bin/install-php-extensions && sync
RUN apt install -y 
RUN DEBIAN_FRONTEND=noninteractive apt-get update -q \
    && DEBIAN_FRONTEND=noninteractive apt-get install -qq -y dirmngr \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv 5072E1F5
RUN echo "deb http://repo.mysql.com/apt/debian buster mysql-8.0" | \
    tee /etc/apt/sources.list.d/mysql80.list && apt-get update -q
RUN DEBIAN_FRONTEND=noninteractive apt-get install -qq -y \
      mysql-client \
      curl \
      git \
      zip unzip \
    && install-php-extensions \
      bcmath \
      bz2 \
      calendar \
      exif \
      gd \
      intl \
      ldap \
      memcached \
      mysqli \
      opcache \
      pdo_mysql \
      pdo_pgsql \
      pgsql \
      redis \
      soap \
      xsl \
      zip \
      sockets
CMD ["a2enmod", "rewrite"]
