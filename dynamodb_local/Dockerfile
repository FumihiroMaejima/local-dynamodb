FROM amazon/dynamodb-local:1.18.0

# WORKDIR /home/dynamodb
WORKDIR /home/dynamodb


# CMD ["mysqld"]
# CMD ["nginx", "-g", "daemon off;","-c","/etc/nginx/nginx.conf"]
# -jar DynamoDBLocal.jar -sharedDb -dbPath /home/dynamodb/db
CMD ["-jar", "DynamoDBLocal.jar", "-sharedDb", "-dbPath", "/home/dynamodb/db"]
