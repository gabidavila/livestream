#!/bin/bash
if [[ $(/var/www/html/bin/magento setup:db:status --no-ansi) == "Autoload error: Vendor autoload is not found. Please run 'composer install' under application root directory." ]] ;  then 
  echo "Configuring MySQL"
  mysql -h $DB_HOST -u magento -p$DB_PASSWORD -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO 'magento'@'%';"
  echo "Installing Magento"
  composer install -d /var/www/html
  php -dmemory_limit=5G /var/www/html/bin/magento setup:install --base-url=http://$(echo $WEBSITE_URL)/ --db-host="$DB_HOST" --db-name="$DB_NAME" --db-user=magento --db-password="$DB_PASSWORD" --enable-syslog-logging=1 --admin-firstname=admin --admin-lastname=admin --admin-email=admin@admin.com --admin-user=admin --admin-password="$ADMIN_PASSWORD" --language=en_US --currency=USD --timezone=America/New_York --use-rewrites=1 --use-sample-data
 else
  echo 'yes'
fi

cd /var/www/html && chmod -R 777 var/ pub/ generated/
/usr/sbin/apache2ctl -D FOREGROUND
