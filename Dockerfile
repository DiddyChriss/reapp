FROM python:3.12

RUN apt-get update && apt-get install -y && rm -rf /var/lib/apt/lists/*
RUN pip install -U pip && apt-get update
RUN pip install poetry
ENV PATH="${PATH}:/root/.poetry/bin"

ENV PYTHONUNBUFFERED 1

RUN mkdir /usr/src/reapp

ENV APPLICATION_DIR=/usr/src/reapp

RUN mkdir $APPLICATION_DIR/static
RUN mkdir $APPLICATION_DIR/media

WORKDIR $APPLICATION_DIR

COPY . $APPLICATION_DIR

RUN poetry config virtualenvs.create false
RUN poetry install --no-interaction --no-root
