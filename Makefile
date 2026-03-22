#!make

## Variables

# [Special-Targets](https://www.gnu.org/software/make/manual/html_node/Special-Targets.html)
.DEFAULT_GOAL  := install
OPENAPI_PATH   := Submodule/github/rest-api-description/descriptions/api.github.com/api.github.com.json
FILTERED_NAMES  = $(shell swift Scripts/PackageTargetsParser.swift $(OPENAPI_PATH))
SOURCE_DIRS     = $(addprefix Sources/, $(FILTERED_NAMES))
PACKAGE_PATHS  := Package.swift

## Helper

.SILENT: commit
.PHONY: commit
commit:
	git add "$(file)"
	git commit -m "Commit via running: make $(file)" >/dev/null \
		&& touch "$(file)" \
		&& echo "::notice::git commit $(file)" \
		|| true;

SWIFT_BUILD_FLAGS = -c release --arch arm64 --arch x86_64
EXECUTABLE_NAME = swift-openapi-generator
EXECUTABLE_PATH = $(shell swift build $(SWIFT_BUILD_FLAGS) --show-bin-path)/$(EXECUTABLE_NAME)
.NOTPARALLEL: .build/bin/swift-openapi-generator
.build/bin/swift-openapi-generator:
	@echo "::debug::make: $@"
	git clone --branch 1.11.0 --single-branch \
		https://github.com/apple/swift-openapi-generator
	cd swift-openapi-generator; swift build $(SWIFT_BUILD_FLAGS);
	mkdir -p $(@D);
		cp -f $(EXECUTABLE_PATH) $@; \
		rm -rf swift-openapi-generator;

## Generate Sources

.INTERMEDIATE: %/openapi-generator-config.yml
%/openapi-generator-config.yml:
	@echo ;
	@echo "::debug::make: $(@D)"
	mkdir -p "$(@D)"
	@echo "::debug::make: $@"
	tag_name=$(shell basename $(shell dirname $@)); \
		swift Scripts/GeneratorConfigBuilder.swift $$tag_name

.NOTPARALLEL: Submodule # Prevent submodule update from running in parallel with other jobs
Submodule:
ifndef GITHUB_ACTIONS
	@echo "::debug::make: $@"
	@git submodule update --remote
	@$(MAKE) commit file="$@"
endif
	@echo ;

$(OPENAPI_PATH): Submodule
	@touch "$@"

%/Client.swift %/Types.swift: $(OPENAPI_PATH) %/openapi-generator-config.yml .build/bin/swift-openapi-generator
	@echo "::debug::make: $@"
	.build/bin/swift-openapi-generator generate \
		"$(OPENAPI_PATH)" \
		--config "$(@D)/openapi-generator-config.yml" \
		--output-directory "$(@D)";

Sources/%: Sources/%/Client.swift Sources/%/Types.swift
	@$(MAKE) commit file="$@"

$(PACKAGE_PATHS): $(SOURCE_DIRS)
	@echo "::debug::make: $@"
	swift Scripts/PackageBuilder.swift "$@"
	@$(MAKE) commit file="$@"

.spi.yml: $(PACKAGE_PATHS)
	@echo "::debug::make: $@"
	swift Scripts/SPIManifestBuilder.swift
	@$(MAKE) commit file="$@"

## main

install: .spi.yml

update:
	$(MAKE) -B Submodule
	$(MAKE) install
