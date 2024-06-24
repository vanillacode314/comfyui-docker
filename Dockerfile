# syntax = docker/dockerfile:experimental
FROM python:latest

WORKDIR /app

RUN --mount=type=cache,target=/root/.cache/pip \
    pip install uv

COPY ./ComfyUI/requirements.txt /app/ComfyUI/requirements.txt

RUN --mount=type=cache,target=/root/.cache/pip \
    uv pip install --system opencv-python torch==2.3.1+cu121 torchvision torchaudio -r ComfyUI/requirements.txt --extra-index-url https://download.pytorch.org/whl/cu121

CMD python3 ComfyUI/main.py --listen --port ${PORT:-7680} --disable-cuda-malloc
