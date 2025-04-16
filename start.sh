#!/bin/bash

set -euo pipefail

if [ ! -d "/app/ComfyUI/.git" ]; then
  git clone https://github.com/comfyanonymous/ComfyUI /app/ComfyUI
fi

if [ ! -d '/app/ComfyUI/custom_nodes/ComfyUI-Manager/.git' ]; then
  git clone https://github.com/Comfy-Org/ComfyUI-Manager /app/ComfyUI/custom_nodes/ComfyUI-Manager
fi

source /app/.venv/bin/activate
cd /app/ComfyUI

COMFY_CLI="comfy --skip-prompt --here"

$COMFY_CLI tracking disable

# python3 uvx comfy-cli --skip-prompt --here node install \
#   ComfyUI-Custom-Scripts \
#   ComfyUI_Comfyroll_CustomNodes \
#   ComfyUI_UltimateSDUpscale \
#   ComfyUI-Crystools \
#   SimpleWildcardsComfyUI \
#   ComfyUI-Inspire-Pack \
#   ComfyUI-Impact-Pack \
#   efficiency-nodes-comfyui \
#   rgthree-comfy \
#   comfyui-reactor-node \
#   ComfyUI_essentials \
#   ComfyUI-GGUF \
#   comfyui_controlnet_aux

# mkdir -p \
#   /app/ComfyUI/models/clip \
#   /app/ComfyUI/models/vae \
#   /app/ComfyUI/models/checkpoints \
#   /app/ComfyUI/models/unet
#
# if [ $DOWNLOAD_FLUX -eq 1 ]; then
#   echo "INFO: Downloading Flux..."
#   aria2c -s16 -x16 --auto-file-renaming=false --allow-overwrite=false --continue=true --input-file flux.txt || true
# fi
#
# aria2c -s16 -x16 --auto-file-renaming=false --allow-overwrite=false --continue=true --input-file models.txt || true

$COMFY_CLI launch -- --listen --port "${PORT:-7860}" "$@"
