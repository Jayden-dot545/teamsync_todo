import 'package:flutter_test/flutter_test.dart';

DateTime calculateNextDueDate(DateTime baseDate, String recurrence) {
  switch (recurrence) {
    case 'daily':
      return baseDate.add(const Duration(days: 1));
    case 'workdays':
      if (baseDate.weekday == DateTime.friday) {
        return baseDate.add(const Duration(days: 3));
      } else if (baseDate.weekday == DateTime.saturday) {
        return baseDate.add(const Duration(days: 2));
      } else {
        return baseDate.add(const Duration(days: 1));
      }
    case 'weekly':
      return baseDate.add(const Duration(days: 7));
    case 'monthly':
      final nextMonth = baseDate.month == 12 ? 1 : baseDate.month + 1;
      final nextYear = baseDate.month == 12 ? baseDate.year + 1 : baseDate.year;
      final maxDay = DateTime(nextYear, nextMonth + 1, 0).day;
      final day = baseDate.day > maxDay ? maxDay : baseDate.day;
      return DateTime(nextYear, nextMonth, day, baseDate.hour, baseDate.minute);
    default:
      return baseDate.add(const Duration(days: 1));
  }
}

void main() {
  group('Recurring Tasks Recurrence Calculation Tests', () {
    test('daily recurrence adds 1 day', () {
      final base = DateTime(2026, 9, 1, 10, 0);
      final next = calculateNextDueDate(base, 'daily');
      expect(next, DateTime(2026, 9, 2, 10, 0));
    });

    test('workdays recurrence skips weekend on Friday', () {
      // 2026-09-04 is a Friday
      final friday = DateTime(2026, 9, 4, 9, 0);
      expect(friday.weekday, DateTime.friday);

      final next = calculateNextDueDate(friday, 'workdays');
      expect(next.weekday, DateTime.monday);
      expect(next, DateTime(2026, 9, 7, 9, 0));
    });

    test('weekly recurrence adds 7 days', () {
      final base = DateTime(2026, 9, 1, 14, 30);
      final next = calculateNextDueDate(base, 'weekly');
      expect(next, DateTime(2026, 9, 8, 14, 30));
    });

    test('monthly recurrence advances to next month', () {
      final base = DateTime(2026, 1, 15, 12, 0);
      final next = calculateNextDueDate(base, 'monthly');
      expect(next, DateTime(2026, 2, 15, 12, 0));
    });
  });
}
