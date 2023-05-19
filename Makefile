# --- IMPORTS ---

# Imports environment variables.
environment_vars ?= .env

include $(environment_vars)
export $(shell sed 's/=.*//' $(environment_vars))

# --- ARGUMENTS ---

override docker?=${CLI_USE_DOCKER}
override tag?=${DOCKER_IMAGE_TAG}
override platform?=${DOCKER_IMAGE_PLATFORM}
override config?=${SWIFT_BUILD_CONFIGURATION}
override clean?=${DOCKER_IMAGE_CLEAN}

# --- IDE ---

xcode: ## Open this package in Xcode.
	@open -a Xcode Package.swift

vscode: ## Open this package with Visual Studio Code.
	@code .

# --- DEPENDENCIES ---

outdated: ## List the package dependencies that can be updated.
	@swift package update --dry-run

update: ## Update the package dependencies defined in the project.
	@swift package update

# --- DEVELOPMENT ---

build: ## Build this package with Swift either locally or in a Docker image.
ifeq ($(docker),yes)
	@-docker run \
		--rm \
		--volume ${PWD}:${DOCKER_VOLUME_TARGET} \
		--workdir ${DOCKER_VOLUME_TARGET} \
		--platform ${platform} \
		${DOCKER_IMAGE_NAME}:${tag} \
		swift build --configuration ${config}
    ifeq ($(clean),yes)
		@docker rmi ${DOCKER_IMAGE_NAME}:${tag}
    endif
else
	@swift build --configuration ${config}
endif

# --- TESTING ---

test: ## Test this package with Swift either locally or in a Docker image.
ifeq ($(docker),yes)
	@-docker run \
		--rm \
		--volume ${PWD}:${DOCKER_VOLUME_TARGET} \
		--workdir ${DOCKER_VOLUME_TARGET} \
		--platform ${platform} \
		${DOCKER_IMAGE_NAME}:${tag} \
		swift test --configuration ${config}
    ifeq ($(clean),yes)
		@docker rmi ${DOCKER_IMAGE_NAME}:${tag}
    endif
else
	@swift test --configuration ${config}
endif

# --- HOUSE-KEEPING ---

clean: ## Clean the build artifacts of the package.
	@swift package clean

reset: ## Reset the build folder of the package.
	@swift package reset

flush-images: ## Flush all outstanding Swift docker images.
	@docker images \
		--all | grep ${DOCKER_IMAGE_NAME} | awk '{print $$3}' | xargs docker rmi --force

# --- HELP ---

# Outputs the documentation for each of the defined tasks when `help` is called.
# Reference: https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

help: ## Prints the written documentation for all the defined tasks.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help
