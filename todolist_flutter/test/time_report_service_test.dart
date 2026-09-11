import 'package:flutter_test/flutter_test.dart';
import 'package:todolist_client/todolist_client.dart';
import 'package:todolist_flutter/todos/models/work_session.dart';
import 'package:todolist_flutter/todos/services/time_report_service.dart';

void main() {
  group('TimeReportService Tests', () {
    test('aggregates work sessions and calculates totals correctly', () {
      final session1 = WorkSession(
        id: '1',
        startTime: DateTime.now().subtract(const Duration(hours: 3)),
        endTime: DateTime.now().subtract(const Duration(hours: 2)),
        durationSeconds: 3600, // 1h
        userName: 'Max',
      );

      final session2 = WorkSession(
        id: '2',
        startTime: DateTime.now().subtract(const Duration(hours: 1)),
        endTime: DateTime.now().subtract(const Duration(minutes: 15)),
        durationSeconds: 2700, // 45m
        userName: 'Max',
      );

      final item = TodoItem(
        id: 1,
        todoListId: 1,
        title: 'Backend API Refactoring',
        isCompleted: false,
        priority: TodoPriority.high,
        createdById: UuidValue.fromString(
          '00000000-0000-0000-0000-000000000001',
        ),
        createdAt: DateTime.now(),
        sortOrder: 100.0,
        workSessionsJson: WorkSession.encodeList([session1, session2]),
      );

      final summary = TimeReportService.generateSummary(
        items: [item],
        period: TimeReportPeriod.allTime,
      );

      expect(summary.totalSessions, 2);
      expect(summary.totalWorkSeconds, 6300); // 3600 + 2700
      expect(
        summary.totalPauseSeconds,
        3600,
      ); // 1 hour pause between sessions (from -2h to -1h)

      // Test CSV export
      final csv = TimeReportService.generateCsv(
        listTitle: 'Sprint Q3',
        summary: summary,
      );
      expect(
        csv,
        contains(
          'Datum;Aufgabe;Bearbeiter;Start;Ende;Arbeitszeit;Arbeitszeit (Sekunden);Pause davor',
        ),
      );
      expect(csv, contains('Backend API Refactoring'));
      expect(csv, contains('Max'));
      expect(csv, contains('GESAMT'));

      // Test text report
      final report = TimeReportService.generateTextReport(
        listTitle: 'Sprint Q3',
        summary: summary,
        periodLabel: 'Heute',
      );
      expect(report, contains('STUNDENZETTEL & ZEITAUSWERTUNG'));
      expect(report, contains('Sprint Q3'));
      expect(report, contains('Backend API Refactoring'));

      // Test single task CSV export
      final taskCsv = TimeReportService.generateTaskCsv(item: item);
      expect(
        taskCsv,
        contains(
          'Datum;Aufgabe;Bearbeiter;Start;Ende;Arbeitszeit;Arbeitszeit (Sekunden);Pause davor',
        ),
      );
      expect(taskCsv, contains('Backend API Refactoring'));
      expect(taskCsv, contains('GESAMT;Aufgabe: Backend API Refactoring'));
    });
  });
}
