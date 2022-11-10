FROM composer
# wp-cli
RUN apk add --no-cache less bash
ENTRYPOINT ["/bin/bash"]
WORKDIR /app
ENV PATH=$PATH:/app/vendor/bin