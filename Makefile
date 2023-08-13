# --- IMPORTS --- #

# Imports environment variables.
environment_vars ?= .env

include $(environment_vars)
export $(shell sed 's/=.*//' $(environment_vars))

# --- ARGUMENTS --- #

override clean?=${DOCKER_IMAGE_CLEAN}
override config?=${SWIFT_BUILD_CONFIGURATION}
override docker?=${CLI_USE_DOCKER}
override library?=${DOCKER_TARGET_COMPONENT}
override platform?=${DOCKER_IMAGE_PLATFORM}
override tag?=${DOCKER_IMAGE_TAG}

# --- IDE --- #

xcode: ## Open this package in Xcode.
	@open -a Xcode Package.swift

vscode: ## Open this package with Visual Studio Code.
	@code .

# --- DEPENDENCIES --- #

outdated: ## List the package dependencies that can be updated.
	@swift package update --dry-run

update: ## Update the package dependencies defined in the project.
	@swift package update

# --- DEVELOPMENT --- #

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

# --- TESTING --- #

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

# --- DOCUMENTAION --- #

generate-docs: ## Generate DocC documentation for both Xcode and Web.
	@make generate-index-start
	@make generate-doc-communication 
	@make generate-doc-coordination 
	@make generate-doc-dependency 
	@make generate-doc-foundation 
	@make generate-doc-persistence 
	@make generate-index-finish

generate-doc-communication: SWIFT_TARGET_NAME=SwiftLibsCommunication
generate-doc-communication: SWIFT_TARGET_COMPONENT=communication
generate-doc-communication: generate-doc-xcode generate-doc-github generate-index-link

generate-doc-coordination: SWIFT_TARGET_NAME=SwiftLibsCoordination
generate-doc-coordination: SWIFT_TARGET_COMPONENT=coordination
generate-doc-coordination: generate-doc-xcode generate-doc-github generate-index-link

generate-doc-dependency: SWIFT_TARGET_NAME=SwiftLibsDependency
generate-doc-dependency: SWIFT_TARGET_COMPONENT=dependency
generate-doc-dependency: generate-doc-xcode generate-doc-github generate-index-link

generate-doc-foundation: SWIFT_TARGET_NAME=SwiftLibsFoundation
generate-doc-foundation: SWIFT_TARGET_COMPONENT=foundation
generate-doc-foundation: generate-doc-xcode generate-doc-github generate-index-link

generate-doc-persistence: SWIFT_TARGET_NAME=SwiftLibsPersistence
generate-doc-persistence: SWIFT_TARGET_COMPONENT=persistence
generate-doc-persistence: generate-doc-xcode generate-doc-github generate-index-link

generate-doc-xcode:
	@swift package \
		--allow-writing-to-directory ${DOCC_XCODE_DIRECTORY} \
		generate-documentation \
		--include-extended-types \
		--target ${SWIFT_TARGET_NAME} \
		--output-path ${DOCC_XCODE_OUTPUT}

generate-doc-github:
	@swift package \
		--allow-writing-to-directory ${DOCC_GITHUB_DIRECTORY} \
		generate-documentation \
		--target ${SWIFT_TARGET_NAME} \
		--include-extended-types \
		--disable-indexing \
		--transform-for-static-hosting \
		--hosting-base-path ${DOCC_GITHUB_BASE_PATH} \
		--output-path ${DOCC_GITHUB_OUTPUT}

generate-index-start:
	@echo "<html>" >> ${DOCC_GITHUB_INDEX}
	@echo "<head>" >> ${DOCC_GITHUB_INDEX}
	@echo "<title>${SWIFT_TARGET_NAME} libraries</title>" >> ${DOCC_GITHUB_INDEX}
	@echo "</head>" >> ${DOCC_GITHUB_INDEX}
	@echo "<body>" >> ${DOCC_GITHUB_INDEX}
	@echo "<ul>" >> ${DOCC_GITHUB_INDEX}

generate-index-link:
	@echo "<li><a href=\"${DOCC_GITHUB_BASE_URL}${SWIFT_TARGET_COMPONENT}\" target=\"_self\"><code>${SWIFT_TARGET_NAME}</code> library docs</a></li>" >> ${DOCC_GITHUB_INDEX}

generate-index-finish:
	@echo "</ul>" >> ${DOCC_GITHUB_INDEX}
	@echo "</body>" >> ${DOCC_GITHUB_INDEX}
	@echo "</html>" >> ${DOCC_GITHUB_INDEX}

preview-doc: set-target ## Preview DocC documentation for a particular library.
	@open -a safari ${DOCC_PREVIEW_URL}${library}
	@swift package \
		--disable-sandbox \
		preview-documentation \
		--include-extended-types \
		--target ${target}

# --- HOUSE-KEEPING --- #

clean: ## Clean the build artifacts of the package.
	@swift package clean

reset: ## Reset the build folder of the package.
	@swift package reset

flush-docs: ## Flush the documentation for Xcode and Web.
ifeq ("$(shell test -e ${DOCC_GITHUB_DIRECTORY} && echo yes)","yes")
	@rm -rf ${DOCC_GITHUB_DIRECTORY}
	@mkdir ${DOCC_GITHUB_DIRECTORY}
endif
ifeq ("$(shell test -e ${DOCC_XCODE_DIRECTORY} && echo yes)","yes")
	@rm -rf ${DOCC_XCODE_DIRECTORY}
	@mkdir ${DOCC_XCODE_DIRECTORY}
endif

flush-images: ## Flush all outstanding Swift docker images.
	@docker images \
		--all | grep ${DOCKER_IMAGE_NAME} | awk '{print $$3}' | xargs docker rmi --force

# --- HELPERS --- #

set-target:
override target?=${SWIFT_TARGET_NAME}
ifeq (${library},communication)
override target=SwiftLibsCommunication
endif
ifeq (${library},coordination)
override target=SwiftLibsCoordination
endif
ifeq (${library},dependency)
override target=SwiftLibsDependency
endif
ifeq (${library},foundation)
override target=SwiftLibsFoundation
endif
ifeq (${library},persistence)
override target=SwiftLibsPersistence
endif

# --- HELP --- #

# Output the documentation for each of the defined tasks when `help` is called.
# Reference: https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

help: ## Print the written documentation for all the defined tasks.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

help-docc-plugin: ## Print the help for the Swift-DocC plugin.
	@swift package plugin generate-documentation --help

.DEFAULT_GOAL := help
