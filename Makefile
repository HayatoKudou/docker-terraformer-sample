terraformer/init:
	docker compose run --rm --entrypoint terraform terraformer init

docker/run: command=
docker/run: service=terraformer
docker/run:
	docker compose run --rm $(service) $(command)

env:
	cp .env.template .env