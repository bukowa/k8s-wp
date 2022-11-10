#!/bin/bash
set -eux

if wp core is-installed;
then
    echo "Wordpress is already installed..."
else
    declare -p WORDPRESS_TITLE >/dev/null
    declare -p WORDPRESS_LOGIN >/dev/null
    declare -p WORDPRESS_PASSWORD >/dev/null
    declare -p WORDPRESS_EMAIL >/dev/null
    echo "Installing wordpress on ${WORDPRESS_URL}..."
    wp core install \
        --url="${WORDPRESS_URL}" \
        --title="${WORDPRESS_TITLE}" \
        --admin_user="${WORDPRESS_LOGIN}" \
        --admin_password="${WORDPRESS_PASSWORD}" \
        --admin_email="${WORDPRESS_EMAIL}" \
        --skip-email
fi
echo "Visit $(wp option get siteurl)/wp-login.php"
