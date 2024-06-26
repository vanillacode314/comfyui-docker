# syntax = docker/dockerfile:experimental
FROM python:latest

WORKDIR /app

RUN --mount=type=cache,target=/var/cache/apt \
    apt update && apt install -y python3-opencv

RUN --mount=type=cache,target=/root/.cache/pip \
    pip install uv

COPY ./ComfyUI/requirements.txt /app/ComfyUI/requirements.txt
COPY ./ComfyUI/custom_nodes/ComfyUI-Manager/requirements.txt /app/ComfyUI/custom_nodes/ComfyUI-Manager/requirements.txt

RUN --mount=type=cache,target=/root/.cache/pip \
    uv pip install --system opencv-python torch==2.3.1+cpu torchvision torchaudio -r ComfyUI/requirements.txt -r ComfyUI/custom_nodes/ComfyUI-Manager/requirements.txt --extra-index-url https://download.pytorch.org/whl/cpu

RUN git config --global --add safe.directory /app/ComfyUI && git config --global --add safe.directory /app/ComfyUI/custom_nodes/ComfyUI-Manager && git config --global pull.rebase true

CMD \
python3 /app/ComfyUI/custom_nodes/ComfyUI-Manager/cm-cli.py install ComfyUI-Custom-Scripts ComfyUI-Crystools SimpleWildcardsComfyUI ComfyUI-Inspire-Pack ComfyUI-Impact-Pack ComfyUI_IPAdapter_plus efficiency-nodes-comfyui rgthree-comfy comfyui-reactor-node && \
python3 /app/ComfyUI/main.py --listen --port ${PORT:-7860} --cpu
