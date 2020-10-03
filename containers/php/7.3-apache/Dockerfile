# 
# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM php:7.3-apache
COPY --from=composer /usr/bin/composer /usr/bin/composer
LABEL org.opencontainers.image.source https://github.com/gabidavila/livestream
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
      zip unzip rsync\
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
