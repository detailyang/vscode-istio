PROTO := protoc
REPO  := ${GOPATH}/src/istio.io/api
FLAGS := ${FLAGS} --proto_path=${REPO}
FLAGS := ${FLAGS} -I=${GOPATH}/src
FLAGS := ${FLAGS} -I=${GOPATH}/src/github.com/gogo/protobuf/
TARGETS := ./snippets/istio.json

.PHONY: help
help: ## Show this help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {sub("\\\\n",sprintf("\n%22c"," "), $$2);printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: all
all: build ## Build snippets.

.PHONY: build
build: networking ## Build all snippets.

.PHONY: networking
networking: ## Build networking snippets.
	${PROTO} ${FLAGS} --istio-vscode_out=./snippets --istio-vscode_opt=istio,istio.networking.json ${REPO}/networking/v1alpha3/*.proto
