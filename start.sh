#! /bin/sh

set -e

if [ ! -d "/app/ComfyUI/.git" ]; then
	git clone https://github.com/comfyanonymous/ComfyUI
	uv pip install --system -r /app/ComfyUI/requirements.txt
fi

if [ ! -d "/app/ComfyUI/custom_nodes/ComfyUI-Manager/.git" ]; then
	git clone https://github.com/ltdrdata/ComfyUI-Manager /app/ComfyUI/custom_nodes/ComfyUI-Manager
	uv pip install --system -r /app/ComfyUI/custom_nodes/ComfyUI-Manager/requirements.txt
	python3 /app/ComfyUI/custom_nodes/ComfyUI-Manager/cm-cli.py install ComfyUI-Custom-Scripts ComfyUI-Crystools SimpleWildcardsComfyUI ComfyUI-Inspire-Pack ComfyUI-Impact-Pack ComfyUI_IPAdapter_plus efficiency-nodes-comfyui rgthree-comfy comfyui-reactor-node
fi
python3 /app/ComfyUI/main.py --listen --port "${PORT:-7860}" "$@"
