import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'client.dart';

class UserPrefs {
  static const String _keyDisplayName = 'user_custom_display_name';
  static const String _keyBio = 'user_custom_bio';
  static const String _keyAvatarIndex = 'user_custom_avatar_index';
  static const String _keyStatus = 'user_custom_status';
  static const String _keyThemeMode = 'user_custom_theme_mode';
  static const String _keyNotificationsEnabled =
      'user_custom_notifications_enabled';
  static const String _keyLastEmail = 'user_last_logged_in_email';
  static const String _keyAccountThemePrefix = 'user_theme_account_';
  static const String _keyLocale = 'user_custom_locale';

  static final ValueNotifier<String?> displayNameNotifier =
      ValueNotifier<String?>(null);
  static final ValueNotifier<String?> bioNotifier = ValueNotifier<String?>(
    'Produktivität & Team-Sync im Fokus 🚀',
  );
  static final ValueNotifier<int> avatarIndexNotifier = ValueNotifier<int>(0);
  static final ValueNotifier<String> statusNotifier = ValueNotifier<String>(
    '👑 Chef & Teamleiter',
  );
  static final ValueNotifier<ThemeMode> themeModeNotifier =
      ValueNotifier<ThemeMode>(ThemeMode.system);
  static final ValueNotifier<Locale?> localeNotifier = ValueNotifier<Locale?>(
    null,
  );
  static final ValueNotifier<bool> notificationsEnabledNotifier =
      ValueNotifier<bool>(true);
  static final ValueNotifier<String?> lastEmailNotifier =
      ValueNotifier<String?>(null);

  static const List<String> avatarEmojis = [
    '👑',
    '🚀',
    '⚡',
    '🎯',
    '💻',
    '🌟',
    '🦁',
    '🦊',
    '🔥',
    '💡',
  ];

  static const List<String> statusOptions = [
    '👑 Chef & Teamleiter',
    '✍️ Aktiver Mitarbeiter',
    '👁️ Zuschauer & Supervisor',
    '🚀 Im Deep Work Workflow',
    '🎯 Aufgaben fokussieren',
    '☕ Kurze Kaffeepause',
  ];

  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    displayNameNotifier.value = prefs.getString(_keyDisplayName);
    bioNotifier.value =
        prefs.getString(_keyBio) ?? 'Produktivität & Team-Sync im Fokus 🚀';
    avatarIndexNotifier.value = prefs.getInt(_keyAvatarIndex) ?? 0;
    statusNotifier.value =
        prefs.getString(_keyStatus) ?? '👑 Chef & Teamleiter';

    final savedLocale = prefs.getString(_keyLocale);
    if (savedLocale == 'de') {
      localeNotifier.value = const Locale('de');
    } else if (savedLocale == 'en') {
      localeNotifier.value = const Locale('en');
    } else {
      localeNotifier.value = null; // System Default
    }

    final savedEmail = prefs.getString(_keyLastEmail);
    lastEmailNotifier.value = savedEmail;

    if (savedEmail != null && savedEmail.trim().isNotEmpty) {
      final accountTheme = prefs.getString(
        '$_keyAccountThemePrefix${savedEmail.trim()}',
      );
      if (accountTheme == 'light') {
        themeModeNotifier.value = ThemeMode.light;
      } else if (accountTheme == 'dark') {
        themeModeNotifier.value = ThemeMode.dark;
      } else if (accountTheme == 'system') {
        themeModeNotifier.value = ThemeMode.system;
      } else {
        final globalTheme = prefs.getString(_keyThemeMode);
        themeModeNotifier.value = globalTheme == 'light'
            ? ThemeMode.light
            : globalTheme == 'dark'
            ? ThemeMode.dark
            : ThemeMode.system;
      }
    } else {
      // Default on fresh device / unknown account is System Mode
      themeModeNotifier.value = ThemeMode.system;
    }

    notificationsEnabledNotifier.value =
        prefs.getBool(_keyNotificationsEnabled) ?? true;

    // If authenticated, sync everything from the server database
    if (client.auth.authInfo != null) {
      await syncFromServer();
    }
  }

  /// Syncs all profile data and app settings from the PostgreSQL database.
  static Future<void> syncFromServer() async {
    if (client.auth.authInfo == null) return;
    try {
      final profile = await client.todoList.getUserProfileData();
      final prefs = await SharedPreferences.getInstance();
      if (profile.email != null && profile.email!.trim().isNotEmpty) {
        final cleanEmail = profile.email!.trim();
        await prefs.setString(_keyLastEmail, cleanEmail);
        lastEmailNotifier.value = cleanEmail;
      }

      if (profile.displayName != null &&
          profile.displayName!.trim().isNotEmpty) {
        final clean = profile.displayName!.trim();
        await prefs.setString(_keyDisplayName, clean);
        displayNameNotifier.value = clean;
      }

      if (profile.bio != null && profile.bio!.trim().isNotEmpty) {
        final clean = profile.bio!.trim();
        await prefs.setString(_keyBio, clean);
        bioNotifier.value = clean;
      }

      if (profile.avatarIndex != null) {
        await prefs.setInt(_keyAvatarIndex, profile.avatarIndex!);
        avatarIndexNotifier.value = profile.avatarIndex!;
      }

      if (profile.status != null && profile.status!.trim().isNotEmpty) {
        final clean = profile.status!.trim();
        await prefs.setString(_keyStatus, clean);
        statusNotifier.value = clean;
      }

      if (profile.locale != null) {
        await prefs.setString(_keyLocale, profile.locale!);
        if (profile.locale == 'de') {
          localeNotifier.value = const Locale('de');
        } else if (profile.locale == 'en') {
          localeNotifier.value = const Locale('en');
        } else {
          localeNotifier.value = null; // System
        }
      }

      if (profile.themeMode != null) {
        await prefs.setString(_keyThemeMode, profile.themeMode!);
        final currentEmail = lastEmailNotifier.value?.trim();
        if (currentEmail != null && currentEmail.isNotEmpty) {
          await prefs.setString(
            '$_keyAccountThemePrefix$currentEmail',
            profile.themeMode!,
          );
        }
        if (profile.themeMode == 'light') {
          themeModeNotifier.value = ThemeMode.light;
        } else if (profile.themeMode == 'system') {
          themeModeNotifier.value = ThemeMode.system;
        } else {
          themeModeNotifier.value = ThemeMode.dark;
        }
      }

      if (profile.notificationsEnabled != null) {
        await prefs.setBool(
          _keyNotificationsEnabled,
          profile.notificationsEnabled!,
        );
        notificationsEnabledNotifier.value = profile.notificationsEnabled!;
      }
    } catch (_) {}
  }

  static Future<String?> getDisplayName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyDisplayName);
  }

  static Future<void> setDisplayName(String name) async {
    final cleanName = name.trim();
    final prefs = await SharedPreferences.getInstance();

    if (cleanName.isEmpty) {
      await prefs.remove(_keyDisplayName);
      displayNameNotifier.value = null;
    } else {
      await prefs.setString(_keyDisplayName, cleanName);
      displayNameNotifier.value = cleanName;
    }
    await syncProfileToServer();
  }

  static Future<void> setBio(String bio) async {
    final clean = bio.trim();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyBio, clean);
    bioNotifier.value = clean;
    await syncProfileToServer();
  }

  static Future<void> setAvatarIndex(int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyAvatarIndex, index);
    avatarIndexNotifier.value = index;
    await syncProfileToServer();
  }

  static Future<void> setStatus(String status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyStatus, status);
    statusNotifier.value = status;
    await syncProfileToServer();
  }

  static Future<void> setLastEmail(String? email) async {
    final prefs = await SharedPreferences.getInstance();
    final clean = email?.trim();
    if (clean == null || clean.isEmpty) {
      await prefs.remove(_keyLastEmail);
      lastEmailNotifier.value = null;
      themeModeNotifier.value = ThemeMode.system;
    } else {
      await prefs.setString(_keyLastEmail, clean);
      lastEmailNotifier.value = clean;

      // Load specific theme for this email if available
      final accountTheme = prefs.getString('$_keyAccountThemePrefix$clean');
      if (accountTheme == 'light') {
        themeModeNotifier.value = ThemeMode.light;
      } else if (accountTheme == 'dark') {
        themeModeNotifier.value = ThemeMode.dark;
      } else if (accountTheme == 'system') {
        themeModeNotifier.value = ThemeMode.system;
      } else {
        themeModeNotifier.value = ThemeMode.system;
      }
    }
  }

  static Future<void> setThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    String modeStr = 'system';
    if (mode == ThemeMode.light) modeStr = 'light';
    if (mode == ThemeMode.dark) modeStr = 'dark';
    await prefs.setString(_keyThemeMode, modeStr);

    final currentEmail = lastEmailNotifier.value?.trim();
    if (currentEmail != null && currentEmail.isNotEmpty) {
      await prefs.setString('$_keyAccountThemePrefix$currentEmail', modeStr);
    }

    themeModeNotifier.value = mode;
    await syncProfileToServer();
  }

  static Future<void> setLocale(Locale? locale) async {
    final prefs = await SharedPreferences.getInstance();
    if (locale == null) {
      await prefs.setString(_keyLocale, 'system');
    } else {
      await prefs.setString(_keyLocale, locale.languageCode);
    }
    localeNotifier.value = locale;
    await syncProfileToServer();
  }

  static Future<void> setNotificationsEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyNotificationsEnabled, enabled);
    notificationsEnabledNotifier.value = enabled;
    await syncProfileToServer();
  }

  /// Persists full user profile and settings to the PostgreSQL database.
  static Future<void> syncProfileToServer() async {
    if (client.auth.authInfo == null) return;
    try {
      final name = displayNameNotifier.value ?? '';
      final bio = bioNotifier.value;
      final avatarIdx = avatarIndexNotifier.value;
      final avatar = avatarIdx < avatarEmojis.length
          ? avatarEmojis[avatarIdx]
          : '👑';
      final status = statusNotifier.value;
      final themeStr = themeModeNotifier.value == ThemeMode.light
          ? 'light'
          : themeModeNotifier.value == ThemeMode.system
          ? 'system'
          : 'dark';
      final localeStr = localeNotifier.value == null
          ? 'system'
          : localeNotifier.value!.languageCode;
      final notifications = notificationsEnabledNotifier.value;

      await client.todoList.saveUserProfileData(
        displayName: name,
        bio: bio,
        avatarIndex: avatarIdx,
        avatarEmoji: avatar,
        status: status,
        themeMode: themeStr,
        locale: localeStr,
        notificationsEnabled: notifications,
      );
    } catch (_) {}
  }

  /// Clears all local preferences and resets user state
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    displayNameNotifier.value = null;
    bioNotifier.value = 'Produktivität & Team-Sync im Fokus 🚀';
    avatarIndexNotifier.value = 0;
    statusNotifier.value = '👑 Chef & Teamleiter';
    themeModeNotifier.value = ThemeMode.system;
    localeNotifier.value = null;
    lastEmailNotifier.value = null;
  }
}
