import 'package:flutter_test/flutter_test.dart';
import 'package:todolist_flutter/todos/models/work_session.dart';

void main() {
  group('WorkSession Model Tests', () {
    test('encode and decode empty list', () {
      final list = WorkSession.decodeList(null);
      expect(list, isEmpty);

      final emptyList = WorkSession.decodeList('');
      expect(emptyList, isEmpty);
    });

    test('format duration formats seconds, minutes and hours', () {
      expect(WorkSession.formatDuration(0), '0 Sek.');
      expect(WorkSession.formatDuration(45), '45 Sek.');
      expect(WorkSession.formatDuration(120), '2 Min.');
      expect(WorkSession.formatDuration(125), '2 Min. 05 Sek.');
      expect(WorkSession.formatDuration(3600), '1 Std.');
      expect(WorkSession.formatDuration(3665), '1 Std. 01 Min.');
      expect(WorkSession.formatDuration(7320), '2 Std. 02 Min.');
    });

    test('encode and decode multiple work sessions with pauses', () {
      final session1 = WorkSession(
        id: '1',
        startTime: DateTime(2026, 9, 1, 5, 10),
        endTime: DateTime(2026, 9, 1, 6, 27),
        durationSeconds: 4620, // 1h 17m
        userName: 'Max',
      );

      final session2 = WorkSession(
        id: '2',
        startTime: DateTime(2026, 9, 1, 7, 10),
        endTime: DateTime(2026, 9, 1, 9, 44),
        durationSeconds: 9240, // 2h 34m
        userName: 'Max',
      );

      final encoded = WorkSession.encodeList([session1, session2]);
      expect(encoded, isNotEmpty);

      final decoded = WorkSession.decodeList(encoded);
      expect(decoded.length, 2);
      expect(decoded[0].startFormatted, '05:10');
      expect(decoded[0].endFormatted, '06:27');
      expect(decoded[0].formattedDuration, '1 Std. 17 Min.');

      expect(decoded[1].startFormatted, '07:10');
      expect(decoded[1].endFormatted, '09:44');
      expect(decoded[1].formattedDuration, '2 Std. 34 Min.');

      // Pause calculation between session 1 and session 2: 06:27 to 07:10 (43 minutes = 2580 seconds)
      final pauseSec = WorkSession.calculatePauseSeconds(
        decoded[0],
        decoded[1],
      );
      expect(pauseSec, 2580);
      expect(WorkSession.formatPause(pauseSec!), '43 Min. Pause');
    });
  });
}
