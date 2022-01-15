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

.PHONY: services
services:
	@docker-compose up -d

.PHONY: db
db:
	@$(liquibase) update

.PHONY: db-drop
db-drop:
	@$(liquibase) drop-all

.PHONY: db-reset
db-reset: db-drop db

include database.env
export