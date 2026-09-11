// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'TeamSync ToDo';

  @override
  String get welcomeTitle => 'Willkommen bei\nTeamSync ToDo';

  @override
  String welcomeBackTitle(String userName) {
    return 'Willkommen zurück,\n$userName!';
  }

  @override
  String get welcomeSubtitle =>
      'Organisiere deine Aufgaben, teile Listen mit deinem Team und arbeite in Echtzeit zusammen.';

  @override
  String get welcomeBackSubtitle =>
      'Bereit für deinen nächsten produktiven Tag? Tippe auf die Kacheln für Details.';

  @override
  String get startNow => 'Jetzt starten';

  @override
  String get liveSyncTitle => 'Live-Synchronisation';

  @override
  String get liveSyncShortDesc =>
      'Änderungen und abgehakte Aufgaben erscheinen sofort bei allen Teammitgliedern.';

  @override
  String get liveSyncDetailedDesc =>
      'Veränderungen an Aufgaben, Statuswechsel und Notizen werden über WebSockets in Millisekunden an alle aktiven Betrachter übertragen.';

  @override
  String get sharedListsTitle => 'Gemeinsame Listen & Zuschauer';

  @override
  String get sharedListsShortDesc =>
      'Lade Kollegen ein oder verfolge als Zuschauer den Live-Fortschritt.';

  @override
  String get sharedListsDetailedDesc =>
      'Arbeite im Team oder behalte den Überblick als Beobachter (z. B. Praktikanten im Home-Office oder Familien-Aufgaben).';

  @override
  String get prioritiesTitle => 'Prioritäten & Fälligkeit';

  @override
  String get prioritiesShortDesc =>
      'Behalte wichtige Deadlines und dringende ToDos immer im Fokus.';

  @override
  String get prioritiesDetailedDesc =>
      'Strukturiere deinen Tag mit klaren Fälligkeitsdaten, Prioritäts-Kennzeichnungen und intelligenten Filtern.';

  @override
  String get authWelcomeBack => 'Willkommen zurück!';

  @override
  String get authSubtitle =>
      'Melde dich an oder erstelle ein Konto, um sofort loszulegen.';

  @override
  String get authEncrypted => 'Verschlüsselt';

  @override
  String get authRealtimeSync => 'Echtzeit Sync';

  @override
  String get authMultiUser => 'Multi-User';

  @override
  String get authAccountAccess => 'Konto-Zugang';

  @override
  String get authFooterNote =>
      'Registrierung und Login sind nahtlos integriert. Keine zusätzliche Bestätigung im Browser nötig.';

  @override
  String authError(String error) {
    return 'Fehler bei der Anmeldung: $error';
  }

  @override
  String get listsOverview => 'Listen-Übersicht';

  @override
  String get myLists => 'Meine Listen';

  @override
  String get allTab => 'Alle';

  @override
  String get ownedTab => 'Eigene';

  @override
  String get sharedTab => 'Geteilt';

  @override
  String get searchLists => 'Listen durchsuchen...';

  @override
  String get newList => 'Neue Liste';

  @override
  String get noListsFound => 'Keine Listen gefunden';

  @override
  String get createFirstList =>
      'Erstelle deine erste ToDo-Liste und lade Teammitglieder ein!';

  @override
  String get deleteList => 'Liste löschen';

  @override
  String deleteListConfirm(String title) {
    return 'Möchtest du die Liste \"$title\" wirklich unwiderruflich löschen?';
  }

  @override
  String get leaveList => 'Aus Liste austreten';

  @override
  String leaveListConfirm(String title) {
    return 'Möchtest du die Liste \"$title\" wirklich verlassen?';
  }

  @override
  String get cancel => 'Abbrechen';

  @override
  String get delete => 'Löschen';

  @override
  String get leave => 'Austreten';

  @override
  String get save => 'Speichern';

  @override
  String get edit => 'Bearbeiten';

  @override
  String get close => 'Schließen';

  @override
  String get create => 'Erstellen';

  @override
  String get done => 'Fertig';

  @override
  String get tasksTitle => 'Aufgaben';

  @override
  String get filterAll => 'Alle';

  @override
  String get filterActive => 'Offen';

  @override
  String get filterCompleted => 'Erledigt';

  @override
  String get filterHighPriority => 'Hohe Prio';

  @override
  String get filterAssignedToMe => 'Meine';

  @override
  String get addTask => 'Aufgabe hinzufügen';

  @override
  String get editTask => 'Aufgabe bearbeiten';

  @override
  String get taskTitle => 'Was ist zu tun?';

  @override
  String get taskDescription => 'Details oder Notizen (optional)...';

  @override
  String get priority => 'Priorität';

  @override
  String get priorityLow => 'Niedrig';

  @override
  String get priorityMedium => 'Mittel';

  @override
  String get priorityHigh => 'Hoch';

  @override
  String get dueDate => 'Fälligkeitsdatum';

  @override
  String get assignTo => 'Zuweisen an...';

  @override
  String get nobody => 'Niemand';

  @override
  String get subtasks => 'Unteraufgaben & Teilschritte';

  @override
  String get addSubtask => 'Teilschritt hinzufügen...';

  @override
  String get workTimerActive => 'Zeiterfassung aktiv';

  @override
  String get workTimerRecorded => 'Erfasste Arbeitszeit';

  @override
  String timerRunningSession(String time) {
    return 'Laufende Session: $time';
  }

  @override
  String timerTotalTime(String time) {
    return 'Bisher gebraucht: $time';
  }

  @override
  String get startTimer => 'Starten';

  @override
  String get pauseTimer => 'Pausieren';

  @override
  String activeBadge(String time) {
    return 'Aktiv: $time';
  }

  @override
  String usedBadge(String time) {
    return 'Gebraucht: $time';
  }

  @override
  String completedBy(String name) {
    return 'Erledigt von $name';
  }

  @override
  String get dueOverdue => 'Überfällig';

  @override
  String get dueToday => 'Heute';

  @override
  String get dueTomorrow => 'Morgen';

  @override
  String get roleOwner => 'Chef / Projektleitung';

  @override
  String get roleEditor => 'Mitarbeiter / Bearbeiter';

  @override
  String get roleViewer => 'Zuschauer (Nur Leserechte)';

  @override
  String get settings => 'Einstellungen';

  @override
  String get themeMode => 'Erscheinungsbild';

  @override
  String get themeDark => 'Dunkel';

  @override
  String get themeLight => 'Hell';

  @override
  String get themeSystem => 'System';

  @override
  String get notifications => 'Live-Synchronisation & Benachrichtigungen';

  @override
  String get notificationsDesc => 'Echtzeit-Updates für Änderungen und Chats';

  @override
  String get clearCache => 'Lokalen Cache leeren';

  @override
  String get clearCacheDesc => 'Bereinigt zwischengespeicherte Daten';

  @override
  String get signOut => 'Abmelden';

  @override
  String get resetPassword => 'Passwort zurücksetzen';

  @override
  String get profileEdit => 'Benutzerprofil bearbeiten';

  @override
  String get profileSaved => 'Profil erfolgreich gespeichert!';

  @override
  String get language => 'Sprache';

  @override
  String get languageDe => 'Deutsch';

  @override
  String get languageEn => 'English';

  @override
  String get languageSystem => 'System (Standard)';

  @override
  String get exportCsv => 'Arbeitszeiten als CSV exportieren';

  @override
  String get exportTaskCsv => 'Aufgaben-Zeiten als CSV exportieren';

  @override
  String get copyCsv => 'CSV in Zwischenablage kopieren';

  @override
  String get downloadCsv => 'CSV-Datei herunterladen / teilen';

  @override
  String get copiedToClipboard => 'In die Zwischenablage kopiert!';

  @override
  String get csvExportSuccess => 'CSV erfolgreich exportiert';

  @override
  String get taskWorkTimes => 'Zeiterfassung & Arbeitsphasen';

  @override
  String get chatTitle => 'Team-Chat & Nachrichten';

  @override
  String get chatTabTeam => 'Team-Chat';

  @override
  String get chatTabPrivate => 'Private DMs';

  @override
  String get chatPlaceholder => 'Nachricht schreiben...';

  @override
  String get send => 'Senden';
}
