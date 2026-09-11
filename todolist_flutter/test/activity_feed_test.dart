import 'package:flutter_test/flutter_test.dart';

String formatRelativeTime(DateTime time, DateTime now) {
  final diff = now.difference(time);

  if (diff.inSeconds < 60) return 'Gerade eben';
  if (diff.inMinutes < 60) return 'vor ${diff.inMinutes} Min.';
  if (diff.inHours < 24 && now.day == time.day) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return 'Heute, $hour:$minute';
  }
  final day = time.day.toString().padLeft(2, '0');
  final month = time.month.toString().padLeft(2, '0');
  final hour = time.hour.toString().padLeft(2, '0');
  final minute = time.minute.toString().padLeft(2, '0');
  return '$day.$month. $hour:$minute';
}

void main() {
  group('Activity Feed Relative Time Formatting Tests', () {
    test('less than 1 minute returns Gerade eben', () {
      final now = DateTime(2026, 9, 1, 12, 0, 30);
      final time = DateTime(2026, 9, 1, 12, 0, 0);
      expect(formatRelativeTime(time, now), equals('Gerade eben'));
    });

    test('10 minutes ago returns vor 10 Min.', () {
      final now = DateTime(2026, 9, 1, 12, 15);
      final time = DateTime(2026, 9, 1, 12, 5);
      expect(formatRelativeTime(time, now), equals('vor 10 Min.'));
    });

    test('3 hours ago today returns Heute, HH:MM', () {
      final now = DateTime(2026, 9, 1, 15, 0);
      final time = DateTime(2026, 9, 1, 12, 0);
      expect(formatRelativeTime(time, now), equals('Heute, 12:00'));
    });

    test('different day returns DD.MM. HH:MM', () {
      final now = DateTime(2026, 9, 5, 15, 0);
      final time = DateTime(2026, 8, 28, 9, 30);
      expect(formatRelativeTime(time, now), equals('28.08. 09:30'));
    });
  });
}
