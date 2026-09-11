import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../core/localization_helper.dart';
import '../core/user_prefs.dart';
import '../core/widgets/app_background.dart';
import '../core/widgets/team_sync_logo.dart';
import 'auth_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  // Track which feature card is currently expanded
  int? _expandedIndex;

  void _navigateToAuth(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const AuthScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 0.08);
          const end = Offset.zero;
          const curve = Curves.easeOutCubic;

          final slideTween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));
          final fadeTween = Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).chain(CurveTween(curve: Curves.easeOut));

          return SlideTransition(
            position: animation.drive(slideTween),
            child: FadeTransition(
              opacity: animation.drive(fadeTween),
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 450),
      ),
    );
  }

  void _toggleExpand(int index) {
    setState(() {
      if (_expandedIndex == index) {
        _expandedIndex = null; // collapse
      } else {
        _expandedIndex = index; // expand
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLight = AppColors.isLight(context);

    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              tooltip: isLight
                  ? (context.isEn ? 'Switch to Dark Mode' : 'Dunkelmodus aktivieren')
                  : (context.isEn ? 'Switch to Light Mode' : 'Hellmodus aktivieren'),
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.surface(context),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border(context)),
                ),
                child: Icon(
                  isLight ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                  color: isLight
                      ? const Color(0xFF0F172A)
                      : const Color(0xFFF59E0B),
                  size: 18,
                ),
              ),
              onPressed: () {
                final newMode = isLight ? ThemeMode.dark : ThemeMode.light;
                UserPrefs.setThemeMode(newMode);
              },
            ),
            const SizedBox(width: 12),
          ],
        ),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 16,
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 540),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Hero Glowing Nexus App Logo
                    const Hero(
                      tag: 'app_logo_hero',
                      child: TeamSyncLogo(size: 64),
                    ),
                    const SizedBox(height: 24),

                    // Dynamic Personalized Greeting Headline
                    ValueListenableBuilder<String?>(
                      valueListenable: UserPrefs.displayNameNotifier,
                      builder: (context, userName, _) {
                        final hasName =
                            userName != null && userName.trim().isNotEmpty;

                        return Column(
                          children: [
                            Text(
                              hasName
                                  ? (context.isEn
                                      ? 'Welcome back,\n${userName.trim()}!'
                                      : 'Willkommen zurück,\n${userName.trim()}!')
                                  : (context.isEn
                                      ? 'Welcome to\nTeamSync ToDo'
                                      : 'Willkommen bei\nTeamSync ToDo'),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: AppColors.text(context),
                                letterSpacing: -0.5,
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              hasName
                                  ? (context.isEn
                                      ? 'Ready for your next productive day? Tap cards for details.'
                                      : 'Bereit für deinen nächsten produktiven Tag? Tippe auf die Kacheln für Details.')
                                  : (context.isEn
                                      ? 'Organize your tasks, share lists with your team, and collaborate in real-time.'
                                      : 'Organisiere deine Aufgaben, teile Listen mit deinem Team und arbeite in Echtzeit zusammen.'),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14.5,
                                color: AppColors.textSecondary(context),
                                fontWeight: FontWeight.w400,
                                height: 1.5,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 32),

                    // Expandable Feature Cards (Accordion)
                    _buildExpandableCard(
                      index: 0,
                      icon: Icons.bolt_rounded,
                      color: isLight
                          ? const Color(0xFF0284C7)
                          : AppColors.primary,
                      title: context.isEn ? 'Live Synchronization' : 'Live-Synchronisation',
                      shortDesc: context.isEn
                          ? 'Changes and completed tasks appear instantly for all team members.'
                          : 'Änderungen und abgehakte Aufgaben erscheinen sofort bei allen Teammitgliedern.',
                      detailedDesc: context.isEn
                          ? 'Task changes, status switches, and notes are streamed via WebSockets to all active viewers in milliseconds.'
                          : 'Veränderungen an Aufgaben, Statuswechsel und Notizen werden über WebSockets in Millisekunden an alle aktiven Betrachter übertragen.',
                      bullets: context.isEn
                          ? const [
                              '⚡ Instant updates without manual refresh',
                              '⏱️ Automatic timestamp and user tracking',
                              '🔄 Optimistic UI: Checkboxes respond with zero latency',
                            ]
                          : const [
                              '⚡ Sofortige Updates ohne manuelles Neuladen',
                              '⏱️ Automatische Speicherung von Zeitstempel & Bearbeiter',
                              '🔄 Optimistic UI: Checkboxen reagieren ohne jede Latenz',
                            ],
                    ),
                    const SizedBox(height: 12),

                    _buildExpandableCard(
                      index: 1,
                      icon: Icons.group_rounded,
                      color: AppColors.secondary,
                      title: context.isEn ? 'Shared Lists & Viewers' : 'Gemeinsame Listen & Zuschauer',
                      shortDesc: context.isEn
                          ? 'Invite teammates or track live progress as a supervisor.'
                          : 'Lade Kollegen ein oder verfolge als Zuschauer den Live-Fortschritt.',
                      detailedDesc: context.isEn
                          ? 'Collaborate within your team or observe progress in read-only mode.'
                          : 'Arbeite im Team oder behalte den Überblick als Beobachter (z. B. Praktikanten im Home-Office oder Familien-Aufgaben).',
                      bullets: context.isEn
                          ? const [
                              '👑 Owner: Full control over lists & members',
                              '✍️ Editor: Create, edit & complete tasks',
                              '👁️ Viewer: Perfect for supervisors – live progress without write access',
                            ]
                          : const [
                              '👑 Besitzer: Volle Kontrolle über Listen & Mitglieder',
                              '✍️ Bearbeiter: Kann Aufgaben anlegen & abhaken',
                              '👁️ Zuschauer: Perfekt für Betreuer/Leads – sieht Fortschritt & Erledigungen live, ohne Schreibzugriff',
                            ],
                    ),
                    const SizedBox(height: 12),

                    _buildExpandableCard(
                      index: 2,
                      icon: Icons.flag_rounded,
                      color: AppColors.priorityHigh,
                      title: context.isEn ? 'Priorities & Due Dates' : 'Prioritäten & Fälligkeit',
                      shortDesc: context.isEn
                          ? 'Keep urgent deadlines and important to-dos in focus.'
                          : 'Behalte wichtige Deadlines und dringende ToDos immer im Fokus.',
                      detailedDesc: context.isEn
                          ? 'Structure your schedule with clear due dates, priority labels, and smart filters.'
                          : 'Strukturiere deinen Tag mit klaren Fälligkeitsdaten, Prioritäts-Kennzeichnungen und intelligenten Filtern.',
                      bullets: context.isEn
                          ? const [
                              '🟢🟡🔴 3 Priority levels: Low, Medium, High',
                              '📅 Smart Due Badges (Overdue, Today, Tomorrow)',
                              '🔍 Quick Filters: Open, Done, High Priority, My Tasks',
                            ]
                          : const [
                              '🟢🟡🔴 3 Prioritätsstufen: Niedrig, Mittel, Hoch',
                              '📅 Intelligente Fälligkeits-Badges (Überfällig, Heute, Morgen)',
                              '🔍 Schnelle Filter: Offen, Erledigt, Hohe Prio, Meine Tasks',
                            ],
                    ),
                    const SizedBox(height: 36),

                    // Action Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => _navigateToAuth(context),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shadowColor: AppColors.primary.withValues(
                            alpha: 0.4,
                          ),
                          elevation: 8,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              context.isEn ? 'Get Started' : 'Jetzt starten',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.arrow_forward_rounded, size: 20),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExpandableCard({
    required int index,
    required IconData icon,
    required Color color,
    required String title,
    required String shortDesc,
    required String detailedDesc,
    required List<String> bullets,
  }) {
    final isExpanded = _expandedIndex == index;
    final isLight = AppColors.isLight(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
      decoration: BoxDecoration(
        color: isExpanded
            ? (isLight ? const Color(0xFFF1F5F9) : const Color(0xFF16233B))
            : AppColors.surface(context),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isExpanded
              ? color.withValues(alpha: 0.85)
              : AppColors.border(context),
          width: isExpanded ? 1.6 : 1.2,
        ),
        boxShadow: isExpanded
            ? [
                BoxShadow(
                  color: color.withValues(alpha: isLight ? 0.12 : 0.18),
                  blurRadius: 18,
                  offset: const Offset(0, 4),
                ),
              ]
            : (isLight
                  ? [
                      BoxShadow(
                        color: const Color(0x060F172A),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : []),
      ),
      child: InkWell(
        onTap: () => _toggleExpand(index),
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: color.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Icon(icon, color: color, size: 22),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.text(context),
                            letterSpacing: -0.2,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          shortDesc,
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary(context),
                            fontWeight: FontWeight.w400,
                            height: 1.35,
                          ),
                          maxLines: isExpanded ? 3 : 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOutCubic,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: isExpanded
                            ? color.withValues(alpha: 0.2)
                            : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: isExpanded
                            ? color
                            : AppColors.textSecondary(context),
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),

              // Smoothly animated details section for both expanding & collapsing
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOutCubic,
                alignment: Alignment.topCenter,
                child: isExpanded
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 14),
                          Container(
                            height: 1,
                            color: AppColors.border(context),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            detailedDesc,
                            style: TextStyle(
                              fontSize: 13.5,
                              color: AppColors.text(context),
                              fontWeight: FontWeight.w400,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 12),
                          ...bullets.map(
                            (bullet) => Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      bullet,
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: AppColors.textSecondary(context),
                                        fontWeight: FontWeight.w500,
                                        height: 1.4,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
