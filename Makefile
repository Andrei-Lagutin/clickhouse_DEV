.PHONY: config
config:
	rm -rf clickhouse01 clickhouse02 clickhouse03 clickhouse04 prometheus grafana alertmanager alertmanager-bot
	mkdir -p clickhouse01 clickhouse02 clickhouse03 clickhouse04 prometheus grafana alertmanager alertmanager-bot
	REPLICA=01 SHARD=01 envsubst < config.xml > clickhouse01/config.xml
	REPLICA=02 SHARD=01 envsubst < config.xml > clickhouse02/config.xml
	REPLICA=03 SHARD=02 envsubst < config.xml > clickhouse03/config.xml
	REPLICA=04 SHARD=02 envsubst < config.xml > clickhouse04/config.xml
	cp users.xml clickhouse01/users.xml
	cp users.xml clickhouse02/users.xml
	cp users.xml clickhouse03/users.xml
	cp users.xml clickhouse04/users.xml
	cp prometheus.yml prometheus/prometheus.yml
	cp config.yml alertmanager/config.yml
	cp alert.rules prometheus/alert.rules

.PHONY: up
up:
	docker-compose up -d

.PHONY: start
start:
	docker-compose start

.PHONY: down
down:
	docker-compose down

.PHONY: down-full
down-full:
	docker-compose down -v

.PHONY: after
after:
	bash setup_grafana.sh
