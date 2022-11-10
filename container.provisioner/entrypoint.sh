#!/bin/bash
set -eux

wp
declare -p WORDPRESS_URL

/scripts/wait-for-entrypoint.sh -t 30 "${WORDPRESS_URL}/wp-admin/install.php"
if ! wp core is-installed; then /scripts/wordpress-install.sh; fi
/scripts/change-wordpress-url.sh
composer install
