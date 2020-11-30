.DEFAULT_GOAL := help

# Job parameter: src directory.
CURRENT_DIR := $(shell pwd)
BUILD_DIR := public

.PHONY: help lint clean build

#help:	@ List available tasks on this project
help:
	@grep -E '[a-zA-Z\.\-]+:.*?@ .*$$' $(MAKEFILE_LIST)| tr -d '#'  | awk 'BEGIN {FS = ":.*?@ "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

#lint: @ Lint package
lint:
	@echo "> Linting."; \
	for CHART_DIR in $(shell ls -d $(CURRENT_DIR)/julb/*/ ); do \
		echo "---"; \
		helm lint $$CHART_DIR; \
	done

#clean: @ Clean package
clean:
	@echo "> Cleaning."; \
	rm -rf $(BUILD_DIR)

#build: @ Build packages
build: clean
	@echo "> Building."; \
	wget -q --no-check-certificate https://charts.julb.me/content.tar.gz -O prev_content.tar.gz || true; \
	if [ -s prev_content.tar.gz ]; then \
		tar -xzf prev_content.tar.gz; \
	fi; \
	rm prev_content.tar.gz; \
	mkdir -p $(BUILD_DIR); \
	for CHART_DIR in $(shell ls -d $(CURRENT_DIR)/julb/*/ ); do \
		helm package $$CHART_DIR -d $(BUILD_DIR); \
	done; \
	helm repo index $(BUILD_DIR)/ --url https://charts.julb.me; \
	cp artifacthub-repo.yml $(BUILD_DIR)/; \
  	tar -zcf content.tar.gz public/ && mv content.tar.gz $(BUILD_DIR)/; \
	echo "> Done."