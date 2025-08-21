FROM python:3.12-slim
RUN --mount=from=ghcr.io/astral-sh/uv,source=/uv,target=/bin/uv \
    uv pip --no-cache-dir install ray[default] --system 
    
