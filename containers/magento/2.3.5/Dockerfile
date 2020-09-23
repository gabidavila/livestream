ARG GCP_PROJECT_ID
FROM gcr.io/${GCP_PROJECT_ID}/php:7.3
EXPOSE 80

RUN mkdir /repositories

WORKDIR /var/www/html

RUN git clone https://github.com/magento/magento2.git -b 2.3.5-p2 --single-branch /repositories/magento && git clone https://github.com/magento/magento2-sample-data.git -b 2.3.5 --single-branch /repositories/sample-data && rm -rf /repositories/magento/.git /repositories/sample-data/.git

RUN rsync -a --delete /repositories/magento/ /var/www/html && php -dmemory_limit=5G -f /repositories/sample-data/dev/tools/build-sample-data.php -- --ce-source="/var/www/html"
RUN composer install

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
RUN a2enmod rewrite && service apache2 stop

COPY install.sh /root/install.sh
CMD ["/bin/bash", "/root/install.sh"]
