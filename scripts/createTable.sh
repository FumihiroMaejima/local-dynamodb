#!/bin/sh

# CURRENT_DIR=$(cd $(dirname $0); pwd)
SEPARATOPION='---------------------------'

AWS_SERVICE_NAME=dynamodb
AWS_SERVICE_COMMAND=create-table
ENDPOINT_URL='http://localhost:8000'

# @param {string} message
showMessage() {
  echo ${SEPARATOPION}
  echo $1
}

# process start

# command message.
showMessage 'Create Initial Table.'

# aws dynamodb list-tables --endpoint-url "${ENDPOINT_URL}"

# --table-name: テーブル名
# --key-schema: テーブル（またはインデックス）の主キーの定義
# --attribute-definitions: 属性の定義
# --provisioned-throughput: テーブル（またはインデックス）のプロビジョニングされたスループットを指定(秒間あたりのスループットは、読み取りの最大数と書き込みの最大数)
# --billing-mode: 選択可能なPROVISIONED（デフォルト）とPAY_PER_REQUESTのうち、PROVISIONEDを選択した場合は指定が必須
# --table-class: テーブルクラス。STANDARDとSTANDARD_INFREQUENT_ACCESSから選択

# $ aws dynamodb create-table
# --table-name TableName
# --attribute-definitions AttributeName=Id,AttributeType=N
# --key-schema AttributeName=Id,KeyType=HASH
# --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1
# --endpoint-url "${ENDPOINT_URL}"

aws "${AWS_SERVICE_NAME}" "${AWS_SERVICE_COMMAND}" \
--table-name TestTable \
--attribute-definitions AttributeName=Id,AttributeType=N \
--key-schema AttributeName=Id,KeyType=HASH \
--provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1 \
--endpoint-url "${ENDPOINT_URL}"
