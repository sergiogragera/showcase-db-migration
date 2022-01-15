--liquibase formatted sql
--changeset sergio:1642268340

ALTER TABLE
    person
ADD
    COLUMN surname VARCHAR(255);

--rollback ALTER TABLE person DROP COLUMN surname;