#!/bin/sh

# CURRENT_DIR=$(cd $(dirname $0); pwd)
SEPARATOPION='---------------------------'
START_MESSAGE='check container status.'
DOCKER_COMPOSE_FILE='./docker-compose.yml'

# 初期化関連のshells
LIST_TABLE_SHELL='./scripts/listTable.sh'
CREATE_TABLE_SHELL='./scripts/createTable.sh'

# @param {string} message
showMessage() {
  echo ${SEPARATOPION}
  echo $1
}

# process start
showMessage ${START_MESSAGE}

# -qオプション container idのみを表示
# /dev/null: 出力が破棄され、なにも表示されない。
# 2(標準エラー出力) を/dev/nullに破棄することで、1(標準出力)のみを出力する。
if [[ "$(docker-compose -f ${DOCKER_COMPOSE_FILE} ps -q 2>/dev/null)" == "" ]]; then
  # コンテナが立ち上がっていない状態の時
  showMessage 'Up Docker Container!'
  docker-compose -f ${DOCKER_COMPOSE_FILE} up -d

  sh "${CREATE_TABLE_SHELL}"
  sh "${LIST_TABLE_SHELL}"
else
　# コンテナが立ち上がっている状態の時
  showMessage 'Down Docker Container!'
  # docker-compose -f ${DOCKER_COMPOSE_FILE} down

  # TODO 現状volumeも削除する。(初期データ投入をしたい。)
  docker-compose -f ${DOCKER_COMPOSE_FILE} down -v
fi

# 現在のDocker コンテナの状態を出力
showMessage 'Current Docker Status.'
docker-compose -f ${DOCKER_COMPOSE_FILE} ps

