import 'package:todolist_client/todolist_client.dart';
import '../models/work_session.dart';

enum TimeReportPeriod {
  today,
  thisWeek,
  thisMonth,
  allTime,
}

class FlatWorkSessionEntry {
  final TodoItem item;
  final WorkSession session;
  final int? pauseBeforeSeconds;

  const FlatWorkSessionEntry({
    required this.item,
    required this.session,
    this.pauseBeforeSeconds,
  });
}

class DailyWorkStat {
  final DateTime date;
  final int workSeconds;
  final int pauseSeconds;
  final int sessionCount;

  const DailyWorkStat({
    required this.date,
    required this.workSeconds,
    required this.pauseSeconds,
    required this.sessionCount,
  });
}

class TimeReportSummary {
  final List<FlatWorkSessionEntry> entries;
  final int totalWorkSeconds;
  final int totalPauseSeconds;
  final int totalSessions;
  final Map<DateTime, DailyWorkStat> dailyStats;

  const TimeReportSummary({
    required this.entries,
    required this.totalWorkSeconds,
    required this.totalPauseSeconds,
    required this.totalSessions,
    required this.dailyStats,
  });
}

class TimeReportService {
  /// Aggregates all work sessions from the given tasks, applying period and member filters.
  static TimeReportSummary generateSummary({
    required List<TodoItem> items,
    TimeReportPeriod period = TimeReportPeriod.thisWeek,
    String? filterUserId,
  }) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    DateTime? startDate;
    DateTime? endDate = now;

    switch (period) {
      case TimeReportPeriod.today:
        startDate = today;
        break;
      case TimeReportPeriod.thisWeek:
        // Start from Monday of the current week
        final weekday = now.weekday; // 1 = Monday, 7 = Sunday
        startDate = today.subtract(Duration(days: weekday - 1));
        break;
      case TimeReportPeriod.thisMonth:
        startDate = DateTime(now.year, now.month, 1);
        break;
      case TimeReportPeriod.allTime:
        startDate = null;
        endDate = null;
        break;
    }

    final allFlatEntries = <FlatWorkSessionEntry>[];

    for (final item in items) {
      final sessions = WorkSession.decodeList(item.workSessionsJson);

      // Also include active running session if any
      final activeList = List<WorkSession>.from(sessions);
      if (item.isTimerRunning == true && item.timerStartedAt != null) {
        final elapsed = now.difference(item.timerStartedAt!).inSeconds;
        activeList.add(
          WorkSession(
            id: 'running_${item.id}',
            startTime: item.timerStartedAt!,
            endTime: null,
            durationSeconds: elapsed > 0 ? elapsed : 0,
            userName: item.timerUserName,
            userId: item.timerUserId?.toString(),
          ),
        );
      }

      // Sort sessions chronologically
      activeList.sort((a, b) => a.startTime.compareTo(b.startTime));

      for (var i = 0; i < activeList.length; i++) {
        final session = activeList[i];

        // Member filter
        if (filterUserId != null &&
            filterUserId.isNotEmpty &&
            session.userId != filterUserId) {
          continue;
        }

        // Date range filter
        if (startDate != null && session.startTime.isBefore(startDate)) {
          continue;
        }
        if (endDate != null && session.startTime.isAfter(endDate)) {
          continue;
        }

        int? pauseBefore;
        if (i > 0) {
          final prev = activeList[i - 1];
          pauseBefore = WorkSession.calculatePauseSeconds(prev, session);
        }

        allFlatEntries.add(
          FlatWorkSessionEntry(
            item: item,
            session: session,
            pauseBeforeSeconds: pauseBefore,
          ),
        );
      }
    }

    // Sort all aggregated entries chronologically (newest first for reporting)
    allFlatEntries.sort(
      (a, b) => b.session.startTime.compareTo(a.session.startTime),
    );

    var totalWorkSec = 0;
    var totalPauseSec = 0;
    final dailyMap = <DateTime, DailyWorkStat>{};

    for (final entry in allFlatEntries) {
      totalWorkSec += entry.session.durationSeconds;
      if (entry.pauseBeforeSeconds != null && entry.pauseBeforeSeconds! > 0) {
        totalPauseSec += entry.pauseBeforeSeconds!;
      }

      final dateKey = DateTime(
        entry.session.startTime.year,
        entry.session.startTime.month,
        entry.session.startTime.day,
      );

      final existing = dailyMap[dateKey];
      if (existing == null) {
        dailyMap[dateKey] = DailyWorkStat(
          date: dateKey,
          workSeconds: entry.session.durationSeconds,
          pauseSeconds: entry.pauseBeforeSeconds ?? 0,
          sessionCount: 1,
        );
      } else {
        dailyMap[dateKey] = DailyWorkStat(
          date: dateKey,
          workSeconds: existing.workSeconds + entry.session.durationSeconds,
          pauseSeconds: existing.pauseSeconds + (entry.pauseBeforeSeconds ?? 0),
          sessionCount: existing.sessionCount + 1,
        );
      }
    }

    return TimeReportSummary(
      entries: allFlatEntries,
      totalWorkSeconds: totalWorkSec,
      totalPauseSeconds: totalPauseSec,
      totalSessions: allFlatEntries.length,
      dailyStats: dailyMap,
    );
  }

  /// Exports the summary to standard CSV format (compatible with Excel, Numbers, Sheets).
  static String generateCsv({
    required String listTitle,
    required TimeReportSummary summary,
  }) {
    final buffer = StringBuffer();
    // CSV Header with BOM for correct Excel UTF-8 display
    buffer.writeln(
      'Datum;Aufgabe;Bearbeiter;Start;Ende;Arbeitszeit;Arbeitszeit (Sekunden);Pause davor',
    );

    for (final entry in summary.entries) {
      final dateStr = entry.session.dateFormatted;
      final taskTitle = _escapeCsv(entry.item.title);
      final user = _escapeCsv(entry.session.userName ?? 'Unbekannt');
      final start = entry.session.startFormatted;
      final end = entry.session.endFormatted;
      final duration = entry.session.formattedDuration;
      final seconds = entry.session.durationSeconds;
      final pauseStr =
          entry.pauseBeforeSeconds != null && entry.pauseBeforeSeconds! > 0
          ? WorkSession.formatPause(entry.pauseBeforeSeconds!)
          : '-';

      buffer.writeln(
        '$dateStr;$taskTitle;$user;$start;$end;$duration;$seconds;$pauseStr',
      );
    }

    // Summary Footer
    final totalWork = WorkSession.formatDuration(summary.totalWorkSeconds);
    final totalPause = WorkSession.formatDuration(summary.totalPauseSeconds);
    buffer.writeln(';;;;;;;');
    buffer.writeln(
      'GESAMT;Projekt: ${_escapeCsv(listTitle)};;Phasen: ${summary.totalSessions};;Gesamtarbeitszeit: $totalWork;${summary.totalWorkSeconds};Gesamtpausen: $totalPause',
    );

    return buffer.toString();
  }

  /// Exports the work sessions for a single task to standard CSV format.
  static String generateTaskCsv({required TodoItem item}) {
    final buffer = StringBuffer();
    buffer.writeln(
      'Datum;Aufgabe;Bearbeiter;Start;Ende;Arbeitszeit;Arbeitszeit (Sekunden);Pause davor',
    );

    final sessions = WorkSession.decodeList(item.workSessionsJson);
    final activeList = List<WorkSession>.from(sessions);

    if (item.isTimerRunning == true && item.timerStartedAt != null) {
      final elapsed = DateTime.now().difference(item.timerStartedAt!).inSeconds;
      activeList.add(
        WorkSession(
          id: 'running_${item.id}',
          startTime: item.timerStartedAt!,
          endTime: null,
          durationSeconds: elapsed > 0 ? elapsed : 0,
          userName: item.timerUserName,
          userId: item.timerUserId?.toString(),
        ),
      );
    }

    activeList.sort((a, b) => a.startTime.compareTo(b.startTime));

    var totalSeconds = 0;
    var totalPauseSeconds = 0;

    for (var i = 0; i < activeList.length; i++) {
      final session = activeList[i];
      totalSeconds += session.durationSeconds;
      int? pauseBefore;
      if (i > 0) {
        final prev = activeList[i - 1];
        pauseBefore = WorkSession.calculatePauseSeconds(prev, session);
        if (pauseBefore != null && pauseBefore > 0) {
          totalPauseSeconds += pauseBefore;
        }
      }

      final dateStr = session.dateFormatted;
      final taskTitle = _escapeCsv(item.title);
      final user = _escapeCsv(
        session.userName ?? item.assignedToName ?? 'Unbekannt',
      );
      final start = session.startFormatted;
      final end = session.endFormatted;
      final duration = session.formattedDuration;
      final seconds = session.durationSeconds;
      final pauseStr = pauseBefore != null && pauseBefore > 0
          ? WorkSession.formatPause(pauseBefore)
          : '-';

      buffer.writeln(
        '$dateStr;$taskTitle;$user;$start;$end;$duration;$seconds;$pauseStr',
      );
    }

    final totalWork = WorkSession.formatDuration(totalSeconds);
    final totalPause = WorkSession.formatDuration(totalPauseSeconds);
    buffer.writeln(';;;;;;;');
    buffer.writeln(
      'GESAMT;Aufgabe: ${_escapeCsv(item.title)};;Phasen: ${activeList.length};;Gesamtarbeitszeit: $totalWork;$totalSeconds;Gesamtpausen: $totalPause',
    );

    return buffer.toString();
  }

  /// Generates a clean human-readable timesheet summary for sharing or printing.
  static String generateTextReport({
    required String listTitle,
    required TimeReportSummary summary,
    required String periodLabel,
  }) {
    final buffer = StringBuffer();
    buffer.writeln('════════════════════════════════════════════════════════');
    buffer.writeln('📋 STUNDENZETTEL & ZEITAUSWERTUNG');
    buffer.writeln('Projekt: $listTitle');
    buffer.writeln('Zeitraum: $periodLabel');
    buffer.writeln(
      'Erstellt am: ${DateTime.now().toLocal().toString().substring(0, 16)}',
    );
    buffer.writeln(
      '════════════════════════════════════════════════════════\n',
    );

    buffer.writeln('📊 ÜBERSICHT:');
    buffer.writeln(
      '  • Gesamtarbeitszeit: ${WorkSession.formatDuration(summary.totalWorkSeconds)}',
    );
    buffer.writeln(
      '  • Gesamtpausen:     ${WorkSession.formatDuration(summary.totalPauseSeconds)}',
    );
    buffer.writeln('  • Arbeitsphasen:    ${summary.totalSessions}');
    buffer.writeln('  • Aktive Tage:      ${summary.dailyStats.length}\n');

    buffer.writeln('────────────────────────────────────────────────────────');
    buffer.writeln('EINZELPHASEN & INTERVALLE:');
    buffer.writeln('────────────────────────────────────────────────────────');

    if (summary.entries.isEmpty) {
      buffer.writeln('Keine Arbeitsphasen im gewählten Zeitraum gefunden.\n');
    } else {
      for (var i = 0; i < summary.entries.length; i++) {
        final entry = summary.entries[i];
        final num = summary.entries.length - i;
        buffer.writeln(
          '[$num] ${entry.session.dateFormatted} | ${entry.session.timeRangeFormatted}',
        );
        buffer.writeln('    Aufgabe:     ${entry.item.title}');
        buffer.writeln('    Dauer:       ${entry.session.formattedDuration}');
        if (entry.session.userName != null) {
          buffer.writeln('    Bearbeiter:  ${entry.session.userName}');
        }
        if (entry.pauseBeforeSeconds != null &&
            entry.pauseBeforeSeconds! > 30) {
          buffer.writeln(
            '    Pause davor: ☕ ${WorkSession.formatPause(entry.pauseBeforeSeconds!)}',
          );
        }
        buffer.writeln('');
      }
    }

    buffer.writeln('════════════════════════════════════════════════════════');
    buffer.writeln('Generiert mit TeamSync ToDo');
    return buffer.toString();
  }

  static String _escapeCsv(String value) {
    if (value.contains(';') || value.contains('"') || value.contains('\n')) {
      return '"${value.replaceAll('"', '""')}"';
    }
    return value;
  }
}
