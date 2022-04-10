FROM amazon/dynamodb-local:1.18.0

# DynamoDBLocal.jarが格納されているディレクトリ
WORKDIR /home/dynamodblocal

CMD ["-jar", "DynamoDBLocal.jar", "-sharedDb", "-dbPath", "/home/dynamodb/db"]
