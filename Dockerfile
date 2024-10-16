# syntax = docker/dockerfile:experimental
FROM ghcr.io/astral-sh/uv:debian-slim

WORKDIR /app

RUN --mount=type=cache,target=/var/cache/apt --mount=type=cache,target=/var/lib/apt \
  apt-get update -y && apt-get install libglib2.0-0 libgl1 libgl1-mesa-glx aria2 git clang build-essential python3-dev -y

RUN uv venv

RUN --mount=type=cache,target=/root/.cache/pip\
  uv pip install pip insightface opencv-python torch==2.3.1+cu121 torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu121\
  -r https://raw.githubusercontent.com/comfyanonymous/ComfyUI/master/requirements.txt\
  -r https://raw.githubusercontent.com/crystian/ComfyUI-Crystools/main/requirements.txt\
  -r https://raw.githubusercontent.com/cubiq/ComfyUI_essentials/main/requirements.txt\
  -r https://raw.githubusercontent.com/Fannovel16/comfyui_controlnet_aux/main/requirements.txt\
  -r https://raw.githubusercontent.com/jags111/efficiency-nodes-comfyui/main/requirements.txt\
  -r https://raw.githubusercontent.com/ltdrdata/ComfyUI-Impact-Pack/Main/requirements.txt\
  -r https://raw.githubusercontent.com/ltdrdata/ComfyUI-Impact-Subpack/main/requirements.txt\
  -r https://raw.githubusercontent.com/ltdrdata/ComfyUI-Inspire-Pack/main/requirements.txt\
  -r https://raw.githubusercontent.com/ltdrdata/ComfyUI-Manager/main/requirements.txt\
  -r https://github.com/cubiq/ComfyUI_essentials/raw/main/requirements.txt\
  -r https://github.com/Fannovel16/comfyui_controlnet_aux/raw/main/requirements.txt

COPY ./start.sh .
COPY ./flux.txt .
COPY ./models.txt .
ENTRYPOINT [ "/bin/bash", "./start.sh" ]
CMD [ "--disable-cuda-malloc" ]
