default: help

all: init up sleep migrate
install: init up

.PHONY: help
help:  ## Display this help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

.PHONY:
init: ## Initialize the environment
	rsync -avz --ignore-existing example.env .env

.PHONY: up
up: ## Spin up the containers
	docker-compose up -d

.PHONY: build
build: ## Build and spin up the containers
	docker-compose up --build -d

.PHONY: migrate
migrate: ## Perform the migration
	./scripts/execute.sh

.PHONY: stop
stop: ## Stop the containers
	docker-compose stop

.PHONY: down
down: ## Delete the containers and their volumes
	docker-compose down -v

.PHONY: rebuild
rebuild: ## Spin the containers down and back up again
	docker-compose down -v
	docker-compose up --build -d

.PHONY: ssh
ssh: ## Enter the postgres container as root
	docker-compose exec postgres /bin/bash

.PHONY: sleep
sleep:
	sleep 2
