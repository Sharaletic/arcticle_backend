include .env
export

export PROJECT_ROOT=$(shell pwd)

env-up:
	@docker compose up -d article-postgres

env-down:
	@docker compose down article-postgres

env-cleanup:
	@read -p "Очистить все valume файлы окружения? (y/n) " answer; \
	if [ "$$answer" = "y" ]; then \
		docker compose down article-postgres; \
		rm -rf out/pgdata && \
		echo "Файлы окружения очищены"; \
	else \
		echo "Очистка файлов окружения отменена"; \
	fi

migrate-create:
	@if [ -z "$(seq)" ]; then \
		echo "Необходимо указать имя миграции. Используйте: make migrate-create seq=<имя_миграции>"; \
		exit 1; \
	fi; \
	docker compose run --rm article-postgres-migrate \
		create \
		-ext sql \
		-dir /migrations \
		-seq "$(seq)"

env-port-forward:
	@docker compose up -d port-forwarder

env-port-close:
	@docker compose down port-forwarder

migrate-up:
	@make migrate-action action=up

migrate-down:
	@make migrate-action action=down

migrate-action:
	@if [ -z "$(action)" ]; then \
		echo "Отсутствует необходимый параметр action. Используйте: make migrate-create action=<имя_действия>"; \
		exit 1; \
	fi; \
	docker compose run --rm article-postgres-migrate \
		-path /migrations \
		-database postgres://${POSTGRES_USER}:${POSTGRES_PASSWORD}@article-postgres:5432/${POSTGRES_DB}?sslmode=disable \
		"$(action)"