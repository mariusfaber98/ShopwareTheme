#
# Makefile
#

.PHONY: help
.DEFAULT_GOAL := help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

# ------------------------------------------------------------------------------------------------------------

prod: ## Installs all production dependencies
	cd Resources/app/storefront && npm install --production

dev: ## Installs all dev dependencies
	cd Resources/app/storefront && npm install

clean: ## Cleans all dependencies
	rm -rf ./Resources/app/storefront/node_modules
	rm -rf ./Resources/app/storefront/package-lock.json

build: ## Build
	cd /var/www/html && php bin/console theme:dump
	cd /var/www/html && ./bin/build-storefront.sh

# ------------------------------------------------------------------------------------------------------------

stylelint: ## Starts the Stylelinter
	cd ./Resources/app/storefront/ && npm run lint:scss
