# syntax = docker/dockerfile:experimental
FROM debian:latest

WORKDIR /app

RUN --mount=type=cache,target=/var/cache/apt \
    apt update && \
    apt install -y git aria2 python3 python3-pip python3-venv python3-opencv

RUN git clone https://github.com/comfyanonymous/ComfyUI
RUN cd ComfyUI/custom_nodes && \
    git clone https://github.com/ltdrdata/ComfyUI-Manager

RUN --mount=type=cache,target=/root/.cache/pip \
    python3 -m venv venv && \
    . venv/bin/activate && \
    pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu121 && \
    pip install opencv-python && \
    pip install -r ComfyUI/requirements.txt


CMD venv/bin/python3 ComfyUI/main.py --listen --port ${PORT:-7680}
