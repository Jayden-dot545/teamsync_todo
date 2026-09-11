import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'uebersetzungen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In de, this message translates to:
  /// **'TeamSync ToDo'**
  String get appTitle;

  /// No description provided for @welcomeTitle.
  ///
  /// In de, this message translates to:
  /// **'Willkommen bei\nTeamSync ToDo'**
  String get welcomeTitle;

  /// No description provided for @welcomeBackTitle.
  ///
  /// In de, this message translates to:
  /// **'Willkommen zurück,\n{userName}!'**
  String welcomeBackTitle(String userName);

  /// No description provided for @welcomeSubtitle.
  ///
  /// In de, this message translates to:
  /// **'Organisiere deine Aufgaben, teile Listen mit deinem Team und arbeite in Echtzeit zusammen.'**
  String get welcomeSubtitle;

  /// No description provided for @welcomeBackSubtitle.
  ///
  /// In de, this message translates to:
  /// **'Bereit für deinen nächsten produktiven Tag? Tippe auf die Kacheln für Details.'**
  String get welcomeBackSubtitle;

  /// No description provided for @startNow.
  ///
  /// In de, this message translates to:
  /// **'Jetzt starten'**
  String get startNow;

  /// No description provided for @liveSyncTitle.
  ///
  /// In de, this message translates to:
  /// **'Live-Synchronisation'**
  String get liveSyncTitle;

  /// No description provided for @liveSyncShortDesc.
  ///
  /// In de, this message translates to:
  /// **'Änderungen und abgehakte Aufgaben erscheinen sofort bei allen Teammitgliedern.'**
  String get liveSyncShortDesc;

  /// No description provided for @liveSyncDetailedDesc.
  ///
  /// In de, this message translates to:
  /// **'Veränderungen an Aufgaben, Statuswechsel und Notizen werden über WebSockets in Millisekunden an alle aktiven Betrachter übertragen.'**
  String get liveSyncDetailedDesc;

  /// No description provided for @sharedListsTitle.
  ///
  /// In de, this message translates to:
  /// **'Gemeinsame Listen & Zuschauer'**
  String get sharedListsTitle;

  /// No description provided for @sharedListsShortDesc.
  ///
  /// In de, this message translates to:
  /// **'Lade Kollegen ein oder verfolge als Zuschauer den Live-Fortschritt.'**
  String get sharedListsShortDesc;

  /// No description provided for @sharedListsDetailedDesc.
  ///
  /// In de, this message translates to:
  /// **'Arbeite im Team oder behalte den Überblick als Beobachter (z. B. Praktikanten im Home-Office oder Familien-Aufgaben).'**
  String get sharedListsDetailedDesc;

  /// No description provided for @prioritiesTitle.
  ///
  /// In de, this message translates to:
  /// **'Prioritäten & Fälligkeit'**
  String get prioritiesTitle;

  /// No description provided for @prioritiesShortDesc.
  ///
  /// In de, this message translates to:
  /// **'Behalte wichtige Deadlines und dringende ToDos immer im Fokus.'**
  String get prioritiesShortDesc;

  /// No description provided for @prioritiesDetailedDesc.
  ///
  /// In de, this message translates to:
  /// **'Strukturiere deinen Tag mit klaren Fälligkeitsdaten, Prioritäts-Kennzeichnungen und intelligenten Filtern.'**
  String get prioritiesDetailedDesc;

  /// No description provided for @authWelcomeBack.
  ///
  /// In de, this message translates to:
  /// **'Willkommen zurück!'**
  String get authWelcomeBack;

  /// No description provided for @authSubtitle.
  ///
  /// In de, this message translates to:
  /// **'Melde dich an oder erstelle ein Konto, um sofort loszulegen.'**
  String get authSubtitle;

  /// No description provided for @authEncrypted.
  ///
  /// In de, this message translates to:
  /// **'Verschlüsselt'**
  String get authEncrypted;

  /// No description provided for @authRealtimeSync.
  ///
  /// In de, this message translates to:
  /// **'Echtzeit Sync'**
  String get authRealtimeSync;

  /// No description provided for @authMultiUser.
  ///
  /// In de, this message translates to:
  /// **'Multi-User'**
  String get authMultiUser;

  /// No description provided for @authAccountAccess.
  ///
  /// In de, this message translates to:
  /// **'Konto-Zugang'**
  String get authAccountAccess;

  /// No description provided for @authFooterNote.
  ///
  /// In de, this message translates to:
  /// **'Registrierung und Login sind nahtlos integriert. Keine zusätzliche Bestätigung im Browser nötig.'**
  String get authFooterNote;

  /// No description provided for @authError.
  ///
  /// In de, this message translates to:
  /// **'Fehler bei der Anmeldung: {error}'**
  String authError(String error);

  /// No description provided for @listsOverview.
  ///
  /// In de, this message translates to:
  /// **'Listen-Übersicht'**
  String get listsOverview;

  /// No description provided for @myLists.
  ///
  /// In de, this message translates to:
  /// **'Meine Listen'**
  String get myLists;

  /// No description provided for @allTab.
  ///
  /// In de, this message translates to:
  /// **'Alle'**
  String get allTab;

  /// No description provided for @ownedTab.
  ///
  /// In de, this message translates to:
  /// **'Eigene'**
  String get ownedTab;

  /// No description provided for @sharedTab.
  ///
  /// In de, this message translates to:
  /// **'Geteilt'**
  String get sharedTab;

  /// No description provided for @searchLists.
  ///
  /// In de, this message translates to:
  /// **'Listen durchsuchen...'**
  String get searchLists;

  /// No description provided for @newList.
  ///
  /// In de, this message translates to:
  /// **'Neue Liste'**
  String get newList;

  /// No description provided for @noListsFound.
  ///
  /// In de, this message translates to:
  /// **'Keine Listen gefunden'**
  String get noListsFound;

  /// No description provided for @createFirstList.
  ///
  /// In de, this message translates to:
  /// **'Erstelle deine erste ToDo-Liste und lade Teammitglieder ein!'**
  String get createFirstList;

  /// No description provided for @deleteList.
  ///
  /// In de, this message translates to:
  /// **'Liste löschen'**
  String get deleteList;

  /// No description provided for @deleteListConfirm.
  ///
  /// In de, this message translates to:
  /// **'Möchtest du die Liste \"{title}\" wirklich unwiderruflich löschen?'**
  String deleteListConfirm(String title);

  /// No description provided for @leaveList.
  ///
  /// In de, this message translates to:
  /// **'Aus Liste austreten'**
  String get leaveList;

  /// No description provided for @leaveListConfirm.
  ///
  /// In de, this message translates to:
  /// **'Möchtest du die Liste \"{title}\" wirklich verlassen?'**
  String leaveListConfirm(String title);

  /// No description provided for @cancel.
  ///
  /// In de, this message translates to:
  /// **'Abbrechen'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In de, this message translates to:
  /// **'Löschen'**
  String get delete;

  /// No description provided for @leave.
  ///
  /// In de, this message translates to:
  /// **'Austreten'**
  String get leave;

  /// No description provided for @save.
  ///
  /// In de, this message translates to:
  /// **'Speichern'**
  String get save;

  /// No description provided for @edit.
  ///
  /// In de, this message translates to:
  /// **'Bearbeiten'**
  String get edit;

  /// No description provided for @close.
  ///
  /// In de, this message translates to:
  /// **'Schließen'**
  String get close;

  /// No description provided for @create.
  ///
  /// In de, this message translates to:
  /// **'Erstellen'**
  String get create;

  /// No description provided for @done.
  ///
  /// In de, this message translates to:
  /// **'Fertig'**
  String get done;

  /// No description provided for @tasksTitle.
  ///
  /// In de, this message translates to:
  /// **'Aufgaben'**
  String get tasksTitle;

  /// No description provided for @filterAll.
  ///
  /// In de, this message translates to:
  /// **'Alle'**
  String get filterAll;

  /// No description provided for @filterActive.
  ///
  /// In de, this message translates to:
  /// **'Offen'**
  String get filterActive;

  /// No description provided for @filterCompleted.
  ///
  /// In de, this message translates to:
  /// **'Erledigt'**
  String get filterCompleted;

  /// No description provided for @filterHighPriority.
  ///
  /// In de, this message translates to:
  /// **'Hohe Prio'**
  String get filterHighPriority;

  /// No description provided for @filterAssignedToMe.
  ///
  /// In de, this message translates to:
  /// **'Meine'**
  String get filterAssignedToMe;

  /// No description provided for @addTask.
  ///
  /// In de, this message translates to:
  /// **'Aufgabe hinzufügen'**
  String get addTask;

  /// No description provided for @editTask.
  ///
  /// In de, this message translates to:
  /// **'Aufgabe bearbeiten'**
  String get editTask;

  /// No description provided for @taskTitle.
  ///
  /// In de, this message translates to:
  /// **'Was ist zu tun?'**
  String get taskTitle;

  /// No description provided for @taskDescription.
  ///
  /// In de, this message translates to:
  /// **'Details oder Notizen (optional)...'**
  String get taskDescription;

  /// No description provided for @priority.
  ///
  /// In de, this message translates to:
  /// **'Priorität'**
  String get priority;

  /// No description provided for @priorityLow.
  ///
  /// In de, this message translates to:
  /// **'Niedrig'**
  String get priorityLow;

  /// No description provided for @priorityMedium.
  ///
  /// In de, this message translates to:
  /// **'Mittel'**
  String get priorityMedium;

  /// No description provided for @priorityHigh.
  ///
  /// In de, this message translates to:
  /// **'Hoch'**
  String get priorityHigh;

  /// No description provided for @dueDate.
  ///
  /// In de, this message translates to:
  /// **'Fälligkeitsdatum'**
  String get dueDate;

  /// No description provided for @assignTo.
  ///
  /// In de, this message translates to:
  /// **'Zuweisen an...'**
  String get assignTo;

  /// No description provided for @nobody.
  ///
  /// In de, this message translates to:
  /// **'Niemand'**
  String get nobody;

  /// No description provided for @subtasks.
  ///
  /// In de, this message translates to:
  /// **'Unteraufgaben & Teilschritte'**
  String get subtasks;

  /// No description provided for @addSubtask.
  ///
  /// In de, this message translates to:
  /// **'Teilschritt hinzufügen...'**
  String get addSubtask;

  /// No description provided for @workTimerActive.
  ///
  /// In de, this message translates to:
  /// **'Zeiterfassung aktiv'**
  String get workTimerActive;

  /// No description provided for @workTimerRecorded.
  ///
  /// In de, this message translates to:
  /// **'Erfasste Arbeitszeit'**
  String get workTimerRecorded;

  /// No description provided for @timerRunningSession.
  ///
  /// In de, this message translates to:
  /// **'Laufende Session: {time}'**
  String timerRunningSession(String time);

  /// No description provided for @timerTotalTime.
  ///
  /// In de, this message translates to:
  /// **'Bisher gebraucht: {time}'**
  String timerTotalTime(String time);

  /// No description provided for @startTimer.
  ///
  /// In de, this message translates to:
  /// **'Starten'**
  String get startTimer;

  /// No description provided for @pauseTimer.
  ///
  /// In de, this message translates to:
  /// **'Pausieren'**
  String get pauseTimer;

  /// No description provided for @activeBadge.
  ///
  /// In de, this message translates to:
  /// **'Aktiv: {time}'**
  String activeBadge(String time);

  /// No description provided for @usedBadge.
  ///
  /// In de, this message translates to:
  /// **'Gebraucht: {time}'**
  String usedBadge(String time);

  /// No description provided for @completedBy.
  ///
  /// In de, this message translates to:
  /// **'Erledigt von {name}'**
  String completedBy(String name);

  /// No description provided for @dueOverdue.
  ///
  /// In de, this message translates to:
  /// **'Überfällig'**
  String get dueOverdue;

  /// No description provided for @dueToday.
  ///
  /// In de, this message translates to:
  /// **'Heute'**
  String get dueToday;

  /// No description provided for @dueTomorrow.
  ///
  /// In de, this message translates to:
  /// **'Morgen'**
  String get dueTomorrow;

  /// No description provided for @roleOwner.
  ///
  /// In de, this message translates to:
  /// **'Chef / Projektleitung'**
  String get roleOwner;

  /// No description provided for @roleEditor.
  ///
  /// In de, this message translates to:
  /// **'Mitarbeiter / Bearbeiter'**
  String get roleEditor;

  /// No description provided for @roleViewer.
  ///
  /// In de, this message translates to:
  /// **'Zuschauer (Nur Leserechte)'**
  String get roleViewer;

  /// No description provided for @settings.
  ///
  /// In de, this message translates to:
  /// **'Einstellungen'**
  String get settings;

  /// No description provided for @themeMode.
  ///
  /// In de, this message translates to:
  /// **'Erscheinungsbild'**
  String get themeMode;

  /// No description provided for @themeDark.
  ///
  /// In de, this message translates to:
  /// **'Dunkel'**
  String get themeDark;

  /// No description provided for @themeLight.
  ///
  /// In de, this message translates to:
  /// **'Hell'**
  String get themeLight;

  /// No description provided for @themeSystem.
  ///
  /// In de, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @notifications.
  ///
  /// In de, this message translates to:
  /// **'Live-Synchronisation & Benachrichtigungen'**
  String get notifications;

  /// No description provided for @notificationsDesc.
  ///
  /// In de, this message translates to:
  /// **'Echtzeit-Updates für Änderungen und Chats'**
  String get notificationsDesc;

  /// No description provided for @clearCache.
  ///
  /// In de, this message translates to:
  /// **'Lokalen Cache leeren'**
  String get clearCache;

  /// No description provided for @clearCacheDesc.
  ///
  /// In de, this message translates to:
  /// **'Bereinigt zwischengespeicherte Daten'**
  String get clearCacheDesc;

  /// No description provided for @signOut.
  ///
  /// In de, this message translates to:
  /// **'Abmelden'**
  String get signOut;

  /// No description provided for @resetPassword.
  ///
  /// In de, this message translates to:
  /// **'Passwort zurücksetzen'**
  String get resetPassword;

  /// No description provided for @profileEdit.
  ///
  /// In de, this message translates to:
  /// **'Benutzerprofil bearbeiten'**
  String get profileEdit;

  /// No description provided for @profileSaved.
  ///
  /// In de, this message translates to:
  /// **'Profil erfolgreich gespeichert!'**
  String get profileSaved;

  /// No description provided for @language.
  ///
  /// In de, this message translates to:
  /// **'Sprache'**
  String get language;

  /// No description provided for @languageDe.
  ///
  /// In de, this message translates to:
  /// **'Deutsch'**
  String get languageDe;

  /// No description provided for @languageEn.
  ///
  /// In de, this message translates to:
  /// **'English'**
  String get languageEn;

  /// No description provided for @languageSystem.
  ///
  /// In de, this message translates to:
  /// **'System (Standard)'**
  String get languageSystem;

  /// No description provided for @exportCsv.
  ///
  /// In de, this message translates to:
  /// **'Arbeitszeiten als CSV exportieren'**
  String get exportCsv;

  /// No description provided for @exportTaskCsv.
  ///
  /// In de, this message translates to:
  /// **'Aufgaben-Zeiten als CSV exportieren'**
  String get exportTaskCsv;

  /// No description provided for @copyCsv.
  ///
  /// In de, this message translates to:
  /// **'CSV in Zwischenablage kopieren'**
  String get copyCsv;

  /// No description provided for @downloadCsv.
  ///
  /// In de, this message translates to:
  /// **'CSV-Datei herunterladen / teilen'**
  String get downloadCsv;

  /// No description provided for @copiedToClipboard.
  ///
  /// In de, this message translates to:
  /// **'In die Zwischenablage kopiert!'**
  String get copiedToClipboard;

  /// No description provided for @csvExportSuccess.
  ///
  /// In de, this message translates to:
  /// **'CSV erfolgreich exportiert'**
  String get csvExportSuccess;

  /// No description provided for @taskWorkTimes.
  ///
  /// In de, this message translates to:
  /// **'Zeiterfassung & Arbeitsphasen'**
  String get taskWorkTimes;

  /// No description provided for @chatTitle.
  ///
  /// In de, this message translates to:
  /// **'Team-Chat & Nachrichten'**
  String get chatTitle;

  /// No description provided for @chatTabTeam.
  ///
  /// In de, this message translates to:
  /// **'Team-Chat'**
  String get chatTabTeam;

  /// No description provided for @chatTabPrivate.
  ///
  /// In de, this message translates to:
  /// **'Private DMs'**
  String get chatTabPrivate;

  /// No description provided for @chatPlaceholder.
  ///
  /// In de, this message translates to:
  /// **'Nachricht schreiben...'**
  String get chatPlaceholder;

  /// No description provided for @send.
  ///
  /// In de, this message translates to:
  /// **'Senden'**
  String get send;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
