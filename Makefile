build:
	docker-compose build

run:
	docker-compose up

migrate:
	docker-compose run propertyapp python manage.py migrate

makemigrations:
	docker-compose run propertyapp python manage.py makemigrations

collectstatic:
	docker-compose run propertyapp python manage.py collectstatic --noinput

clean:
	docker-compose down -v

setup:
	@make build
	@make run

first_setup:
	cp example.env .env
	@make build
	@make run

full_build:
	@make build
	@make migrate
	@make collectstatic
