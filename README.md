# Local DynamoDB Docker Environmental

ローカルのDockerでデータベースを構築する為の手順書

# 構成

| 名前 | バージョン |
| :--- | :---: |
| MySQL | 8.0 |

---
# ローカル環境の構築(Mac)

## データの永続化の為にローカルに`volume`を作成する

```shell-session
$ docker volume create local-dynamodb-store
```

### `volume`を削除する場合

```shell-session
$ docker volume rm local-dynamodb-store
```

## Dockerイメージのインストール

`latest`もしくは使う当時の最新のバージョンを指定する。

```shell-session
$ docker pull amazon/dynamodb-local:latest
$ docker pull amazon/dynamodb-local:1.18.0
```

## Dockerコンテナ立ち上げ時のコマンド

`-sharedDb`の代わりにデフォルトは`inMemory`オプションが指定される。

`inMemory`はコンテナを落とすとテーブル定義を含むデータがすべて削除する。

`-sharedDb`を指定すると、認証情報やリージョンごとに別のファイルを使用せずに、単一のデータベースファイルを使用する。

`dbPath`でDBの保存先を切り替える。

```shell-session
$ -jar DynamoDBLocal.jar -sharedDb -dbPath /home/dynamodb/db
```

コンテナを立ち上げる時は`stop`をかけるのが望ましいとのこと。


### Dockerfile の設定

Dockerコンテナ関係の設定は下記の通り

`DynamoDBLocal.jar`が置かれているディレクトリと`DBのデータが置かれている親ディレクトリ`が異なるので注意。

```Dockerfile
FROM amazon/dynamodb-local:1.18.0

# DynamoDBLocal.jarが格納されているディレクトリ
WORKDIR /home/dynamodblocal

CMD ["-jar", "DynamoDBLocal.jar", "-sharedDb", "-dbPath", "/home/dynamodb/data"]

```

ディレクトリの権限の都合で`user: root`を付けている。

```yaml
services:
  dynamodb:
    build: ./dynamodb_local
    container_name: ${PROJECT_NAME}-dynamodb
    user: root
    volumes:
      - local-db-store:/home/dynamodb/data # データの永続化
    ports:
      - "8000:8000"
    environment:
      TZ: "Asia/Tokyo"

volumes:
  local-db-store:
    name: volume-name
    external: false
```

---

# DynamoDBの管理画面の用意

非公式だが下記のイメージを使ってコンテナを立ち上げる。

`aaronshaf/dynamodb-admin`

docker-compose.ymlの設定は下記の通り

```yaml
  admin:
    container_name: ${PROJECT_NAME}-admin
    image: aaronshaf/dynamodb-admin:latest
    ports:
      - "8001:8001"
    depends_on:
      - dynamodb
    environment:
      DYNAMO_ENDPOINT: http://dynamodb:8000
      TZ: "Asia/Tokyo"
```

```

```


---
