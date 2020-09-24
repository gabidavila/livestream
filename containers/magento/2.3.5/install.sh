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

if [[ $(/var/www/html/bin/magento setup:db:status --no-ansi) == "No information is available: the Magento application is not installed." ]] ;  then 
  echo "Configuring MySQL"
  mysql -h $DB_HOST -u magento -p$DB_PASSWORD -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO 'magento'@'%';"
  echo "Installing Magento"
  php -dmemory_limit=5G /var/www/html/bin/magento setup:install --base-url=http://$(echo $WEBSITE_URL)/ --db-host="$DB_HOST" --db-name="$DB_NAME" --db-user=magento --db-password="$DB_PASSWORD" --enable-syslog-logging=1 --admin-firstname=admin --admin-lastname=admin --admin-email=admin@admin.com --admin-user=admin --admin-password="$ADMIN_PASSWORD" --language=en_US --currency=USD --timezone=America/New_York --use-rewrites=1 --use-sample-data
 else
  echo 'yes'
fi

cd /var/www/html && chmod -R 777 var/ pub/ generated/
/usr/sbin/apache2ctl -D FOREGROUND
