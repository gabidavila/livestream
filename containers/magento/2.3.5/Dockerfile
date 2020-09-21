ARG GCP_PROJECT_ID
FROM gcr.io/${GCP_PROJECT_ID}/php:7.3
EXPOSE 80

RUN mkdir /repositories

RUN git clone https://github.com/magento/magento2.git -b 2.3.5 /repositories/magento && git clone https://github.com/magento/magento2-sample-data.git -b 2.3.5 /repositories/sample-data && php -f /repositories/sample-data/dev/tools/build-sample-data.php -- --ce-source="/repositories/magento" && cp -Rf /repositories/magento/* /var/www/html/. && cp -Rf /repositories/magento/*.* /var/www/html/. && rm -rf /repositories

RUN a2enmod rewrite && service apache2 stop

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

COPY install.sh /root/install.sh
CMD ["/bin/bash", "/root/install.sh"]
