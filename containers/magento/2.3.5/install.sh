#!/bin/bash
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
echo "Configuring MySQL Permissions"
mysql -h $DB_HOST -u magento -p$DB_PASSWORD -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO 'magento'@'%';"

TOTAL_TABLES_STORE=$(mysql -h $DB_HOST -u magento -D $DB_NAME  -p$DB_PASSWORD -e "SELECT count(*) AS TOTALNUMBEROFTABLES FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = '$DB_NAME'" -N)

if [[ $TOTAL_TABLES_STORE == "0" || $TOTAL_TABLES_STORE == "" ]] ;  then 
  echo "Installing Magento"
  php -dmemory_limit=5G /var/www/html/bin/magento setup:install --base-url=http://$(echo $WEBSITE_URL)/ --db-host="$DB_HOST" --db-name="$DB_NAME" --db-user=magento --db-password="$DB_PASSWORD" --enable-syslog-logging=1 --admin-firstname=admin --admin-lastname=admin --admin-email=admin@admin.com --admin-user=admin --admin-password="$ADMIN_PASSWORD" --language=en_US --currency=USD --timezone=America/New_York --use-rewrites=1 --use-sample-data -vvv
 else
  echo "Configuring Magento"
  php -dmemory_limit=5G /var/www/html/bin/magento module:enable --all --clear-static-content -vvv
  php -dmemory_limit=5G /var/www/html/bin/magento setup:di:compile -vvv
  cd /var/www/html && chmod -R 777 var/ pub/ generated/
  php -dmemory_limit=5G /var/www/html/bin/magento setup:config:set -n --db-host="$DB_HOST" --db-name="$DB_NAME" --db-user=magento --db-password="$DB_PASSWORD" --enable-syslog-logging=1 -vvv
fi

cd /var/www/html && chmod -R 777 var/ pub/ generated/
php -dmemory_limit=5G bin/magento info:adminuri -vvv
/usr/sbin/apache2ctl -D FOREGROUND
