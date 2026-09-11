BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "todo_list" ADD COLUMN "inviteCode" text;
CREATE UNIQUE INDEX "todo_list_invite_code_idx" ON "todo_list" USING btree ("inviteCode");

--
-- MIGRATION VERSION FOR todolist
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('todolist', '20260901075149326', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260901075149326', "timestamp" = now();

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
