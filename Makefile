.PHONY: help
help: ## Usage
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: first-build
first-build: ## First Settings
	@make build
	@make rails-command ARG=db:create
	@make rails-command ARG=db:migrate

.PHONY: build
build: ## Build Services
	@docker compose build

.PHONY: hard-build
hard-build: ## Build without using cache
	@docker compose build --no-cache

.PHONY: up
up: ## Start containers
	@docker compose up

.PHONY: up-d
up-d: ## Start Containers in the background
	@docker compose up -d

.PHONY: down
down: ## Remove containers
	@docker compose down

.PHONY: stop
stop: ## Stop Containers
	@docker compose stop

.PHONY: restart
restart: ## Container Stop and Up
	@make stop
	@make up-d

.PHONY: console
console: ## Use Rails Console
	@make rails-command ARG=c

ARG=
.PHONY: rails-command
rails-command:
	@make up-d
	@docker exec -it daikou-app-web-1 rails ${ARG}

.PHONY: routes
routes: ## Print Routings
	@make rails-command ARG=routes

.PHONY: test
test: ## Running Rspec
	@make up-d
	@docker exec -it daikou-app-web-1 bundle exec rspec

.PHONY: bash
bash: ## Use bash
	@make up-d
	@docker exec -it daikou-app-web-1 bash