#!/bin/sh

# CURRENT_DIR=$(cd $(dirname $0); pwd)
SEPARATOPION='---------------------------'

AWS_SERVICE_NAME=dynamodb
AWS_SERVICE_COMMAND=list-tables
ENDPOINT_URL='http://localhost:8000'

# @param {string} message
showMessage() {
  echo ${SEPARATOPION}
  echo $1
}

# process start

# command message.
showMessage 'Current Data Table.'

# aws dynamodb list-tables --endpoint-url "${ENDPOINT_URL}"

aws "${AWS_SERVICE_NAME}" "${AWS_SERVICE_COMMAND}" --endpoint-url "${ENDPOINT_URL}"
