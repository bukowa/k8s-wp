#!/bin/bash
set -e
source .env

function echo_green() {
  echo -e "\033[0;32m${1}\033[0m"
}

read -p "Name of your environment [example]: " -r HELM_RELEASE_NAME
export HELM_RELEASE_NAME=${HELM_RELEASE_NAME:-"example"}
echo_green "${HELM_RELEASE_NAME}"

FILENAME="${PWD}/values.${HELM_RELEASE_NAME}.yaml"

if [[ -f "${FILENAME}" ]]; then
  echo "ERROR: Release name already exists ($FILENAME)"
  exit 1
fi

read -p "Host of your environment [example.doma]: " -r WORDPRESS_HOST
export WORDPRESS_HOST=${WORDPRESS_HOST:-"example.doma"}
echo_green "${WORDPRESS_HOST}"

read -p "Patch to WordPress chart [./charts/wordpress]: " -r HELM_CHART_PATH
export HELM_CHART_PATH=${HELM_CHART_PATH:-"./charts/wordpress"}
echo_green "${HELM_CHART_PATH}"

envsubst < values.tmpl.yaml > "$FILENAME"

echo "Success"
echo_green "You can setup your environment in $FILENAME"
read -p "Press ENTER when you are ready!"

echo_green "Installing environment..."
helm install "${HELM_RELEASE_NAME}" --values="${FILENAME}" "${HELM_CHART_PATH}" --wait
echo_green "Testing environment..."
helm test "${HELM_RELEASE_NAME}"