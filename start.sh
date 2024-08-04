#!/bin/bash

set -e

DOWNLOAD_FLUX=1

if [ ! -d "/app/ComfyUI/.git" ]; then
	git clone https://github.com/comfyanonymous/ComfyUI
	if [ -n "$DOWNLOAD_FLUX" ]; then
		mkdir -p \
			/app/ComfyUI/models/clip \
			/app/ComfyUI/models/vae \
			/app/ComfyUI/models/unet
		aria2c -s16 -x16 --input-file flux.txt
	fi
	git clone https://github.com/ltdrdata/ComfyUI-Manager /app/ComfyUI/custom_nodes/ComfyUI-Manager
	# Dependencies for frequently-used
	# (Do this firstly so PIP won't be solving too many deps at one time)
	uv pip install --system \
		-r /app/ComfyUI/requirements.txt \
		-r https://raw.githubusercontent.com/comfyanonymous/ComfyUI/master/requirements.txt \
		-r https://raw.githubusercontent.com/crystian/ComfyUI-Crystools/main/requirements.txt \
		-r https://raw.githubusercontent.com/cubiq/ComfyUI_essentials/main/requirements.txt \
		-r https://raw.githubusercontent.com/Fannovel16/comfyui_controlnet_aux/main/requirements.txt \
		-r https://raw.githubusercontent.com/jags111/efficiency-nodes-comfyui/main/requirements.txt \
		-r https://raw.githubusercontent.com/ltdrdata/ComfyUI-Impact-Pack/Main/requirements.txt \
		-r https://raw.githubusercontent.com/ltdrdata/ComfyUI-Impact-Subpack/main/requirements.txt \
		-r https://raw.githubusercontent.com/ltdrdata/ComfyUI-Inspire-Pack/main/requirements.txt \
		-r https://raw.githubusercontent.com/ltdrdata/ComfyUI-Manager/main/requirements.txt \
		-r https://github.com/gokayfem/ComfyUI_VLM_nodes/raw/main/requirements.txt \
		-r https://github.com/cubiq/ComfyUI_essentials/raw/main/requirements.txt \
		-r https://github.com/Fannovel16/comfyui_controlnet_aux/raw/main/requirements.txt
	python3 /app/ComfyUI/custom_nodes/ComfyUI-Manager/cm-cli.py install ComfyUI-Custom-Scripts ComfyUI_Comfyroll_CustomNodes ComfyUI_UltimateSDUpscale ComfyUI-Crystools SimpleWildcardsComfyUI ComfyUI-Inspire-Pack ComfyUI-Impact-Pack efficiency-nodes-comfyui rgthree-comfy comfyui-reactor-node ComfyUI_essentials ComfyUI_VLM_nodes comfyui_controlnet_aux
fi

python3 /app/ComfyUI/main.py --listen --port "${PORT:-7860}" "$@"
