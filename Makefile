build:
	docker compose pull --ignore-pull-failures; \
	docker compose build;

setup: build
	docker compose run --user=root:root --rm website mkdir -p /home/server; \
	docker compose run --user=root:root --rm website mkdir -p /opt/hex; \
	docker compose run --user=root:root --rm website mkdir -p /opt/mix; \
	docker compose run --user=root:root --rm website chown -R 1000:1000 /home/server; \
	docker compose run --user=root:root --rm website chown -R 1000:1000 /opt/hex; \
	docker compose run --user=root:root --rm website chown -R 1000:1000 /opt/mix; \

install: setup
	docker compose run --user=root:root --rm website mix deps.get; \
	docker compose run --user=root:root --rm website mix ecto.setup;

bash:
	docker compose run --rm website bash

iex:
	docker exec -it website iex --name console@127.0.0.1 --cookie monster --remsh torrent-video@127.0.0.1

start:
	docker compose up

stop-all:
	 bash ./scripts/docker-stop-all.sh

reset:
	docker compose run --rm website mix ecto.drop;
	docker compose run --rm website mix ecto.setup