    FROM httpd:2.4
    COPY . /usr/local/apache2/htdocs/
    COPY fullchain.pem /usr/local/apache2/conf/
    COPY privkey.pem /usr/local/apache2/conf/
    ENV LANG es_ES.UTF-8
    ENV LC_ALL C.UTF-8

    RUN sed -i 's/Listen 80/Listen 443/' /usr/local/apache2/conf/httpd.conf
    RUN sed -i 's/#LoadModule\ ssl_module/LoadModule\ ssl_module/' /usr/local/apache2/conf/httpd.conf
    RUN echo "SSLRandomSeed startup builtin" >> /usr/local/apache2/conf/httpd.conf
    RUN echo "SSLRandomSeed connect builtin" >> /usr/local/apache2/conf/httpd.conf
    RUN echo "SSLSessionCache         shmcb:/usr/local/apache2/logs/ssl_scache(512000)" >> /usr/local/apache2/conf/httpd.conf
    RUN echo "SSLSessionCacheTimeout  300" >> /usr/local/apache2/conf/httpd.conf
    RUN echo "AddType application/x-x509-ca-cert .crt" >> /usr/local/apache2/conf/httpd.conf
    RUN echo "AddType application/x-pkcs7-crl .crl" >> /usr/local/apache2/conf/httpd.conf
    RUN echo "SSLCipherSuite HIGH:!aNULL" >> /usr/local/apache2/conf/httpd.conf
    RUN echo "SSLProtocol all -SSLv3" >> /usr/local/apache2/conf/httpd.conf
    RUN echo "<VirtualHost *:443>" >> /usr/local/apache2/conf/httpd.conf
    RUN echo "    SSLEngine on" >> /usr/local/apache2/conf/httpd.conf
    RUN echo "    SSLCertificateFile \"/usr/local/apache2/conf/fullchain.pem\"" >> /usr/local/apache2/conf/httpd.conf
    RUN echo "    SSLCertificateKeyFile \"/usr/local/apache2/conf/privkey.pem\"" >> /usr/local/apache2/conf/httpd.conf
    RUN echo "    ..." >> /usr/local/apache2/conf/httpd.conf
    RUN echo "</VirtualHost>" >> /usr/local/apache2/conf/httpd.conf

    ENV SERVER_NAME www.cat-feed.online

    RUN echo "Include conf/extra/httpd-ssl.conf" >> /usr/local/apache2/conf/httpd.conf
    RUN echo "Deny from all" >> /usr/local/apache2/htdocs/.htaccess

    EXPOSE 443