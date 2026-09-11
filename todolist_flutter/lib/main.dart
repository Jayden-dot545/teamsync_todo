import 'package:flutter/material.dart';
import 'auth/auth_screen.dart';
import 'auth/welcome_screen.dart';
import 'core/client.dart';
import 'core/theme.dart';
import 'core/user_prefs.dart';
import 'uebersetzungen/app_localizations.dart';
import 'lists/list_overview_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeServerpodClient();
  await UserPrefs.init();
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: UserPrefs.themeModeNotifier,
      builder: (context, currentMode, _) {
        return ValueListenableBuilder<Locale?>(
          valueListenable: UserPrefs.localeNotifier,
          builder: (context, currentLocale, _) {
            return MaterialApp(
              title: 'TeamSync ToDo',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: currentMode,
              locale: currentLocale,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              localeResolutionCallback: (deviceLocale, supportedLocales) {
                if (currentLocale != null) return currentLocale;
                if (deviceLocale != null &&
                    deviceLocale.languageCode.toLowerCase() == 'de') {
                  return const Locale('de');
                }
                // English is the default fallback!
                return const Locale('en');
              },
              home: const AuthGate(),
            );
          },
        );
      },
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: client.auth.authInfoListenable,
      builder: (context, authInfo, _) {
        if (authInfo != null) {
          return const ListOverviewScreen();
        }

        return ValueListenableBuilder<String?>(
          valueListenable: UserPrefs.lastEmailNotifier,
          builder: (context, savedEmail, _) {
            if (savedEmail != null && savedEmail.trim().isNotEmpty) {
              return const AuthScreen();
            }
            return const WelcomeScreen();
          },
        );
      },
    );
  }
}
