#!/usr/bin/env bash
set -euo pipefail

# ==== Editable ====
K8S_CODEGEN_VERSION="${K8S_CODEGEN_VERSION:-v0.34.1}"	# k8s.io/apimachinery
CTRLR_TOOLS_VERSION="${CTRLR_TOOLS_VERSION:-v0.19.0}"	# 옵션: CRD YAML 생성 시 사용

# ==== Go env ====
if ! command -v go > /dev/null 2>&1; then
	echo "[ERROR] Go not found. Install Go first."
	exit 1
fi

# Ensure GOPATH/bin in PATH for current shell
GOBIN="$(go env GOPATH)/bin"
mkdir -p "$GOBIN"
case ":$PATH:" in
	*":$GOBIN:"*) : ;;
	*) echo "export PATH=\"$GOBIN:\$PATH\"" >> "${HOME}/.bashrc"; export PATH="$GOBIN:$PATH" ;;
esac

echo "[INFO] Installing Kubernetes code-generator binaries (@{K8S_CODEGEN_VERSION}) ..."
# Core Generator (required)
go install "k8s.io/code-generator/cmd/deepcopy-gen@${K8S_CODEGEN_VERSION}"
go install "k8s.io/code-generator/cmd/client-gen@${K8S_CODEGEN_VERSION}"
go install "k8s.io/code-generator/cmd/lister-gen@${K8S_CODEGEN_VERSION}"
go install "k8s.io/code-generator/cmd/informer-gen@${K8S_CODEGEN_VERSION}"

# Optional Generator (Optional)
go install "k8s.io/code-generator/cmd/defaulter-gen@${K8S_CODEGEN_VERSION}" || true
go install "k8s.io/code-generator/cmd/conversion-gen@${K8S_CODEGEN_VERSION}" || true

echo "[INFO] Installing controller-gen (optional, for CRD YAMLs) ..."
go install "sigs.k8s.io/controller-tools/cmd/controller-gen@${CTRLR_TOOLS_VERSION}" || true

echo "[OK] Tools installed to $GOBIN"