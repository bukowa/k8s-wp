FROM wordpress:cli-php7.4
COPY --from=composer:2.4.4 /usr/bin/composer /usr/local/bin/composer

WORKDIR /var/www/html
ENV PATH=$PATH:/var/www/html/vendor/bin

ENV WORDPRESS_URL=http://localhost
COPY wait-for-entrypoint.sh /
COPY entrypoint.sh /

EXPOSE 8999
ENTRYPOINT ["/entrypoint.sh"]