# Poetry on Docker

This repository shows how to create a `Poetry` environment on the **Docker**.

## Description

### Project Structure

```shell
.
├── Dockerfile
├── README.md
├── app
│   ├── __init__.py
│   └── main.py
├── poetry.lock
└── pyproject.toml
```

#### 1. Poertry project structure

At first, create a poetry prject.
You should create it with the following command. It allows you not to install poetry on your PC.

```shell
docker run \
  --rm \
  --volume $(pwd):/app \
  --workdir /app \
  python:3.12.0-slim-bookworm bash -c \
  'pip install poetry && poetry new my_python_project && cd $_ && poetry install'
```

#### 2. `Dockerfile` and `.dockerignore`

<details>
<summary>Dockerfile</summary>

```dockerfile
FROM python:3.12.0-bookworm as builder

RUN pip install poetry

ENV POETRY_NO_INTERACTION=1 \
    POETRY_VIRTUALENVS_IN_PROJECT=1 \
    POETRY_VIRTUALENVS_CREATE=1 \
    POETRY_CACHE_DIR=/tmp/poetry_cache

RUN mkdir -p /app
WORKDIR /app
COPY pyproject.toml poetry.lock ./
RUN touch README.md

# RUN poetry install --without dev
RUN --mount=type=cache,target=$POETRY_CACHE_DIR poetry install --without dev --no-root


FROM python:3.12.0-slim-bookworm as runtime

ENV VIRTUAL_ENV=/app/.venv \
    PATH="/app/.venv/bin:$PATH"

COPY --from=builder ${VIRTUAL_ENV} ${VIRTUAL_ENV}

COPY my_python_project ./app

CMD ["python", "-m", "app.main"]
```

<<<<<<< HEAD
</details>

=======
>>>>>>> 723e8ad44e208258f8a6454014cb9f13dd865bc0
## Demo

## Features

- feature:1
- feature:2

## Requirement

## Usage

## Installation

## References

## Licence

Released under the [MIT license](https://gist.githubusercontent.com/shinyay/56e54ee4c0e22db8211e05e70a63247e/raw/34c6fdd50d54aa8e23560c296424aeb61599aa71/LICENSE)

## Author

- github: <https://github.com/shinyay>
- twitter: <https://twitter.com/yanashin18618>
- mastodon: <https://mastodon.social/@yanashin>
