import 'package:flutter/material.dart';
import '../../core/client.dart';
import '../../core/constants.dart';
import '../../core/localization_helper.dart';
import '../../core/user_prefs.dart';
import '../list_controller.dart';

class HeroStatsBanner extends StatelessWidget {
  final ListController listController;

  const HeroStatsBanner({
    super.key,
    required this.listController,
  });

  String _getGreeting(bool isEn) {
    final hour = DateTime.now().hour;
    if (isEn) {
      if (hour < 12) return 'Good Morning';
      if (hour < 18) return 'Good Afternoon';
      if (hour < 22) return 'Good Evening';
      return 'Good Night';
    } else {
      if (hour < 11) return 'Guten Morgen';
      if (hour < 17) return 'Guten Tag';
      if (hour < 22) return 'Guten Abend';
      return 'Gute Nacht';
    }
  }

  String _getFormattedDate(bool isEn) {
    final now = DateTime.now();
    if (isEn) {
      final weekdays = [
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
        'Saturday',
        'Sunday'
      ];
      final months = [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December'
      ];
      return '${weekdays[now.weekday - 1]}, ${months[now.month - 1]} ${now.day}';
    } else {
      final weekdays = [
        'Montag',
        'Dienstag',
        'Mittwoch',
        'Donnerstag',
        'Freitag',
        'Samstag',
        'Sonntag'
      ];
      final months = [
        'Januar',
        'Februar',
        'März',
        'April',
        'Mai',
        'Juni',
        'Juli',
        'August',
        'September',
        'Oktober',
        'November',
        'Dezember'
      ];
      return '${weekdays[now.weekday - 1]}, ${now.day}. ${months[now.month - 1]}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEn = context.l10n.localeName.startsWith('en');
    final isLight = AppColors.isLight(context);
    final greeting = _getGreeting(isEn);
    final dateStr = _getFormattedDate(isEn);
    final totalLists = listController.lists.length;
    final currentUserId = client.auth.authInfo?.authUserId;
    final ownedLists =
        listController.lists.where((l) => l.ownerId == currentUserId).length;
    final sharedLists = totalLists - ownedLists;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isLight
              ? [
                  const Color(0xFFEEF2FF),
                  const Color(0xFFF8FAFC),
                  const Color(0xFFF0FDF4),
                ]
              : [
                  const Color(0xFF1E1B4B).withValues(alpha: 0.7),
                  const Color(0xFF0F172A).withValues(alpha: 0.85),
                  const Color(0xFF064E3B).withValues(alpha: 0.5),
                ],
        ),
        border: Border.all(
          color: isLight
              ? const Color(0xFF6366F1).withValues(alpha: 0.18)
              : const Color(0xFF6366F1).withValues(alpha: 0.35),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color:
                const Color(0xFF6366F1).withValues(alpha: isLight ? 0.08 : 0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // Ambient Decorative Circles
            Positioned(
              top: -30,
              right: -20,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(
                    0xFF6366F1,
                  ).withValues(alpha: isLight ? 0.12 : 0.18),
                ),
              ),
            ),
            Positioned(
              bottom: -40,
              left: 40,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(
                    0xFF10B981,
                  ).withValues(alpha: isLight ? 0.1 : 0.15),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date & Live Status Pill
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: isLight
                              ? Colors.white.withValues(alpha: 0.8)
                              : Colors.white.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.borderSubtle(context),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.calendar_today_rounded,
                              size: 13,
                              color: Color(0xFF6366F1),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              dateStr,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.text(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color:
                              const Color(0xFF10B981).withValues(alpha: 0.14),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color:
                                const Color(0xFF10B981).withValues(alpha: 0.3),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.wifi_tethering_rounded,
                              size: 12,
                              color: Color(0xFF10B981),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              isEn ? 'Live Sync' : 'Live Sync',
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF10B981),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Greeting Title & Name
                  ValueListenableBuilder<String?>(
                    valueListenable: UserPrefs.displayNameNotifier,
                    builder: (context, name, _) {
                      final effectiveName =
                          (name != null && name.trim().isNotEmpty)
                              ? name.trim()
                              : (isEn ? 'Team Member' : 'Team-Mitglied');
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$greeting, $effectiveName! 👋',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -0.5,
                              color: AppColors.text(context),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            isEn
                                ? 'Organize your day & achieve goals with ease.'
                                : 'Organisiere deinen Tag & erreiche deine Ziele mit Leichtigkeit.',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary(context),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 18),

                  // Quick Stats Row
                  Row(
                    children: [
                      Expanded(
                        child: _StatCard(
                          icon: Icons.checklist_rtl_rounded,
                          iconColor: const Color(0xFF6366F1),
                          label: isEn ? 'Total Lists' : 'Listen gesamt',
                          value: '$totalLists',
                          isLight: isLight,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _StatCard(
                          icon: Icons.person_outline_rounded,
                          iconColor: const Color(0xFF0284C7),
                          label: isEn ? 'My Lists' : 'Eigene Listen',
                          value: '$ownedLists',
                          isLight: isLight,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _StatCard(
                          icon: Icons.groups_outlined,
                          iconColor: const Color(0xFF10B981),
                          label: isEn ? 'Shared in Team' : 'Geteilt im Team',
                          value: '$sharedLists',
                          isLight: isLight,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  final bool isLight;

  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    required this.isLight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: isLight
            ? Colors.white.withValues(alpha: 0.9)
            : AppColors.surface(context).withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: iconColor.withValues(alpha: isLight ? 0.2 : 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 15, color: iconColor),
              const Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.text(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary(context),
            ),
          ),
        ],
      ),
    );
  }
}
