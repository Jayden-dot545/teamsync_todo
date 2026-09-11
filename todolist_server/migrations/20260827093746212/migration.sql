BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "todo_item" (
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
    "sortOrder" double precision NOT NULL
);

-- Indexes
CREATE INDEX "todo_item_list_idx" ON "todo_item" USING btree ("todoListId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "todo_list" (
    "id" bigserial PRIMARY KEY,
    "title" text NOT NULL,
    "description" text,
    "color" bigint NOT NULL,
    "ownerId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "todo_list_member" (
    "id" bigserial PRIMARY KEY,
    "todoListId" bigint NOT NULL,
    "userId" uuid NOT NULL,
    "userEmail" text,
    "userName" text,
    "role" text NOT NULL,
    "joinedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "todo_list_member_unique_idx" ON "todo_list_member" USING btree ("todoListId", "userId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "todo_item"
    ADD CONSTRAINT "todo_item_fk_0"
    FOREIGN KEY("todoListId")
    REFERENCES "todo_list"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "todo_list_member"
    ADD CONSTRAINT "todo_list_member_fk_0"
    FOREIGN KEY("todoListId")
    REFERENCES "todo_list"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR todolist
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('todolist', '20260827093746212', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260827093746212', "timestamp" = now();

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
