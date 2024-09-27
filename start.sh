#!/bin/bash

set -e

source /app/.venv/bin/activate

if [ ! -d "/app/ComfyUI/.git" ]; then
  git clone https://github.com/comfyanonymous/ComfyUI
  git clone https://github.com/ltdrdata/ComfyUI-Manager /app/ComfyUI/custom_nodes/ComfyUI-Manager

  python3 /app/ComfyUI/custom_nodes/ComfyUI-Manager/cm-cli.py install \
    ComfyUI-Custom-Scripts \
    ComfyUI_Comfyroll_CustomNodes \
    ComfyUI_UltimateSDUpscale \
    ComfyUI-Crystools \
    SimpleWildcardsComfyUI \
    ComfyUI-Inspire-Pack \
    ComfyUI-Impact-Pack \
    efficiency-nodes-comfyui \
    rgthree-comfy \
    comfyui-reactor-node \
    ComfyUI_essentials \
    comfyui_controlnet_aux
fi

if [ $DOWNLOAD_FLUX -eq 1 ]; then
  echo "INFO: Downloading Flux..."
  mkdir -p \
    /app/ComfyUI/models/clip \
    /app/ComfyUI/models/vae \
    /app/ComfyUI/models/unet
  aria2c -s16 -x16 --auto-file-renaming=false --allow-overwrite=false --input-file flux.txt
fi

python3 /app/ComfyUI/main.py --listen --port "${PORT:-7860}" "$@"
