import 'dart:convert';

class WorkSession {
  final String id;
  final DateTime startTime;
  DateTime? endTime;
  int durationSeconds;
  final String? userName;
  final String? userId;

  WorkSession({
    required this.id,
    required this.startTime,
    this.endTime,
    required this.durationSeconds,
    this.userName,
    this.userId,
  });

  bool get isRunning => endTime == null;

  String get startFormatted {
    final local = startTime.toLocal();
    final h = local.hour.toString().padLeft(2, '0');
    final m = local.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  String get endFormatted => getEndFormatted();

  String getEndFormatted({bool isEn = false}) {
    if (endTime == null) return isEn ? 'Running...' : 'Läuft...';
    final local = endTime!.toLocal();
    final h = local.hour.toString().padLeft(2, '0');
    final m = local.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  String get dateFormatted => getDateFormatted();

  String getDateFormatted({bool isEn = false}) {
    final local = startTime.toLocal();
    final d = local.day.toString().padLeft(2, '0');
    final m = local.month.toString().padLeft(2, '0');
    final y = local.year;
    return isEn ? '$y-$m-$d' : '$d.$m.$y';
  }

  String get timeRangeFormatted => getTimeRangeFormatted();

  String getTimeRangeFormatted({bool isEn = false}) {
    return '$startFormatted – ${getEndFormatted(isEn: isEn)}';
  }

  String get formattedDuration => getFormattedDuration();

  String getFormattedDuration({bool isEn = false}) {
    return formatDuration(durationSeconds, isEn: isEn);
  }

  static String formatDuration(int totalSeconds, {bool isEn = false}) {
    if (totalSeconds <= 0) return isEn ? '0 sec' : '0 Sek.';
    final hours = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    final seconds = totalSeconds % 60;

    if (hours > 0) {
      if (minutes > 0) {
        return isEn
            ? '$hours hrs ${minutes.toString().padLeft(2, '0')} min'
            : '$hours Std. ${minutes.toString().padLeft(2, '0')} Min.';
      }
      return isEn ? '$hours hrs' : '$hours Std.';
    }
    if (minutes > 0) {
      if (seconds > 0) {
        return isEn
            ? '$minutes min ${seconds.toString().padLeft(2, '0')} sec'
            : '$minutes Min. ${seconds.toString().padLeft(2, '0')} Sek.';
      }
      return isEn ? '$minutes min' : '$minutes Min.';
    }
    return isEn ? '$seconds sec' : '$seconds Sek.';
  }

  /// Calculates pause duration in seconds between this session's end and next session's start.
  static int? calculatePauseSeconds(WorkSession prev, WorkSession next) {
    if (prev.endTime == null) return null;
    final diff = next.startTime.difference(prev.endTime!).inSeconds;
    return diff > 0 ? diff : 0;
  }

  static String formatPause(int pauseSeconds, {bool isEn = false}) {
    final minutes = pauseSeconds ~/ 60;
    final hours = minutes ~/ 60;
    final remainingMins = minutes % 60;

    if (hours > 0) {
      if (remainingMins > 0) {
        return isEn
            ? '$hours hrs $remainingMins min break'
            : '$hours Std. $remainingMins Min. Pause';
      }
      return isEn ? '$hours hrs break' : '$hours Std. Pause';
    }
    if (minutes > 0) {
      return isEn ? '$minutes min break' : '$minutes Min. Pause';
    }
    return isEn ? '$pauseSeconds sec break' : '$pauseSeconds Sek. Pause';
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'startTime': startTime.toIso8601String(),
    'endTime': endTime?.toIso8601String(),
    'durationSeconds': durationSeconds,
    'userName': userName,
    'userId': userId,
  };

  factory WorkSession.fromJson(Map<String, dynamic> map) => WorkSession(
    id: map['id']?.toString() ?? '',
    startTime:
        DateTime.tryParse(map['startTime']?.toString() ?? '') ?? DateTime.now(),
    endTime: map['endTime'] != null
        ? DateTime.tryParse(map['endTime'].toString())
        : null,
    durationSeconds: (map['durationSeconds'] as num?)?.toInt() ?? 0,
    userName: map['userName']?.toString(),
    userId: map['userId']?.toString(),
  );

  static List<WorkSession> decodeList(String? jsonStr) {
    if (jsonStr == null || jsonStr.trim().isEmpty) return [];
    try {
      final decoded = jsonDecode(jsonStr);
      if (decoded is List) {
        return decoded
            .map(
              (item) =>
                  WorkSession.fromJson(Map<String, dynamic>.from(item as Map)),
            )
            .toList();
      }
    } catch (_) {}
    return [];
  }

  static String encodeList(List<WorkSession> list) {
    return jsonEncode(list.map((e) => e.toJson()).toList());
  }
}
