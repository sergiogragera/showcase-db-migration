--liquibase formatted sql
--changeset sergio:1642199844

ALTER TABLE person ADD COLUMN street VARCHAR(255);

--rollback ALTER TABLE person DROP COLUMN street;