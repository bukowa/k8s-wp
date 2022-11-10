FROM wordpress:cli-php7.4
COPY --from=composer:2.4.4 /usr/bin/composer /usr/local/bin/composer

COPY scripts /scripts
WORKDIR /var/www/html
ENV PATH=$PATH:/var/www/html/vendor/bin

ENTRYPOINT ["/bin/bash", "-c"]
