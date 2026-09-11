import 'package:flutter_test/flutter_test.dart';
import 'package:todolist_flutter/core/debouncer.dart';

void main() {
  test('Debouncer only executes action after specified duration', () async {
    final debouncer = Debouncer(milliseconds: 50);
    int executionCount = 0;

    debouncer.run(() => executionCount++);
    debouncer.run(() => executionCount++);
    debouncer.run(() => executionCount++);

    expect(executionCount, equals(0));

    await Future.delayed(const Duration(milliseconds: 80));
    expect(executionCount, equals(1));

    debouncer.dispose();
  });
}
