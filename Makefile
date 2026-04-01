.PHONY: up down restart build logs console sh db-migrate db-rollback \
       db-seed db-reset db-create db-prepare test rspec setup clean bundle-update

up:
	docker compose up -d

up-attached:
	docker compose up

down:
	docker compose down

restart:
	docker compose restart

build:
	docker compose build

build-no-cache:
	docker compose build --no-cache

logs:
	docker compose logs -f

logs-web:
	docker compose logs -f web

ps:
	docker compose ps

console:
	docker compose exec web bin/rails console

sh:
	docker compose exec web bash

routes:
	docker compose exec web bin/rails routes

db-create:
	docker compose exec web bin/rails db:create

db-migrate:
	docker compose exec web bin/rails db:migrate

db-rollback:
	docker compose exec web bin/rails db:rollback

db-seed:
	docker compose exec web bin/rails db:seed

db-reset:
	docker compose exec web bin/rails db:reset

db-prepare:
	docker compose exec web bin/rails db:prepare

db-status:
	docker compose exec web bin/rails db:migrate:status

db-console:
	docker compose exec db psql -U eazybox eazybox

test:
	docker compose run --rm -e RAILS_ENV=test test

rspec:
	docker compose run --rm -e RAILS_ENV=test test

test-prepare:
	docker compose exec web bin/rails db:test:prepare

lint:
	docker compose exec web bin/rubocop

lint-fix:
	docker compose exec web bin/rubocop --force-exclusion -A

security:
	docker compose exec web bin/brakeman

audit:
	docker compose exec web bin/bundler-audit

bundle:
	docker compose run --rm web bundle install

bundle-update:
	docker compose run --rm web bundle update $(GEMS)

setup:
	docker compose up -d --build
	docker compose exec web bin/rails db:prepare

clean:
	docker compose down -v

help:
	@echo "  up                 Start all services (detached)"
	@echo "  up-attached        Start all services (attached, shows logs)"
	@echo "  down               Stop and remove containers"
	@echo "  restart            Restart all services"
	@echo "  build              Rebuild images"
	@echo "  build-no-cache     Rebuild images from scratch"
	@echo "  logs               Tail logs from all services"
	@echo "  logs-web           Tail logs from web only"
	@echo "  ps                 Show running containers"
	@echo "  console            Open Rails console"
	@echo "  sh                 Open a shell in the web container"
	@echo "  routes             List all routes"
	@echo "  db-create          Create the database"
	@echo "  db-migrate         Run pending migrations"
	@echo "  db-rollback        Rollback last migration"
	@echo "  db-seed            Run seeds"
	@echo "  db-reset           Drop, create, migrate, and seed"
	@echo "  db-prepare         Create (if needed) and migrate"
	@echo "  db-status          Show migration status"
	@echo "  db-console         Open psql console"
	@echo "  test               Run the test suite"
	@echo "  rspec              Run the RSpec suite"
	@echo "  test-prepare       Prepare the test database"
	@echo "  lint               Run RuboCop"
	@echo "  lint-fix           Run RuboCop with auto-correct"
	@echo "  security           Run Brakeman security scan"
	@echo "  audit              Run bundle-audit"
	@echo "  bundle             Run bundle install"
	@echo "  bundle-update      Update gems (use GEMS='gem1 gem2')"
	@echo "  setup              Build, start, and prepare the database"
	@echo "  clean              Stop containers and remove volumes"

.DEFAULT_GOAL := help
