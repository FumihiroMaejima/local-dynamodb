CMD=default

echo:
	@echo test
	@date "+%m/%d/%Y %H:%M"

##############################
# make docker environmental
##############################
up:
	docker-compose up -d

stop:
	docker-compose stop

down:
	docker-compose down

down-rmi:
	docker-compose down --rmi all
ps:
	docker-compose ps

dev:
	sh ./scripts/dev.sh

##############################
# dynamodb
##############################
dynamodb-help:
	docker-compose exec dynamodb java -jar DynamoDBLocal.jar -help

command:
	sh ./scripts/commandTable.sh

##############################
# db container(mysql)
##############################
mysql:
	docker-compose exec db bash -c 'mysql -u $$DB_USER -p$$MYSQL_PASSWORD $$DB_DATABASE'

mysql-dump:
	sh ./scripts/get-dump.sh

mysql-restore:
	sh ./scripts/restore-dump.sh

##############################
# etc
##############################
help:
	@cat Makefile
