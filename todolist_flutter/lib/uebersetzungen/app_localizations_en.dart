// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'TeamSync ToDo';

  @override
  String get welcomeTitle => 'Welcome to\nTeamSync ToDo';

  @override
  String welcomeBackTitle(String userName) {
    return 'Welcome back,\n$userName!';
  }

  @override
  String get welcomeSubtitle =>
      'Organize tasks, share lists with your team, and collaborate in real-time.';

  @override
  String get welcomeBackSubtitle =>
      'Ready for another productive day? Tap the cards for details.';

  @override
  String get startNow => 'Get Started';

  @override
  String get liveSyncTitle => 'Live Synchronization';

  @override
  String get liveSyncShortDesc =>
      'Changes and completed tasks appear instantly for all team members.';

  @override
  String get liveSyncDetailedDesc =>
      'Task updates, status changes, and notes are streamed in milliseconds via WebSockets to all active viewers.';

  @override
  String get sharedListsTitle => 'Shared Lists & Viewers';

  @override
  String get sharedListsShortDesc =>
      'Invite team members or track progress in real-time as a viewer.';

  @override
  String get sharedListsDetailedDesc =>
      'Work together as a team or supervise progress (e.g. remote interns or family projects).';

  @override
  String get prioritiesTitle => 'Priorities & Due Dates';

  @override
  String get prioritiesShortDesc =>
      'Keep key deadlines and urgent to-dos always in focus.';

  @override
  String get prioritiesDetailedDesc =>
      'Structure your day with clear due dates, priority badges, and smart filters.';

  @override
  String get authWelcomeBack => 'Welcome Back!';

  @override
  String get authSubtitle =>
      'Sign in or create an account to get started right away.';

  @override
  String get authEncrypted => 'Encrypted';

  @override
  String get authRealtimeSync => 'Realtime Sync';

  @override
  String get authMultiUser => 'Multi-User';

  @override
  String get authAccountAccess => 'Account Access';

  @override
  String get authFooterNote =>
      'Registration and login are seamlessly integrated.';

  @override
  String authError(String error) {
    return 'Sign in error: $error';
  }

  @override
  String get listsOverview => 'Lists Overview';

  @override
  String get myLists => 'My Lists';

  @override
  String get allTab => 'All';

  @override
  String get ownedTab => 'Owned';

  @override
  String get sharedTab => 'Shared';

  @override
  String get searchLists => 'Search lists...';

  @override
  String get newList => 'New List';

  @override
  String get noListsFound => 'No lists found';

  @override
  String get createFirstList =>
      'Create your first ToDo list and invite team members!';

  @override
  String get deleteList => 'Delete List';

  @override
  String deleteListConfirm(String title) {
    return 'Are you sure you want to permanently delete \"$title\"?';
  }

  @override
  String get leaveList => 'Leave List';

  @override
  String leaveListConfirm(String title) {
    return 'Are you sure you want to leave \"$title\"?';
  }

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get leave => 'Leave';

  @override
  String get save => 'Save';

  @override
  String get edit => 'Edit';

  @override
  String get close => 'Close';

  @override
  String get create => 'Create';

  @override
  String get done => 'Done';

  @override
  String get tasksTitle => 'Tasks';

  @override
  String get filterAll => 'All';

  @override
  String get filterActive => 'Active';

  @override
  String get filterCompleted => 'Completed';

  @override
  String get filterHighPriority => 'High Priority';

  @override
  String get filterAssignedToMe => 'Assigned to Me';

  @override
  String get addTask => 'Add Task';

  @override
  String get editTask => 'Edit Task';

  @override
  String get taskTitle => 'What needs to be done?';

  @override
  String get taskDescription => 'Details or notes (optional)...';

  @override
  String get priority => 'Priority';

  @override
  String get priorityLow => 'Low';

  @override
  String get priorityMedium => 'Medium';

  @override
  String get priorityHigh => 'High';

  @override
  String get dueDate => 'Due Date';

  @override
  String get assignTo => 'Assign to...';

  @override
  String get nobody => 'Nobody';

  @override
  String get subtasks => 'Subtasks & Steps';

  @override
  String get addSubtask => 'Add subtask...';

  @override
  String get workTimerActive => 'Time tracking active';

  @override
  String get workTimerRecorded => 'Tracked work time';

  @override
  String timerRunningSession(String time) {
    return 'Current session: $time';
  }

  @override
  String timerTotalTime(String time) {
    return 'Total time spent: $time';
  }

  @override
  String get startTimer => 'Start';

  @override
  String get pauseTimer => 'Pause';

  @override
  String activeBadge(String time) {
    return 'Active: $time';
  }

  @override
  String usedBadge(String time) {
    return 'Spent: $time';
  }

  @override
  String completedBy(String name) {
    return 'Completed by $name';
  }

  @override
  String get dueOverdue => 'Overdue';

  @override
  String get dueToday => 'Today';

  @override
  String get dueTomorrow => 'Tomorrow';

  @override
  String get roleOwner => 'Lead / Owner';

  @override
  String get roleEditor => 'Member / Editor';

  @override
  String get roleViewer => 'Viewer (Read only)';

  @override
  String get settings => 'Settings';

  @override
  String get themeMode => 'Appearance';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeLight => 'Light';

  @override
  String get themeSystem => 'System';

  @override
  String get notifications => 'Live Sync & Notifications';

  @override
  String get notificationsDesc => 'Realtime updates for task changes and chat';

  @override
  String get clearCache => 'Clear Local Cache';

  @override
  String get clearCacheDesc => 'Cleans temporary stored data';

  @override
  String get signOut => 'Sign Out';

  @override
  String get resetPassword => 'Reset Password';

  @override
  String get profileEdit => 'Edit Profile';

  @override
  String get profileSaved => 'Profile saved successfully!';

  @override
  String get language => 'Language';

  @override
  String get languageDe => 'German (Deutsch)';

  @override
  String get languageEn => 'English';

  @override
  String get languageSystem => 'System (Default)';

  @override
  String get exportCsv => 'Export work times as CSV';

  @override
  String get exportTaskCsv => 'Export task times as CSV';

  @override
  String get copyCsv => 'Copy CSV to clipboard';

  @override
  String get downloadCsv => 'Download / share CSV file';

  @override
  String get copiedToClipboard => 'Copied to clipboard!';

  @override
  String get csvExportSuccess => 'CSV exported successfully';

  @override
  String get taskWorkTimes => 'Task Work Sessions & Time Tracking';

  @override
  String get chatTitle => 'Team Chat & Messages';

  @override
  String get chatTabTeam => 'Team Chat';

  @override
  String get chatTabPrivate => 'Private DMs';

  @override
  String get chatPlaceholder => 'Write a message...';

  @override
  String get send => 'Send';
}
