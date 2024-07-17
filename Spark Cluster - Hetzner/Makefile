build:
	docker-compose build

build-nc:
	docker-compose build --no-cache

build-progress:
	docker-compose build --no-cache --progress=plain

down:
	docker-compose down

run:
	docker-compose up

run-scaled:
	docker-compose up --scale spark-worker=$(workers)

run-d:
	make down && docker-compose up -d

stop:
	docker-compose stop

submit:
	docker exec spark-cluster spark-submit --master spark://spark-master:7077 --deploy-mode client ./apps/$(app)