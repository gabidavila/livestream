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

FROM gabidavila/php:7.3-apache
EXPOSE 80

LABEL org.opencontainers.image.source https://github.com/gabidavila/livestream

RUN mkdir /repositories

WORKDIR /var/www/html

RUN git clone https://github.com/magento/magento2.git -b 2.3.5-p2 --single-branch /repositories/magento && git clone https://github.com/magento/magento2-sample-data.git -b 2.3.5 --single-branch /repositories/sample-data && rm -rf /repositories/magento/.git /repositories/sample-data/.git

RUN rsync -a --delete /repositories/magento/ /var/www/html && php -dmemory_limit=5G -f /repositories/sample-data/dev/tools/build-sample-data.php -- --ce-source="/var/www/html"
RUN composer install

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
RUN a2enmod rewrite && service apache2 stop

COPY install.sh /root/install.sh
CMD ["/bin/bash", "/root/install.sh"]
