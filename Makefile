build:
	docker compose build

run:
	docker-compose up

logs::
	docker-compose logs -f

migrate:
	docker-compose run propertybackend python manage.py migrate

makemigrations:
	docker-compose run propertybackend python manage.py makemigrations

collectstatic:
	docker-compose run propertybackend python manage.py collectstatic --noinput

clean:
	docker-compose down -v

setup:
	@make build
	@make run
	@make logs

first_setup:
	cp example.env .env
	@make build
	@make run
	@make logs

full_build:
	@make build
	@make migrate
	@make collectstatic
