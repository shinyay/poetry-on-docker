FROM python:3.12.0-slim

RUN pip install poetry
RUN mkdir -p /app
COPY . /app

WORKDIR /app

RUN poetry install --without dev
CMD ["poetry", "run", "python", "-m", "app.main"]