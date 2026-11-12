FROM python:3.14-slim-trixie AS BUILD
WORKDIR /app-build

ENV UV_PYTHON_DOWNLOADS="never"

COPY --from=ghcr.io/astral-sh/uv:0.13.7 /uv /uvx /bin/
COPY pyproject.toml uv.lock .python-version ./
RUN uv sync --locked --no-dev


FROM python:3.14-slim-trixie
WORKDIR /app-build
RUN adduser --disabled-password user
USER user
COPY --from=BUILD /app-build/.venv /app-build/.venv
copy app ./app
ENV PATH="/app-build/.venv/bin:$PATH"
EXPOSE 8000
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]

