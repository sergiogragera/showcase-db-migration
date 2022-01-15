.PHONY: help
help:
	@echo 'make help              Show this help message'
	@echo 'make services          Run DB in Docker Compose'
	@echo 'make db                Upgrade the DB schema to the latest version'
	@echo 'make db-drop           Drop all object from DB'
	@echo 'make db-reset          Drop all and upgrade to the latest version'
	@echo 'make db-rollback       Rollback last migration from DB'

define liquibase
	docker run --network="host" \
	--rm -v `pwd`/db/changelog:/liquibase/changelog \
	liquibase/liquibase --changelog-file=db.root.xml \
	--url=jdbc:${POSTGRES_JDBC}/${POSTGRES_DB} \
	--username=${POSTGRES_USER} --password=${POSTGRES_PASSWORD}
endef

define liquibase_migration_command
	$(liquibase) update 
endef

define liquibase_drop_command
	$(liquibase) drop-all 
endef

define liquibase_rollback_command
	$(liquibase) rollback-count --count 1
endef

define flyway
	docker run --network="host" \
	--rm -v `pwd`/db/changelog:/flyway/sql \
	flyway/flyway \
	-url=jdbc:${POSTGRES_JDBC}/${POSTGRES_DB} \
	-user=${POSTGRES_USER} -password=${POSTGRES_PASSWORD} 
endef

define flyway_migration_command
	$(flyway) migrate -outOfOrder=true
endef

define flyway_drop_command
	$(flyway) clean
endef

define flyway_rollback_command
	$(flyway) undo
endef

define migration_command
	$(call $(1)_migration_command)
endef

define drop_command
	$(call $(1)_drop_command)
endef

define rollback_command
	$(call $(1)_rollback_command)
endef

.PHONY: services
services:
	@docker-compose up -d

.PHONY: db
db: 
	$(call migration_command,$(MIGRATION_TOOL))

.PHONY: db-drop
db-drop:
	$(call drop_command,$(MIGRATION_TOOL))

.PHONY: db-rollback
db-rollback:
	$(call rollback_command,$(MIGRATION_TOOL))

.PHONY: db-reset
db-reset: db-drop db

include .env
include database.env
export