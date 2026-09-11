import 'package:flutter_test/flutter_test.dart';
import 'package:todolist_flutter/todos/models/subtask.dart';

void main() {
  group('SubTask Model Tests', () {
    test('encodeList and decodeList roundtrip works properly', () {
      final list = [
        SubTask(id: '1', title: 'Erster Teilschritt', isDone: false),
        SubTask(id: '2', title: 'Zweiter Teilschritt', isDone: true),
      ];

      final encoded = SubTask.encodeList(list);
      final decoded = SubTask.decodeList(encoded);

      expect(decoded.length, 2);
      expect(decoded[0].id, '1');
      expect(decoded[0].title, 'Erster Teilschritt');
      expect(decoded[0].isDone, false);
      expect(decoded[1].id, '2');
      expect(decoded[1].title, 'Zweiter Teilschritt');
      expect(decoded[1].isDone, true);
    });

    test('decodeList handles null and empty string safely', () {
      expect(SubTask.decodeList(null), isEmpty);
      expect(SubTask.decodeList(''), isEmpty);
      expect(SubTask.decodeList('invalid json'), isEmpty);
    });
  });
}
