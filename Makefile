.PHONY: help
help:
	@echo 'make help              Show this help message'
	@echo 'make services          Run DB in Docker Compose'
	@echo 'make db                Upgrade the DB schema to the latest version'
	@echo 'make db-drop           Drop all object from DB'
	@echo 'make db-reset          Drop all and upgrade to the latest version'

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

define liquibase_clean_command
	$(liquibase) drop-all 
endef

define flyway
	docker run --network="host" \
	--rm -v `pwd`/db/changelog:/flyway/sql \
	flyway/flyway \
	-url=jdbc:${POSTGRES_JDBC}/${POSTGRES_DB} \
	-user=${POSTGRES_USER} -password=${POSTGRES_PASSWORD} 
endef

define flyway_migration_command
	$(flyway) migrate 
endef

define flyway_clean_command
	$(flyway) clean
endef

define migration_command
	$(call $(1)_migration_command)
endef

define clean_command
	$(call $(1)_clean_command)
endef

.PHONY: services
services:
	@docker-compose up -d

.PHONY: db
db: 
	$(call migration_command,$(MIGRATION_TOOL))

.PHONY: db-drop
db-drop:
	$(call clean_command,$(MIGRATION_TOOL))

.PHONY: db-reset
db-reset: db-drop db

MIGRATION_TOOL=flyway

include database.env
export