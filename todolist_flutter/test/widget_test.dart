import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todolist_flutter/core/theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('AppTheme loads dark theme with primary color', () {
    final theme = AppTheme.darkTheme;
    expect(theme.brightness, equals(Brightness.dark));
    expect(theme.colorScheme.primary, equals(const Color(0xFF38BDF8)));
  });
}
