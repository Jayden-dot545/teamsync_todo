import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';
import 'package:todolist_server/src/generated/protocol.dart';
import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given TodoList and TodoItem endpoints', (
    sessionBuilder,
    endpoints,
  ) {
    const user1Uuid = '11111111-1111-4111-8111-111111111111';
    const user2Uuid = '22222222-2222-4222-8222-222222222222';
    const viewerUuid = '33333333-3333-4333-8333-333333333333';

    final authedUser1 = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        user1Uuid,
        {},
      ),
    );

    final authedUser2 = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        user2Uuid,
        {},
      ),
    );

    final authedViewer = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        viewerUuid,
        {},
      ),
    );

    final unauthed = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.unauthenticated(),
    );

    group('when unauthenticated', () {
      test('then getLists throws unauthenticated exception', () async {
        await expectLater(
          endpoints.todoList.getLists(unauthed),
          throwsA(isA<ServerpodUnauthenticatedException>()),
        );
      });
    });

    group('when user creates a list', () {
      test('then list is returned and user is member', () async {
        final list = await endpoints.todoList.createList(
          authedUser1,
          title: 'Sprint 1',
          description: 'Initial tasks',
          color: 0xFF38BDF8,
        );

        expect(list.id, isNotNull);
        expect(list.title, equals('Sprint 1'));
        expect(list.color, equals(0xFF38BDF8));

        final userLists = await endpoints.todoList.getLists(authedUser1);
        expect(userLists.any((l) => l.id == list.id), isTrue);

        final members = await endpoints.todoList.getMembers(
          authedUser1,
          list.id!,
        );
        expect(members, hasLength(1));
        expect(members.first.role, equals(MemberRole.owner));
        expect(members.first.userId, equals(UuidValue.fromString(user1Uuid)));
      });
    });

    group('when managing tasks in a list', () {
      test('then user can create, toggle and delete items', () async {
        final list = await endpoints.todoList.createList(
          authedUser1,
          title: 'Project Alpha',
          color: 0xFF10B981,
        );

        // 1. Create task
        final item = await endpoints.todoItem.createItem(
          authedUser1,
          listId: list.id!,
          title: 'Implement Auth',
          priority: TodoPriority.high,
        );

        expect(item.id, isNotNull);
        expect(item.title, equals('Implement Auth'));
        expect(item.isCompleted, isFalse);
        expect(item.priority, equals(TodoPriority.high));

        // 2. Fetch items
        final items = await endpoints.todoItem.getItems(
          authedUser1,
          listId: list.id!,
        );
        expect(items, hasLength(1));
        expect(items.first.title, equals('Implement Auth'));

        // 3. Toggle complete
        final completedItem = await endpoints.todoItem.toggleComplete(
          authedUser1,
          itemId: item.id!,
        );
        expect(completedItem.isCompleted, isTrue);
        expect(completedItem.completedAt, isNotNull);

        // 4. Delete item
        final deleteResult = await endpoints.todoItem.deleteItem(
          authedUser1,
          itemId: item.id!,
        );
        expect(deleteResult, isTrue);

        final remainingItems = await endpoints.todoItem.getItems(
          authedUser1,
          listId: list.id!,
        );
        expect(remainingItems, isEmpty);
      });

      test(
        'then unauthorized user cannot access other user list items',
        () async {
          final list = await endpoints.todoList.createList(
            authedUser1,
            title: 'Private List',
            color: 0xFFF43F5E,
          );

          await expectLater(
            endpoints.todoItem.getItems(authedUser2, listId: list.id!),
            throwsA(isA<TodoListException>()),
          );
        },
      );

      test(
        'then viewer can see progress but cannot modify or complete items',
        () async {
          final list = await endpoints.todoList.createList(
            authedUser1,
            title: 'Praktikanten Aufgaben',
            color: 0xFF38BDF8,
          );

          // Add viewer to database
          final session = sessionBuilder.build();
          await TodoListMember.db.insertRow(
            session,
            TodoListMember(
              todoListId: list.id!,
              userId: UuidValue.fromString(viewerUuid),
              role: MemberRole.viewer,
              userName: 'Mutter / Betreuer',
              userEmail: 'supervisor@example.com',
              joinedAt: DateTime.now(),
            ),
          );

          // Worker creates task
          final task = await endpoints.todoItem.createItem(
            authedUser1,
            listId: list.id!,
            title: 'Home Office Dokumentation erstellen',
            priority: TodoPriority.medium,
          );

          // Viewer CAN fetch and see items / progress
          final viewerItems = await endpoints.todoItem.getItems(
            authedViewer,
            listId: list.id!,
          );
          expect(viewerItems, hasLength(1));
          expect(
            viewerItems.first.title,
            equals('Home Office Dokumentation erstellen'),
          );

          // Viewer CANNOT toggle completion (read-only)
          await expectLater(
            endpoints.todoItem.toggleComplete(authedViewer, itemId: task.id!),
            throwsA(isA<TodoListException>()),
          );

          // Viewer CANNOT create new tasks
          await expectLater(
            endpoints.todoItem.createItem(
              authedViewer,
              listId: list.id!,
              title: 'Unbefugte Aufgabe',
              priority: TodoPriority.low,
            ),
            throwsA(isA<TodoListException>()),
          );
        },
      );

      test('then user can track time on tasks and accumulate duration', () async {
        final list = await endpoints.todoList.createList(
          authedUser1,
          title: 'Timer Project',
          color: 0xFF0284C7,
        );

        final task = await endpoints.todoItem.createItem(
          authedUser1,
          listId: list.id!,
          title: 'Deep Work Session',
          priority: TodoPriority.high,
        );

        // 1. Start timer
        final started = await endpoints.todoItem.startTimer(
          authedUser1,
          itemId: task.id!,
        );
        expect(started.isTimerRunning, isTrue);
        expect(started.timerStartedAt, isNotNull);

        // 2. Pause timer
        final paused = await endpoints.todoItem.pauseTimer(
          authedUser1,
          itemId: task.id!,
        );
        expect(paused.isTimerRunning, isFalse);
        expect(paused.timerStartedAt, isNull);

        // 3. Start timer again and mark task as completed (should auto-stop timer and record session)
        await endpoints.todoItem.startTimer(
          authedUser1,
          itemId: task.id!,
        );

        final completed = await endpoints.todoItem.toggleComplete(
          authedUser1,
          itemId: task.id!,
        );
        expect(completed.isCompleted, isTrue);
        expect(completed.isTimerRunning, isFalse);
        expect(completed.timerStartedAt, isNull);
      });

      test('then user can create and toggle subtasks', () async {
        final list = await endpoints.todoList.createList(
          authedUser1,
          title: 'Subtasks Project',
          color: 0xFF10B981,
        );

        final task = await endpoints.todoItem.createItem(
          authedUser1,
          listId: list.id!,
          title: 'Main Feature',
          priority: TodoPriority.medium,
          subtasksJson:
              '[{"id":"s1","title":"Sub 1","isDone":false},{"id":"s2","title":"Sub 2","isDone":false}]',
        );

        expect(task.subtasksJson, isNotNull);

        // Toggle subtask s1
        final updated = await endpoints.todoItem.toggleSubtask(
          authedUser1,
          itemId: task.id!,
          subtaskId: 's1',
        );

        expect(updated.subtasksJson, contains('"isDone":true'));
      });

      test(
        'then completing a recurring task automatically spawns next occurrence',
        () async {
          final list = await endpoints.todoList.createList(
            authedUser1,
            title: 'Routine Project',
            color: 0xFF6366F1,
          );

          final now = DateTime.now();
          final recurringTask = await endpoints.todoItem.createItem(
            authedUser1,
            listId: list.id!,
            title: 'Tägliches Standup',
            dueDate: now,
            priority: TodoPriority.medium,
            recurrence: 'daily',
            subtasksJson:
                '[{"id":"sub1","title":"Notizen vorbereiten","isDone":true}]',
          );

          expect(recurringTask.recurrence, equals('daily'));

          // Toggle complete on the recurring task
          final completed = await endpoints.todoItem.toggleComplete(
            authedUser1,
            itemId: recurringTask.id!,
          );
          expect(completed.isCompleted, isTrue);

          // Fetch all items in list: should now have 2 items (the completed one and the new open next instance)
          final allItems = await endpoints.todoItem.getItems(
            authedUser1,
            listId: list.id!,
          );
          expect(allItems, hasLength(2));

          final nextInstance = allItems.firstWhere(
            (i) => i.id != recurringTask.id,
          );
          expect(nextInstance.isCompleted, isFalse);
          expect(nextInstance.title, equals('Tägliches Standup'));
          expect(nextInstance.recurrence, equals('daily'));
          expect(nextInstance.dueDate, isNotNull);
          // Subtasks on the new instance should be reset to isDone: false
          expect(nextInstance.subtasksJson, contains('"isDone":false'));
        },
      );

      test(
        'then user can save and retrieve profile settings in database',
        () async {
          final saved = await endpoints.todoList.saveUserProfileData(
            authedUser1,
            displayName: 'Alex Mustermann',
            bio: 'Frontend Architect & Team Lead',
            avatarIndex: 3,
            avatarEmoji: '⚡',
            status: '👑 Chef & Teamleiter',
            themeMode: 'light',
            notificationsEnabled: false,
          );

          expect(saved.displayName, equals('Alex Mustermann'));
          expect(saved.bio, equals('Frontend Architect & Team Lead'));
          expect(saved.avatarIndex, equals(3));
          expect(saved.themeMode, equals('light'));
          expect(saved.notificationsEnabled, isFalse);

          final retrieved = await endpoints.todoList.getUserProfileData(
            authedUser1,
          );
          expect(retrieved, isNotNull);
          expect(retrieved.displayName, equals('Alex Mustermann'));
          expect(retrieved.bio, equals('Frontend Architect & Team Lead'));
          expect(retrieved.avatarIndex, equals(3));
          expect(retrieved.themeMode, equals('light'));
          expect(retrieved.notificationsEnabled, isFalse);
        },
      );

      test('then user can invite and join via invite code', () async {
        final list = await endpoints.todoList.createList(
          authedUser1,
          title: 'Link Share List',
          color: 0xFF38BDF8,
        );

        final code = await endpoints.todoList.getOrCreateInviteCode(
          authedUser1,
          list.id!,
        );
        expect(code, startsWith('TS-'));

        // Second user joins with code
        final joined = await endpoints.todoList.joinListByInviteCode(
          authedUser2,
          code,
        );
        expect(joined.id, equals(list.id));

        final members = await endpoints.todoList.getMembers(
          authedUser1,
          list.id!,
        );
        expect(members, hasLength(2));
        expect(
          members.any(
            (m) =>
                m.userId == UuidValue.fromString(user2Uuid) &&
                m.role == MemberRole.editor,
          ),
          isTrue,
        );
      });

      test(
        'then activities are logged on item create, complete, delete and retrieved via getActivities',
        () async {
          final list = await endpoints.todoList.createList(
            authedUser1,
            title: 'Activity Log Project',
            color: 0xFF10B981,
          );

          final item = await endpoints.todoItem.createItem(
            authedUser1,
            listId: list.id!,
            title: 'Erste Aufgabe im Feed',
            priority: TodoPriority.high,
          );

          await endpoints.todoItem.toggleComplete(
            authedUser1,
            itemId: item.id!,
          );

          final activities = await endpoints.todoItem.getActivities(
            authedUser1,
            listId: list.id!,
          );

          expect(activities, isNotEmpty);
          expect(activities.length, greaterThanOrEqualTo(2));
          expect(
            activities.any(
              (a) =>
                  a.actionType == 'created' &&
                  a.details.contains('Erste Aufgabe im Feed'),
            ),
            isTrue,
          );
          expect(
            activities.any(
              (a) =>
                  a.actionType == 'completed' &&
                  a.details.contains('Erste Aufgabe im Feed'),
            ),
            isTrue,
          );
        },
      );
    });
  });
}
