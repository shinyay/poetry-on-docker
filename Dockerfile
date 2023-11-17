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


FROM python:3.12.0-slim-buster as runtime

ENV VIRTUAL_ENV=/app/.venv \
    PATH="/app/.venv/bin:$PATH"

COPY --from=builder ${VIRTUAL_ENV} ${VIRTUAL_ENV}

COPY app ./app

CMD ["python", "-m", "app.main"]