ALTER TABLE person ADD COLUMN street VARCHAR(255);

--preconditions onFail:HALT onError:HALT
--precondition-sql-check expectedResult:1 SELECT COUNT(1) FROM pg_tables WHERE TABLENAME = 'person'