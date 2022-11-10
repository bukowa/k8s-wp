#!/bin/bash
set -eux

wp cli info

/wait-for-entrypoint.sh -t 30 "${WORDPRESS_URL}/wp-admin/install.php"

declare -p WORDPRESS_URL >/dev/null
declare -p WORDPRESS_TITLE >/dev/null
declare -p WORDPRESS_LOGIN >/dev/null
declare -p WORDPRESS_PASSWORD >/dev/null
declare -p WORDPRESS_EMAIL >/dev/null

if wp core is-installed;
then
    echo "Wordpress is already installed..."
    if [[ -f "composer.json" ]]; then
      composer update
    fi
else
    echo "Installing wordpress on ${WORDPRESS_URL}..."
    wp core install \
        --url="${WORDPRESS_URL}" \
        --title="${WORDPRESS_TITLE}" \
        --admin_user="${WORDPRESS_LOGIN}" \
        --admin_password="${WORDPRESS_PASSWORD}" \
        --admin_email="${WORDPRESS_EMAIL}" \
        --skip-email
    wp rewrite structure '/%category%/%postname%/'
    wp plugin delete hello || true
    wp plugin delete akismet || true
    wp theme delete twentynineteen || true
    wp theme delete twentyseventeen || true
    wp theme delete twentysixteen || true

    if [[ -f "composer.json" ]]; then
      composer install
    fi

    echo "Wordpress install success"
fi

CURRENT_DOMAIN=$(wp option get siteurl)
echo "Checking if $CURRENT_DOMAIN should be changed to $WORDPRESS_URL"
if ! [[ ${CURRENT_DOMAIN} == "${WORDPRESS_URL}" ]]; then
    echo "Replacing ${CURRENT_DOMAIN} with ${WORDPRESS_URL} in database..."
    wp search-replace "${CURRENT_DOMAIN}" "${WORDPRESS_URL}"
fi

eval "$@"
sleep infinity
