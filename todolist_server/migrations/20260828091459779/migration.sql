BEGIN;

--
-- ACTION ALTER TABLE
--
DROP INDEX "todo_list_member_unique_idx";
ALTER TABLE "todo_list_member" ALTER COLUMN "userId" DROP NOT NULL;
CREATE INDEX "todo_list_member_list_email_idx" ON "todo_list_member" USING btree ("todoListId", "userEmail");

--
-- MIGRATION VERSION FOR todolist
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('todolist', '20260828091459779', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260828091459779', "timestamp" = now();

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
