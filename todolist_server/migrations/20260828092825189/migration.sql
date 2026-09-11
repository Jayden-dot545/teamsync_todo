BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "todo_chat_message" (
    "id" bigserial PRIMARY KEY,
    "todoListId" bigint NOT NULL,
    "senderUserId" uuid NOT NULL,
    "senderName" text NOT NULL,
    "senderRole" text NOT NULL,
    "message" text NOT NULL,
    "sentAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "todo_chat_message_list_time_idx" ON "todo_chat_message" USING btree ("todoListId", "sentAt");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "todo_chat_message"
    ADD CONSTRAINT "todo_chat_message_fk_0"
    FOREIGN KEY("todoListId")
    REFERENCES "todo_list"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR todolist
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('todolist', '20260828092825189', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260828092825189', "timestamp" = now();

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
