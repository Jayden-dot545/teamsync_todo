import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Kanban View Column Categorization Tests', () {
    test(
      'categorizes tasks correctly into Open, InProgress, and Completed',
      () {
        final tasks = [
          {'id': 1, 'isCompleted': false, 'isTimerRunning': false},
          {'id': 2, 'isCompleted': false, 'isTimerRunning': true},
          {'id': 3, 'isCompleted': true, 'isTimerRunning': false},
          {'id': 4, 'isCompleted': false, 'isTimerRunning': false},
        ];

        final open = tasks
            .where(
              (t) => t['isCompleted'] == false && t['isTimerRunning'] != true,
            )
            .toList();
        final inProgress = tasks
            .where((t) => t['isTimerRunning'] == true)
            .toList();
        final completed = tasks.where((t) => t['isCompleted'] == true).toList();

        expect(open, hasLength(2));
        expect(inProgress, hasLength(1));
        expect(completed, hasLength(1));
        expect(open.map((t) => t['id']), containsAll([1, 4]));
        expect(inProgress.first['id'], equals(2));
        expect(completed.first['id'], equals(3));
      },
    );
  });
}
