include .env

DOCKER_COMPOSE=docker-compose --env-file .env

default: help
all: init up sleep migrate
install: init build

.PHONY: help
help:  ## Display this help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

.PHONY:
init: ## Initialize the environment
	@rsync -avz --ignore-existing example.env .env
	include .env

.PHONY: up
up: ## Spin up the containers
	@$(DOCKER_COMPOSE) up -d

.PHONY: migrate
migrate: ## Perform the migration
	./scripts/execute.sh

.PHONY: stop
stop: ## Stop the containers
	@$(DOCKER_COMPOSE) stop

.PHONY: down
down: ## Delete the containers and their volumes
	@$(DOCKER_COMPOSE) down -v

.PHONY: build
build: ## Build and spin up the containers
	@$(DOCKER_COMPOSE) up --build -d

.PHONY: rebuild
rebuild: ## Spin the containers down and back up again
	@$(DOCKER_COMPOSE) down -v
	@$(DOCKER_COMPOSE) up --build -d

.PHONY: ssh
ssh: ## Enter the postgres container as root
	@$(DOCKER_COMPOSE) exec postgres /bin/bash

.PHONY: sleep
sleep:
	@sleep 2

# https://stackoverflow.com/a/6273809/1826109
%:
	@:
