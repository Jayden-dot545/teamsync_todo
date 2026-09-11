import 'package:flutter_test/flutter_test.dart';
import 'package:todolist_flutter/todos/todo_controller.dart';

void main() {
  group('Task Work Time Tracking Unit Tests', () {
    test('formatDuration formats 0 and negative seconds correctly', () {
      expect(TodoController.formatDuration(0), '0 Min.');
      expect(TodoController.formatDuration(-10), '0 Min.');
    });

    test('formatDuration formats seconds less than a minute', () {
      expect(TodoController.formatDuration(45), '45s');
      expect(TodoController.formatDuration(1), '1s');
    });

    test('formatDuration formats minutes without hours', () {
      expect(TodoController.formatDuration(60), '1 Min.');
      expect(TodoController.formatDuration(150), '2 Min.');
      expect(TodoController.formatDuration(3599), '59 Min.');
    });

    test('formatDuration formats hours and minutes', () {
      expect(TodoController.formatDuration(3600), '1 Std.');
      expect(TodoController.formatDuration(3660), '1 Std. 1 Min.');
      expect(TodoController.formatDuration(5400), '1 Std. 30 Min.');
      expect(TodoController.formatDuration(7200), '2 Std.');
    });

    test('formatDigitalTime formats MM:SS and HH:MM:SS', () {
      expect(TodoController.formatDigitalTime(0), '00:00');
      expect(TodoController.formatDigitalTime(65), '01:05');
      expect(TodoController.formatDigitalTime(3600), '01:00:00');
      expect(TodoController.formatDigitalTime(3665), '01:01:05');
    });
  });
}
