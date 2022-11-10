FROM wordpress:cli-php7.4
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer
ENTRYPOINT ["/bin/bash", "-c"]
WORKDIR /app
ENV PATH=$PATH:/app/vendor/bin