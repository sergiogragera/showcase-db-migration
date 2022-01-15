--liquibase formatted sql
--changeset sergio:1642199842

CREATE TABLE person (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255)
);

--rollback DROP TABLE person;