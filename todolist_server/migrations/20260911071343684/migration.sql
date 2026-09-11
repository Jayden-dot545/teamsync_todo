BEGIN;

--
-- Safely drop foreign keys if they exist so column types can be altered
--
ALTER TABLE IF EXISTS "todo_activity" DROP CONSTRAINT IF EXISTS "todo_activity_fk_0";
ALTER TABLE IF EXISTS "todo_chat_message" DROP CONSTRAINT IF EXISTS "todo_chat_message_fk_0";
ALTER TABLE IF EXISTS "todo_item" DROP CONSTRAINT IF EXISTS "todo_item_fk_0";
ALTER TABLE IF EXISTS "todo_list_member" DROP CONSTRAINT IF EXISTS "todo_list_member_fk_0";

--
-- 1. Table: todo_list
--
CREATE TABLE IF NOT EXISTS "todo_list" (
    "id" bigserial PRIMARY KEY,
    "title" text NOT NULL,
    "description" text,
    "color" bigint NOT NULL,
    "ownerId" uuid NOT NULL,
    "inviteCode" text,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone
);
ALTER TABLE "todo_list" ALTER COLUMN "id" TYPE bigint;
ALTER TABLE "todo_list" ALTER COLUMN "color" TYPE bigint;
CREATE UNIQUE INDEX IF NOT EXISTS "todo_list_invite_code_idx" ON "todo_list" USING btree ("inviteCode");

--
-- 2. Table: todo_activity
--
CREATE TABLE IF NOT EXISTS "todo_activity" (
    "id" bigserial PRIMARY KEY,
    "todoListId" bigint NOT NULL,
    "actorUserId" uuid,
    "actorName" text NOT NULL,
    "actionType" text NOT NULL,
    "details" text NOT NULL,
    "targetTitle" text,
    "timestamp" timestamp without time zone NOT NULL
);
ALTER TABLE "todo_activity" ALTER COLUMN "id" TYPE bigint;
ALTER TABLE "todo_activity" ALTER COLUMN "todoListId" TYPE bigint;
CREATE INDEX IF NOT EXISTS "todo_activity_list_time_idx" ON "todo_activity" USING btree ("todoListId", "timestamp");

--
-- 3. Table: todo_chat_message
--
CREATE TABLE IF NOT EXISTS "todo_chat_message" (
    "id" bigserial PRIMARY KEY,
    "todoListId" bigint NOT NULL,
    "senderUserId" uuid NOT NULL,
    "senderName" text NOT NULL,
    "senderRole" text NOT NULL,
    "recipientUserId" uuid,
    "recipientName" text,
    "isPrivate" boolean,
    "message" text NOT NULL,
    "sentAt" timestamp without time zone NOT NULL
);
ALTER TABLE "todo_chat_message" ALTER COLUMN "id" TYPE bigint;
ALTER TABLE "todo_chat_message" ALTER COLUMN "todoListId" TYPE bigint;
CREATE INDEX IF NOT EXISTS "todo_chat_message_list_time_idx" ON "todo_chat_message" USING btree ("todoListId", "sentAt");

--
-- 4. Table: todo_item
--
CREATE TABLE IF NOT EXISTS "todo_item" (
    "id" bigserial PRIMARY KEY,
    "todoListId" bigint NOT NULL,
    "title" text NOT NULL,
    "description" text,
    "isCompleted" boolean NOT NULL,
    "completedAt" timestamp without time zone,
    "completedByUserId" uuid,
    "completedByName" text,
    "dueDate" timestamp without time zone,
    "priority" text NOT NULL,
    "assignedToUserId" uuid,
    "assignedToName" text,
    "createdById" uuid NOT NULL,
    "createdByName" text,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone,
    "sortOrder" double precision NOT NULL,
    "totalDurationSeconds" bigint,
    "timerStartedAt" timestamp without time zone,
    "isTimerRunning" boolean,
    "timerUserId" uuid,
    "timerUserName" text,
    "subtasksJson" text,
    "workSessionsJson" text,
    "recurrence" text
);
ALTER TABLE "todo_item" ALTER COLUMN "id" TYPE bigint;
ALTER TABLE "todo_item" ALTER COLUMN "todoListId" TYPE bigint;
ALTER TABLE "todo_item" ALTER COLUMN "totalDurationSeconds" TYPE bigint;
CREATE INDEX IF NOT EXISTS "todo_item_list_idx" ON "todo_item" USING btree ("todoListId");

--
-- 5. Table: todo_list_member
--
CREATE TABLE IF NOT EXISTS "todo_list_member" (
    "id" bigserial PRIMARY KEY,
    "todoListId" bigint NOT NULL,
    "userId" uuid,
    "userEmail" text,
    "userName" text,
    "userBio" text,
    "userAvatar" text,
    "userStatus" text,
    "role" text NOT NULL,
    "joinedAt" timestamp without time zone NOT NULL
);
ALTER TABLE "todo_list_member" ALTER COLUMN "id" TYPE bigint;
ALTER TABLE "todo_list_member" ALTER COLUMN "todoListId" TYPE bigint;
CREATE INDEX IF NOT EXISTS "todo_list_member_list_email_idx" ON "todo_list_member" USING btree ("todoListId", "userEmail");

--
-- 6. Table: todo_note
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
ALTER TABLE "todo_note" ALTER COLUMN "id" TYPE bigint;
ALTER TABLE "todo_note" ALTER COLUMN "todoListId" TYPE bigint;
ALTER TABLE "todo_note" ALTER COLUMN "color" TYPE bigint;
CREATE INDEX IF NOT EXISTS "todo_note_list_idx" ON "todo_note" USING btree ("todoListId");

--
-- 7. Table: user_account_profile
--
CREATE TABLE IF NOT EXISTS "user_account_profile" (
    "id" bigserial PRIMARY KEY,
    "userId" uuid NOT NULL,
    "email" text,
    "displayName" text,
    "bio" text,
    "avatarIndex" bigint,
    "avatarEmoji" text,
    "status" text,
    "themeMode" text,
    "notificationsEnabled" boolean,
    "locale" text,
    "updatedAt" timestamp without time zone NOT NULL
);
ALTER TABLE "user_account_profile" ALTER COLUMN "id" TYPE bigint;
ALTER TABLE "user_account_profile" ALTER COLUMN "avatarIndex" TYPE bigint;
CREATE UNIQUE INDEX IF NOT EXISTS "user_account_profile_user_idx" ON "user_account_profile" USING btree ("userId");

--
-- Serverpod Core Tables Updates
--
ALTER TABLE IF EXISTS "serverpod_cloud_storage" ADD COLUMN IF NOT EXISTS "contentType" text;
ALTER TABLE IF EXISTS "serverpod_cloud_storage" ADD COLUMN IF NOT EXISTS "cacheControl" text;
ALTER TABLE IF EXISTS "serverpod_cloud_storage" ADD COLUMN IF NOT EXISTS "contentDisposition" text;
ALTER TABLE IF EXISTS "serverpod_cloud_storage" ADD COLUMN IF NOT EXISTS "contentEncoding" text;
ALTER TABLE IF EXISTS "serverpod_cloud_storage" ADD COLUMN IF NOT EXISTS "customMetadata" text;

CREATE TABLE IF NOT EXISTS "serverpod_cloud_storage_direct_download" (
    "id" bigserial PRIMARY KEY,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "expiration" timestamp without time zone NOT NULL,
    "authKey" text NOT NULL,
    "downloadFileName" text,
    "contentType" text
);
CREATE UNIQUE INDEX IF NOT EXISTS "serverpod_cloud_storage_direct_download_auth_key" ON "serverpod_cloud_storage_direct_download" USING btree ("authKey");
CREATE INDEX IF NOT EXISTS "serverpod_cloud_storage_direct_download_expiration" ON "serverpod_cloud_storage_direct_download" USING btree ("expiration");

ALTER TABLE IF EXISTS "serverpod_cloud_storage_direct_upload" ADD COLUMN IF NOT EXISTS "maxFileSize" bigint NOT NULL DEFAULT 10485760;
ALTER TABLE IF EXISTS "serverpod_cloud_storage_direct_upload" ADD COLUMN IF NOT EXISTS "contentLength" bigint;
ALTER TABLE IF EXISTS "serverpod_cloud_storage_direct_upload" ADD COLUMN IF NOT EXISTS "preventOverwrite" boolean NOT NULL DEFAULT false;
ALTER TABLE IF EXISTS "serverpod_cloud_storage_direct_upload" ADD COLUMN IF NOT EXISTS "contentType" text;
ALTER TABLE IF EXISTS "serverpod_cloud_storage_direct_upload" ADD COLUMN IF NOT EXISTS "cacheControl" text;
ALTER TABLE IF EXISTS "serverpod_cloud_storage_direct_upload" ADD COLUMN IF NOT EXISTS "contentDisposition" text;
ALTER TABLE IF EXISTS "serverpod_cloud_storage_direct_upload" ADD COLUMN IF NOT EXISTS "contentEncoding" text;
ALTER TABLE IF EXISTS "serverpod_cloud_storage_direct_upload" ADD COLUMN IF NOT EXISTS "customMetadata" text;

--
-- Recreate Foreign Key Constraints
--
ALTER TABLE ONLY "todo_activity"
    DROP CONSTRAINT IF EXISTS "todo_activity_fk_0",
    ADD CONSTRAINT "todo_activity_fk_0"
    FOREIGN KEY("todoListId")
    REFERENCES "todo_list"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

ALTER TABLE ONLY "todo_chat_message"
    DROP CONSTRAINT IF EXISTS "todo_chat_message_fk_0",
    ADD CONSTRAINT "todo_chat_message_fk_0"
    FOREIGN KEY("todoListId")
    REFERENCES "todo_list"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

ALTER TABLE ONLY "todo_item"
    DROP CONSTRAINT IF EXISTS "todo_item_fk_0",
    ADD CONSTRAINT "todo_item_fk_0"
    FOREIGN KEY("todoListId")
    REFERENCES "todo_list"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

ALTER TABLE ONLY "todo_list_member"
    DROP CONSTRAINT IF EXISTS "todo_list_member_fk_0",
    ADD CONSTRAINT "todo_list_member_fk_0"
    FOREIGN KEY("todoListId")
    REFERENCES "todo_list"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- MIGRATION VERSIONS
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('todolist', '20260911071343684', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260911071343684', "timestamp" = now();

INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260824182259319', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182259319', "timestamp" = now();

INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260824182405944', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182405944', "timestamp" = now();

INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260824182354731', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182354731', "timestamp" = now();

COMMIT;
