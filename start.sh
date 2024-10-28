#!/bin/bash

set -e

source /app/.venv/bin/activate

if [ ! -d "/app/ComfyUI/.git" ]; then
  git clone https://github.com/comfyanonymous/ComfyUI
fi
if [ ! -d "/app/ComfyUI/custom_nodes/ComfyUI-Manager/.git" ]; then
  git clone https://github.com/ltdrdata/ComfyUI-Manager /app/ComfyUI/custom_nodes/ComfyUI-Manager
fi

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
  ComfyUI-GGUF \
  comfyui_controlnet_aux

mkdir -p \
  /app/ComfyUI/models/clip \
  /app/ComfyUI/models/vae \
  /app/ComfyUI/models/checkpoints \
  /app/ComfyUI/models/unet

if [ $DOWNLOAD_FLUX -eq 1 ]; then
  echo "INFO: Downloading Flux..."
  aria2c -s16 -x16 --auto-file-renaming=false --allow-overwrite=false --continue=true --input-file flux.txt || true
fi

aria2c -s16 -x16 --auto-file-renaming=false --allow-overwrite=false --continue=true --input-file models.txt || true

python3 /app/ComfyUI/main.py --listen --port "${PORT:-7860}" "$@"
