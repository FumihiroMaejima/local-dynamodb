#!/bin/sh

# CURRENT_DIR=$(cd $(dirname $0); pwd)
SEPARATOPION='---------------------------'

AWS_SERVICE_NAME=dynamodb
AWS_SERVICE_COMMAND=create-table
AWS_SERVICE_DESCRIBE=describe-table
AWS_SERVICE_PUT_COMMAND=put-item
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

createDatabase() {

TABLE_NAME1=TestTable
TABLE_NAME2=TestTable2

aws "${AWS_SERVICE_NAME}" "${AWS_SERVICE_COMMAND}" \
--table-name "${TABLE_NAME1}" \
--attribute-definitions AttributeName=Id,AttributeType=N \
--key-schema AttributeName=Id,KeyType=HASH \
--provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1 \
--endpoint-url "${ENDPOINT_URL}"

# aws "${AWS_SERVICE_NAME}" "${AWS_SERVICE_DESCRIBE}" --table-name TestTable --endpoint-url "${ENDPOINT_URL}" | grep TableStatus

aws "${AWS_SERVICE_NAME}" "${AWS_SERVICE_COMMAND}" \
--table-name "${TABLE_NAME2}" \
--attribute-definitions AttributeName=key,AttributeType=S \
--key-schema AttributeName=key,KeyType=HASH \
--provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
--endpoint-url "${ENDPOINT_URL}"

# aws "${AWS_SERVICE_NAME}" "${AWS_SERVICE_DESCRIBE}" --table-name TestTable2 --endpoint-url "${ENDPOINT_URL}" | grep TableStatus

}

insertData() {

aws "${AWS_SERVICE_NAME}" "${AWS_SERVICE_PUT_COMMAND}" \
--table-name TestTable2 \
--item '{ "population": { "N": "38234" }, "date_mod": { "S": "1970-01-01" }, "key": { "S": "tx1234" }, "name": { "S": "高崎" } }' \
--endpoint-url "${ENDPOINT_URL}"

aws "${AWS_SERVICE_NAME}" "${AWS_SERVICE_PUT_COMMAND}" \
--table-name TestTable2 \
--item '{ "population": { "N": "12345" }, "date_mod": { "S": "1970-01-02" }, "key": { "S": "aa1234" }, "name": { "S": "伊勢崎" } }' \
--endpoint-url "${ENDPOINT_URL}"

aws "${AWS_SERVICE_NAME}" "${AWS_SERVICE_PUT_COMMAND}" \
--table-name TestTable2 \
--item '{ "population": { "N": "67890" }, "date_mod": { "S": "2020-02-02" }, "key": { "S": "ss1357" }, "name": { "S": "前橋" } }' \
--endpoint-url "${ENDPOINT_URL}"

}

createDatabase
wait

insertData
wait

