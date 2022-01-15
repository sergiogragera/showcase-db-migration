# DB migration strategy

This project shows how to execute a migration strategy in evolutionary databases in order to avoid collisions when working with different branches.

## Installation

We need to install [Docker](https://docs.docker.com/get-docker/) in order to deploy the database and migration tool containers. In this first version we use PostgreSQL and Liquibase images.

## Usage

After starting the necessary services (for now just a SQL database) we can run migration commands like `make db` which will upgrade the DB schema to the latest version. Get more details by running `make help`: 

```
make help              Show this help message
make services          Run DB in Docker Compose
make db                Upgrade the DB schema to the latest version
make db-drop           Drop all object from DB
make db-reset          Drop all and upgrade to the latest version
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.