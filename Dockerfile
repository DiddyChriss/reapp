FROM python:3.12

RUN apt-get update && apt-get install -y && rm -rf /var/lib/apt/lists/*
RUN pip install -U pip && apt-get update
RUN pip install poetry
ENV PATH="${PATH}:/root/.poetry/bin"

ENV PYTHONUNBUFFERED 1

RUN mkdir /usr/src/app
RUN mkdir /usr/src/app/static
RUN mkdir /usr/src/app/media

WORKDIR /usr/src/app
COPY pyproject.toml /usr/src/app
COPY poetry.lock /usr/src/app
COPY create_superuser.sh /create_superuser.sh
RUN poetry config virtualenvs.create false
RUN poetry install --no-interaction --no-root
