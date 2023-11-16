FROM python:3.12.0-slim as builder

RUN pip install poetry

ENV POETRY_NO_INTERACTION=1 \
    POETRY_VIRTUALENVS_IN_PROJECT=1 \
    POETRY_VIRTUALENVS_CREATE=1 \
    POETRY_CACHE_DIR=/tmp/poetry_cache

RUN mkdir -p /app
COPY . /app

WORKDIR /app
RUN poetry install --without dev

FROM python:3.12.0-slim as base

COPY --from=builder /app /app

WORKDIR /app
ENV PATH="/app/.venv/bin:$PATH"

CMD ["python", "-m", "app.main"]