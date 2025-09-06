FROM python:3.12-slim
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/
RUN  uv pip --no-cache-dir install ray[default]==2.49.0 --system
    
