#!/bin/bash
set -eux

CURRENT_DOMAIN=$(wp option get siteurl)
echo "Checking if $CURRENT_DOMAIN should be changed to $WORDPRESS_URL"
if ! [[ ${CURRENT_DOMAIN} == "${WORDPRESS_URL}" ]]; then
    echo "Replacing ${CURRENT_DOMAIN} with ${WORDPRESS_URL} in database..."
    wp search-replace "${CURRENT_DOMAIN}" "${WORDPRESS_URL}"
fi
