import 'dart:convert';

class SubTask {
  final String id;
  String title;
  bool isDone;

  SubTask({
    required this.id,
    required this.title,
    this.isDone = false,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'isDone': isDone,
  };

  factory SubTask.fromJson(Map<String, dynamic> map) => SubTask(
    id: map['id']?.toString() ?? '',
    title: map['title']?.toString() ?? '',
    isDone: map['isDone'] as bool? ?? false,
  );

  static List<SubTask> decodeList(String? jsonStr) {
    if (jsonStr == null || jsonStr.trim().isEmpty) return [];
    try {
      final decoded = jsonDecode(jsonStr);
      if (decoded is List) {
        return decoded
            .map(
              (item) =>
                  SubTask.fromJson(Map<String, dynamic>.from(item as Map)),
            )
            .toList();
      }
    } catch (_) {}
    return [];
  }

  static String encodeList(List<SubTask> list) {
    return jsonEncode(list.map((e) => e.toJson()).toList());
  }
}
