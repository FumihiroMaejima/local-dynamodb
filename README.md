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

---
