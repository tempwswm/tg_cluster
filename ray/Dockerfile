FROM python:3.12-slim
ARG RAY_VERSION
ENV TZ=Asia/Shanghai
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/
RUN  uv pip --no-cache-dir install ray[default]==$RAY_VERSION --system
    
