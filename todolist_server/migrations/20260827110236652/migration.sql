BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "todo_list_member" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "todo_list" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "todo_item" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "calculation_entry" (
    "id" bigserial PRIMARY KEY,
    "firstOperand" text NOT NULL,
    "operation" text NOT NULL,
    "secondOperand" text NOT NULL,
    "result" text NOT NULL,
    "isError" boolean NOT NULL,
    "timestamp" timestamp without time zone NOT NULL
);


--
-- MIGRATION VERSION FOR todolist
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('todolist', '20260827110236652', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260827110236652', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260416151914983-insights-perf', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260416151914983-insights-perf', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260417182309198', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260417182309198', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260417182253191', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260417182253191', "timestamp" = now();


COMMIT;
