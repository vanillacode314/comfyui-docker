# syntax = docker/dockerfile:experimental
FROM python:latest

WORKDIR /app

COPY ./ComfyUI/requirements.txt /app/ComfyUI/requirements.txt

RUN --mount=type=cache,target=/root/.cache/pip \
    pip install opencv-python torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cpu && \
    pip install -r ComfyUI/requirements.txt

CMD python3 ComfyUI/main.py --listen --port ${PORT:-7680} --cpu
