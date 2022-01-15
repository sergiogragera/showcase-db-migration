--liquibase formatted sql
--changeset sergio:1642268340

ALTER TABLE
    person
ADD
    COLUMN surname VARCHAR(255);

--preconditions onFail:HALT onError:HALT
--precondition-sql-check expectedResult:1 SELECT COUNT(1) FROM pg_tables WHERE TABLENAME = 'person'
--rollback ALTER TABLE person DROP COLUMN surname;