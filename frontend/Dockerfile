FROM httpd:2.4
COPY . /usr/local/apache2/htdocs/
COPY fullchain.pem /usr/local/apache2/conf/
COPY privkey.pem /usr/local/apache2/conf/
ENV LANG es_ES.UTF-8
ENV LC_ALL C.UTF-8
ENV SERVER_NAME www.cat-feed.online
RUN sed -i 's/Listen 80/Listen 443/g' /usr/local/apache2/conf/httpd.conf
RUN echo "Include conf/extra/httpd-ssl.conf" >> /usr/local/apache2/conf/httpd.conf
RUN echo "SSLSessionCache shmcb:/usr/local/apache2/logs/ssl_scache(512000)" >> /usr/local/apache2/conf/extra/httpd-ssl.conf
RUN echo "SSLCertificateFile /usr/local/apache2/conf/fullchain.pem" >> /usr/local/apache2/conf/extra/httpd-ssl.conf
RUN echo "SSLCertificateKeyFile /usr/local/apache2/conf/privkey.pem" >> /usr/local/apache2/conf/extra/httpd-ssl.conf
RUN echo "ServerName www.cat-feed.com" >> /usr/local/apache2/conf/httpd.conf
RUN echo "Deny from all" >> /usr/local/apache2/htdocs/.htaccess
RUN apt-get update && apt-get install a2enmod rewrite
RUN echo 'RewriteEngine On' >> /usr/local/apache2/conf/httpd.conf
RUN echo 'RewriteCond %{HTTPS} off' >> /usr/local/apache2/conf/httpd.conf
RUN echo 'RewriteRule ^(.*)$ https://%{HTTP_HOST}%{REQUEST_URI} [L,R=301]' >> /usr/local/apache2/conf/httpd.conf
EXPOSE 80
EXPOSE 443
