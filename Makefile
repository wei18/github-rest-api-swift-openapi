#!make

## Variables

# [Special-Targets](https://www.gnu.org/software/make/manual/html_node/Special-Targets.html)
.DEFAULT_GOAL  := install
OPENAPI_PATH   := Submodule/github/rest-api-description/descriptions/api.github.com/api.github.com.json
PACKAGE_PATHS  := Package.swift

## Helper

.SILENT: commit
.PHONY: commit
commit:
	echo "::debug::[commit] start $(file)"
	git add "$(file)"
	git commit -m "Commit via running: make $(file)" >/dev/null \
		&& echo "::notice:: git commit $(file)\n" \
		|| true;
	touch "$(file)";
	echo "::debug::[commit] end $(file)"

.PHONY: swift-openapi-generator
swift-openapi-generator:
	echo "::debug::[generator] setup swift-openapi-generator"
	mise use spm:apple/swift-openapi-generator

## Create sources

%/openapi-generator-config.yml:
	echo "::debug::[config] start $(@D)"
	@mkdir -p "$(@D)"; \
		tag_name=$(shell basename $(shell dirname $@)); \
		echo "::debug::[config] tag=$$tag_name"; \
		swift Scripts/GeneratorConfigBuilder.swift $$tag_name
	echo "::debug::[config] end $(@D)"

%/Client.swift %/Types.swift: $(OPENAPI_PATH)
	echo "::debug::[generate] start $(@D)"
	@echo "\n\nFolder $(@D) running"
	@$(MAKE) "$(@D)/openapi-generator-config.yml"
	echo "::debug::[generate] running openapi-generator"
	swift-openapi-generator generate \
		"$(OPENAPI_PATH)" \
		--config "$(@D)/openapi-generator-config.yml" \
		--output-directory "$(@D)";
	echo "::debug::[generate] finished openapi-generator"
	@touch $(@D)/*.swift
	@rm "$(@D)/openapi-generator-config.yml";
	@echo ;
	echo "::debug::[generate] end $(@D)"

Sources/%: Sources/%/Client.swift Sources/%/Types.swift
	echo "::debug::[target] build $@"
	@$(MAKE) commit file="$@"

FILTERED_NAMES  = $(shell \
	echo "::debug::[parse] start PackageTargetsParser"; \
	swift Scripts/PackageTargetsParser.swift $(OPENAPI_PATH); \
	echo "::debug::[parse] end PackageTargetsParser"; \
)
SOURCE_DIRS    := $(addprefix Sources/, $(FILTERED_NAMES))

.DELETE_ON_ERROR: $(SOURCE_DIRS)
$(PACKAGE_PATHS): $(SOURCE_DIRS)
	echo "::debug::[package] start Package.swift"
	swift Scripts/PackageBuilder.swift "$@"
	@$(MAKE) commit file="$@"
	echo "::debug::[package] end Package.swift"

.spi.yml: $(PACKAGE_PATHS)
	echo "::debug::[spi] start"
	swift Scripts/SPIManifestBuilder.swift
	@$(MAKE) commit file="$@"
	echo "::debug::[spi] end"

.PHONY: Submodule       # Update openapi specification if needed
.NOTPARALLEL: Submodule # Prevent submodule update from running in parallel with other jobs
Submodule:
	echo "::debug::[submodule] start"
ifdef GITHUB_ACTIONS
	echo "::debug::[submodule] CI mode skip update"
	@touch "$(OPENAPI_PATH)"
else
	echo "::debug::[submodule] updating"
	@git submodule update --remote
	@$(MAKE) commit file="$@"
endif
	echo "::debug::[submodule] end"

## Install

install: Submodule .spi.yml
