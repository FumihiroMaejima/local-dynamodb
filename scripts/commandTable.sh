#!/bin/sh

# CURRENT_DIR=$(cd $(dirname $0); pwd)
SEPARATOPION='---------------------------'

AWS_SERVICE_NAME=dynamodb
AWS_SERVICE_SCAN_COMMAND=scan
AWS_SERVICE_GET_ITEM_COMMAND=get-item
AWS_SERVICE_LIST_TABLES=list-tables
ENDPOINT_URL='http://localhost:8000'
TABLE_NAME='TestTable2'

# @param {string} message
showMessage() {
  echo ${SEPARATOPION}
  echo $1
}

# process start

# command message.
showMessage 'Execute Command.'

# aws dynamodb list-tables --endpoint-url "${ENDPOINT_URL}"

# aws "${AWS_SERVICE_NAME}" "${AWS_SERVICE_COMMAND}" \
# --table-name "${TABLE_NAME}" \
# --endpoint-url "${ENDPOINT_URL}"


aws "${AWS_SERVICE_NAME}" "${AWS_SERVICE_LIST_TABLES}" \
--endpoint-url "${ENDPOINT_URL}"

