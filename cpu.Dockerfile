# syntax = docker/dockerfile:experimental
FROM python:latest

WORKDIR /app

RUN --mount=type=cache,target=/root/.cache/pip pip install --upgrade pip uv && \ 
    uv pip install --system opencv-python torch==2.3.1+cpu torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cpu

COPY ./start.sh .
ENTRYPOINT ["/bin/bash","./start.sh"]
CMD ["--cpu"]
