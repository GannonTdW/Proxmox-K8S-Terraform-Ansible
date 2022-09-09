.PHONY: env
env-desc = "Setup local dev env"
env:
	@echo "==> $(env-desc)"

	@[ -d "${PWD}/.direnv" ] || (echo "Venv not found: ${PWD}/.direnv -> Create it" && mkdir "${PWD}/.direnv")
	@pip3 install -U pip wheel setuptools --no-cache-dir && \
	echo "[  OK  ] PIP + WHEEL + SETUPTOOLS" || \
	echo "[FAILED] PIP + WHEEL + SETUPTOOLS"

	@pip3 install -U --no-cache-dir -r "${PWD}/ansible/requirements.txt" && \
	echo "[  OK  ] PIP REQUIREMENTS" || \
	echo "[FAILED] PIP REQUIREMENTS"
	
	@ansible-galaxy install -fr "${PWD}/ansible/requirements.yml" && \
	echo "[  OK  ] ANSIBLE-GALAXY REQUIREMENTS" || \
	echo "[FAILED] ANSIBLE-GALAXY REQUIREMENTS"
