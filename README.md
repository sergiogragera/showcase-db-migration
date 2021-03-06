# Showcase DB migration and Tools

This project demostrates how to execute a migration strategy in evolutionary databases in order to avoid collisions when working with different branches. This repo use Liquibase and Flyway migration tools.

## Installation

We need to install [Docker](https://docs.docker.com/get-docker/) in order to deploy the database and migration tool containers. In this first version we use PostgreSQL as database system and Liquibase or Flyway as migration tool.

## Usage

First we need to add the environment configuration. We have to create the `database.env` file with the following variables:

```
POSTGRES_USER=user
POSTGRES_PASSWORD=pass
POSTGRES_DB=db
POSTGRES_PORT=5432
POSTGRES_JDBC=postgresql://127.0.0.1:${POSTGRES_PORT}/${POSTGRES_DB}
```

Then, we need to define migration tool. We have to create the `.env` file with following variable:

```
MIGRATION_TOOL={liquibase,flyway}
```

After starting the necessary services (for now just a SQL database) we can run migration commands like `make db` which will upgrade the DB schema to the latest version. Get more details by running `make help`: 

```
make help              Show this help message
make services          Run DB in Docker Compose
make db                Upgrade the DB schema to the latest version
make db-drop           Drop all object from DB
make db-reset          Drop all and upgrade to the latest version
make db-rollback       Rollback last migration from DB
make db-validate       Validate migrations
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.
