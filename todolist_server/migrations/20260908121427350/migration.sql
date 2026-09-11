BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE IF NOT EXISTS "todo_note" (
    "id" bigserial PRIMARY KEY,
    "title" text NOT NULL,
    "content" text NOT NULL,
    "todoListId" bigint NOT NULL,
    "createdById" uuid NOT NULL,
    "createdByName" text,
    "color" bigint,
    "isPinned" boolean NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone
);

-- Indexes
CREATE INDEX IF NOT EXISTS "todo_note_list_idx" ON "todo_note" USING btree ("todoListId");

--
-- MIGRATION VERSION FOR todolist
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('todolist', '20260908121427350', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260908121427350', "timestamp" = now();

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
