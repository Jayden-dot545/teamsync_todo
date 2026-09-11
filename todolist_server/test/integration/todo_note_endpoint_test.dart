import 'package:test/test.dart';
import 'package:todolist_server/src/generated/protocol.dart';
import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given TodoNote endpoint', (
    sessionBuilder,
    endpoints,
  ) {
    const user1Uuid = '11111111-1111-4111-8111-111111111111';
    const user2Uuid = '22222222-2222-4222-8222-222222222222';

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

    final unauthed = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.unauthenticated(),
    );

    group('when unauthenticated', () {
      test('then getNotes throws unauthenticated exception', () async {
        await expectLater(
          endpoints.todoNote.getNotes(unauthed, listId: 1),
          throwsA(isA<ServerpodUnauthenticatedException>()),
        );
      });
    });

    group('when managing notes in a list', () {
      test('then user can create, read, update, pin, and delete notes persistently', () async {
        // 1. Create a list
        final list = await endpoints.todoList.createList(
          authedUser1,
          title: 'Notes Test List',
          color: 0xFF6366F1,
        );

        // 2. Create note
        final note = await endpoints.todoNote.createNote(
          authedUser1,
          listId: list.id!,
          title: 'Architecture Overview',
          content: 'PostgreSQL 16 + Serverpod 4.x + Flutter',
          color: 0xFF38BDF8,
          isPinned: true,
        );

        expect(note.id, isNotNull);
        expect(note.title, equals('Architecture Overview'));
        expect(note.content, equals('PostgreSQL 16 + Serverpod 4.x + Flutter'));
        expect(note.isPinned, isTrue);
        expect(note.color, equals(0xFF38BDF8));

        // 3. Read notes
        final notes = await endpoints.todoNote.getNotes(
          authedUser1,
          listId: list.id!,
        );
        expect(notes, hasLength(1));
        expect(notes.first.id, equals(note.id));
        expect(notes.first.title, equals('Architecture Overview'));

        // 4. Update note
        final updated = await endpoints.todoNote.updateNote(
          authedUser1,
          noteId: note.id!,
          title: 'Architecture Overview v2',
          content: 'Updated content with real-time sync',
          color: 0xFF10B981,
        );
        expect(updated.title, equals('Architecture Overview v2'));
        expect(updated.color, equals(0xFF10B981));

        // 5. Toggle pin
        final unpinned = await endpoints.todoNote.togglePin(
          authedUser1,
          noteId: note.id!,
        );
        expect(unpinned.isPinned, isFalse);

        final repinned = await endpoints.todoNote.togglePin(
          authedUser1,
          noteId: note.id!,
        );
        expect(repinned.isPinned, isTrue);

        // 6. Delete note
        final deleted = await endpoints.todoNote.deleteNote(
          authedUser1,
          noteId: note.id!,
        );
        expect(deleted, isTrue);

        // 7. Verify deletion from database
        final remainingNotes = await endpoints.todoNote.getNotes(
          authedUser1,
          listId: list.id!,
        );
        expect(remainingNotes, isEmpty);
      });

      test('then non-member cannot access notes', () async {
        final list = await endpoints.todoList.createList(
          authedUser1,
          title: 'Private List',
          color: 0xFF0284C7,
        );

        await expectLater(
          endpoints.todoNote.getNotes(authedUser2, listId: list.id!),
          throwsA(isA<TodoListException>()),
        );

        await expectLater(
          endpoints.todoNote.createNote(
            authedUser2,
            listId: list.id!,
            title: 'Hack note',
            content: 'Should fail',
            isPinned: false,
          ),
          throwsA(isA<TodoListException>()),
        );
      });
    });
  });
}
