# ==== Versions ====
K8S_CODEGEN_VERSION ?= v0.34.1
CTRLR_TOOLS_VERSION ?= v0.19.0

## Install codegen & optional tools
install-tools:
	@echo "==> Installing tools ..."
	@K8S_CODEGEN_VERSION=$(K8S_CODEGEN_VERSION) \
	 CTRLR_TOOLS_VERSION=$(CTRLR_TOOLS_VERSION) \
	 bash hack/install-tools.sh