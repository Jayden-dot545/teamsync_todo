BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "todo_chat_message" ADD COLUMN "recipientUserId" uuid;
ALTER TABLE "todo_chat_message" ADD COLUMN "recipientName" text;
ALTER TABLE "todo_chat_message" ADD COLUMN "isPrivate" boolean;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "todo_list_member" ADD COLUMN "userBio" text;
ALTER TABLE "todo_list_member" ADD COLUMN "userAvatar" text;
ALTER TABLE "todo_list_member" ADD COLUMN "userStatus" text;

--
-- MIGRATION VERSION FOR todolist
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('todolist', '20260828101810713', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260828101810713', "timestamp" = now();

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
