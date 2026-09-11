import 'package:flutter/material.dart';
import 'package:todolist_client/todolist_client.dart';

class AppColors {
  // Vibrant Modern Sky/Ocean Blue Palette with Crisp White Contours
  static const Color backgroundDark = Color(
    0xFF0F2B48,
  ); // Fresh Deep Sky Ocean Blue
  static const Color surfaceDark = Color(
    0xFF1B406B,
  ); // Rich Vibrant Navy-Royal Blue
  static const Color surfaceLightDark = Color(
    0xFF245084,
  ); // Elevated Sky-Blue Surface
  static const Color borderDark = Color(
    0x55FFFFFF,
  ); // Crisp Soft White Contour (33% White)
  static const Color borderWhite = Color(
    0x80FFFFFF,
  ); // Brilliant Crisp White Contour (50% White)

  // Dynamic Theme-Aware Color Accessors
  static bool isLight(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light;

  static Color surface(BuildContext context) =>
      isLight(context) ? Colors.white : surfaceDark;

  static Color surfaceLight(BuildContext context) =>
      isLight(context) ? const Color(0xFFF1F5F9) : surfaceLightDark;

  static Color cardBg(BuildContext context) =>
      isLight(context) ? Colors.white : surfaceDark;

  static Color text(BuildContext context) =>
      isLight(context) ? const Color(0xFF000000) : Colors.white;

  static Color textSecondary(BuildContext context) =>
      isLight(context) ? const Color(0xFF1E293B) : const Color(0xFF94A3B8);

  static Color textMuted(BuildContext context) =>
      isLight(context) ? const Color(0xFF334155) : const Color(0xFF94A3B8);

  static Color border(BuildContext context) =>
      isLight(context) ? const Color(0xFFCBD5E1) : borderWhite;

  static Color borderSubtle(BuildContext context) =>
      isLight(context) ? const Color(0xFFE2E8F0) : borderDark;

  static const Color primary = Color(0xFF38BDF8); // Sky 400
  static const Color primaryDark = Color(0xFF0284C7); // Sky 600
  static const Color secondary = Color(0xFF818CF8); // Indigo 400
  static const Color accent = Color(0xFFF472B6); // Pink 400
  static const Color ownerColor = Color(
    0xFFF59E0B,
  ); // Amber / Gold for Boss / Owner
  static const Color editorColor = Color(
    0xFF0284C7,
  ); // Sky Blue for Editor / Worker
  static const Color viewerColor = Color(
    0xFFA855F7,
  ); // Purple for Viewer / Supervisor

  static Color getRoleColor(MemberRole role) => switch (role) {
    MemberRole.owner => ownerColor,
    MemberRole.editor => editorColor,
    MemberRole.viewer => viewerColor,
  };

  // Status & Priority
  static const Color priorityLow = Color(0xFF10B981); // Emerald 500
  static const Color priorityMedium = Color(0xFFF59E0B); // Amber 500
  static const Color priorityHigh = Color(0xFFF43F5E); // Rose 500

  // List Palette Options (for creating colored lists)
  static const List<int> listColors = [
    0xFF38BDF8, // Sky Blue
    0xFF818CF8, // Indigo
    0xFFA855F7, // Purple
    0xFFEC4899, // Pink
    0xFFF43F5E, // Rose
    0xFFF97316, // Orange
    0xFFEAB308, // Yellow
    0xFF10B981, // Emerald
    0xFF06B6D4, // Cyan
    0xFF64748B, // Slate
  ];

  static Color getPriorityColor(TodoPriority priority) => switch (priority) {
    TodoPriority.low => priorityLow,
    TodoPriority.medium => priorityMedium,
    TodoPriority.high => priorityHigh,
  };

  static String getPriorityLabel(TodoPriority priority, {bool isEn = false}) =>
      switch (priority) {
        TodoPriority.low => isEn ? 'Low' : 'Niedrig',
        TodoPriority.medium => isEn ? 'Medium' : 'Mittel',
        TodoPriority.high => isEn ? 'High' : 'Hoch',
      };

  static String getRoleLabel(MemberRole role, {bool isEn = false}) =>
      switch (role) {
        MemberRole.owner => isEn ? 'Owner' : 'Besitzer',
        MemberRole.editor => isEn ? 'Editor' : 'Bearbeiter',
        MemberRole.viewer => isEn ? 'Viewer' : 'Zuschauer',
      };

  static String getRoleDescription(MemberRole role, {bool isEn = false}) =>
      switch (role) {
        MemberRole.owner =>
          isEn
              ? 'Full control over the list and members'
              : 'Volle Kontrolle über die Liste und Mitglieder',
        MemberRole.editor =>
          isEn
              ? 'Can create, edit and check off tasks'
              : 'Kann Aufgaben anlegen, bearbeiten und abhaken',
        MemberRole.viewer =>
          isEn
              ? 'Views live progress & completions (Read-only)'
              : 'Sieht den Live-Fortschritt & Erledigungen (Nur Leserechte)',
      };
}
