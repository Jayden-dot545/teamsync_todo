import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart'
    hide Protocol;
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolist_client/todolist_client.dart';

export 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart'
    hide Protocol;
export 'package:todolist_client/todolist_client.dart';

late final Client client;

/// Robust SharedPreferences-based authentication storage.
/// Bypasses macOS Keychain entitlement restrictions (-34018) while providing full persistence.
class SharedPreferencesAuthSuccessStorage implements ClientAuthSuccessStorage {
  static const _key = 'serverpod_auth_success_session_v1';

  @override
  Future<AuthSuccess?> get() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_key);
      if (raw == null || raw.isEmpty) return null;
      final jsonMap = jsonDecode(raw);
      return AuthSuccess.fromJson(jsonMap);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> set(AuthSuccess? authSuccess) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (authSuccess == null) {
        await prefs.remove(_key);
      } else {
        final jsonStr = jsonEncode(authSuccess.toJson());
        await prefs.setString(_key, jsonStr);
      }
    } catch (_) {}
  }
}

Future<void> initializeServerpodClient() async {
  final String host;
  if (kIsWeb) {
    host = 'http://localhost:8080/';
  } else if (defaultTargetPlatform == TargetPlatform.android) {
    host = 'http://10.0.2.2:8080/';
  } else {
    // macOS, iOS Simulator, Windows, Linux (explicit IPv4 loopback)
    host = 'http://127.0.0.1:8080/';
  }

  client = Client(host)..connectivityMonitor = FlutterConnectivityMonitor();
  FlutterAuthSessionManagerExtension(client).authSessionManager =
      FlutterAuthSessionManager(
    storage: SharedPreferencesAuthSuccessStorage(),
  );
}
