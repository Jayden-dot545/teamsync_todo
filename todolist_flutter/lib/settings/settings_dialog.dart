import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../auth/widgets/user_profile_dialog.dart';
import '../core/client.dart';
import '../core/constants.dart';
import '../core/localization_helper.dart';
import '../core/user_prefs.dart';
import '../lists/list_controller.dart';

class SettingsDialog extends StatefulWidget {
  final ListController? listController;

  const SettingsDialog({super.key, this.listController});

  @override
  State<SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  ThemeMode _currentTheme = UserPrefs.themeModeNotifier.value;
  Locale? _currentLocale = UserPrefs.localeNotifier.value;
  bool _notifications = UserPrefs.notificationsEnabledNotifier.value;
  bool _isResettingPassword = false;

  Future<void> _updateTheme(ThemeMode mode) async {
    setState(() => _currentTheme = mode);
    await UserPrefs.setThemeMode(mode);
  }

  Future<void> _updateLocale(Locale? locale) async {
    setState(() => _currentLocale = locale);
    await UserPrefs.setLocale(locale);
  }

  Future<void> _toggleNotifications(bool enabled) async {
    setState(() => _notifications = enabled);
    await UserPrefs.setNotificationsEnabled(enabled);
  }

  Future<void> _clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_cached_items');
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.surface(context),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: AppColors.border(context)),
          ),
          content: Row(
            children: [
              const Icon(
                Icons.check_circle_rounded,
                color: AppColors.priorityLow,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                context.isEn
                    ? 'Local cache cleared successfully!'
                    : 'Lokaler Cache erfolgreich bereinigt!',
                style: TextStyle(color: AppColors.text(context)),
              ),
            ],
          ),
        ),
      );
    }
  }

  Future<void> _requestPasswordReset() async {
    final emailController = TextEditingController();
    final isEn = context.isEn;
    final sent = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surface(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: AppColors.border(context)),
        ),
        title: Row(
          children: [
            const Icon(Icons.lock_reset_rounded, color: AppColors.primary),
            const SizedBox(width: 10),
            Text(
              isEn ? 'Reset Password' : 'Passwort zurücksetzen',
              style: TextStyle(color: AppColors.text(context), fontSize: 18),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isEn
                  ? 'Enter your registered email address. We will send you a security code to reset your password.'
                  : 'Gib deine registrierte E-Mail-Adresse ein. Wir senden dir einen Sicherheits-Code zum Zurücksetzen deines Passworts.',
              style: TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary(context),
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: AppColors.text(context)),
              decoration: InputDecoration(
                hintText: isEn ? 'name@example.com' : 'name@beispiel.de',
                prefixIcon: const Icon(Icons.email_outlined),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(
              context.l10n.cancel,
              style: TextStyle(color: AppColors.textSecondary(context)),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(isEn ? 'Send code' : 'Code senden'),
          ),
        ],
      ),
    );

    if (sent == true && emailController.text.trim().isNotEmpty && mounted) {
      setState(() => _isResettingPassword = true);
      try {
        await client.emailIdp.startPasswordReset(
          email: emailController.text.trim(),
        );
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                context.isEn
                    ? 'Security code sent to ${emailController.text.trim()}!'
                    : 'Sicherheits-Code an ${emailController.text.trim()} versendet!',
              ),
              backgroundColor: AppColors.priorityLow,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                context.isEn ? 'Error sending code: $e' : 'Fehler beim Senden: $e',
              ),
              backgroundColor: AppColors.priorityHigh,
            ),
          );
        }
      } finally {
        if (mounted) setState(() => _isResettingPassword = false);
      }
    }
  }

  Future<void> _logout() async {
    final isEn = context.isEn;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surface(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(color: AppColors.border(context)),
        ),
        title: Text(
          isEn ? 'Sign out?' : 'Abmelden?',
          style: TextStyle(color: AppColors.text(context)),
        ),
        content: Text(
          isEn
              ? 'Do you really want to sign out?'
              : 'Möchtest du dich wirklich abmelden?',
          style: TextStyle(color: AppColors.textSecondary(context)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(
              context.l10n.cancel,
              style: TextStyle(color: AppColors.textSecondary(context)),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.priorityHigh,
            ),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(
              context.l10n.signOut,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );

    if (confirm == true && mounted) {
      Navigator.of(context).pop();
      await client.auth.signOutDevice();
    }
  }

  @override
  Widget build(BuildContext context) {
    final userName = UserPrefs.displayNameNotifier.value ?? 'Team-Mitglied';
    final userBio = UserPrefs.bioNotifier.value ?? '';
    final avatarIdx = UserPrefs.avatarIndexNotifier.value;
    final avatar = avatarIdx < UserPrefs.avatarEmojis.length
        ? UserPrefs.avatarEmojis[avatarIdx]
        : '👑';

    return Dialog(
      backgroundColor: AppColors.surface(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(color: AppColors.border(context), width: 1.2),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520, maxHeight: 680),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.border(context)),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.settings_suggest_rounded,
                      color: AppColors.primary,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.l10n.settings,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.text(context),
                          ),
                        ),
                        Text(
                          context.l10n.notificationsDesc,
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close_rounded,
                      color: AppColors.textSecondary(context),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),

            // Settings Body
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(24),
                children: [
                  // Profile Card
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceLight(context),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.border(context)),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: AppColors.primary.withValues(
                            alpha: 0.25,
                          ),
                          child: Text(
                            avatar,
                            style: const TextStyle(fontSize: 24),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userName,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.text(context),
                                ),
                              ),
                              Text(
                                userBio,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textSecondary(context),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () => showDialog(
                            context: context,
                            builder: (_) => UserProfileDialog(
                              listController: widget.listController,
                            ),
                          ),
                          child: Text(context.l10n.profileEdit),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 1. Theme
                  _buildSectionHeader(
                    context.l10n.themeMode.toUpperCase(),
                    Icons.palette_outlined,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _buildThemeOption(
                        context.l10n.themeDark,
                        Icons.dark_mode_rounded,
                        _currentTheme == ThemeMode.dark,
                        () => _updateTheme(ThemeMode.dark),
                      ),
                      const SizedBox(width: 8),
                      _buildThemeOption(
                        context.l10n.themeLight,
                        Icons.light_mode_rounded,
                        _currentTheme == ThemeMode.light,
                        () => _updateTheme(ThemeMode.light),
                      ),
                      const SizedBox(width: 8),
                      _buildThemeOption(
                        context.l10n.themeSystem,
                        Icons.settings_brightness_rounded,
                        _currentTheme == ThemeMode.system,
                        () => _updateTheme(ThemeMode.system),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // 2. Language / Sprache
                  _buildSectionHeader(
                    context.l10n.language.toUpperCase(),
                    Icons.language_rounded,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _buildThemeOption(
                        context.l10n.languageDe,
                        Icons.translate_rounded,
                        _currentLocale?.languageCode == 'de',
                        () => _updateLocale(const Locale('de')),
                      ),
                      const SizedBox(width: 8),
                      _buildThemeOption(
                        context.l10n.languageEn,
                        Icons.language_rounded,
                        _currentLocale?.languageCode == 'en',
                        () => _updateLocale(const Locale('en')),
                      ),
                      const SizedBox(width: 8),
                      _buildThemeOption(
                        context.l10n.languageSystem,
                        Icons.auto_awesome_rounded,
                        _currentLocale == null,
                        () => _updateLocale(null),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // 3. Notifications
                  _buildSectionHeader(
                    context.l10n.notifications.toUpperCase(),
                    Icons.notifications_none_rounded,
                  ),
                  const SizedBox(height: 10),
                  SwitchListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: AppColors.border(context)),
                    ),
                    tileColor: AppColors.surfaceLight(context),
                    title: Text(
                      context.l10n.notifications,
                      style: TextStyle(
                        color: AppColors.text(context),
                        fontSize: 14,
                      ),
                    ),
                    subtitle: Text(
                      context.l10n.notificationsDesc,
                      style: TextStyle(
                        color: AppColors.textSecondary(context),
                        fontSize: 11,
                      ),
                    ),
                    value: _notifications,
                    activeThumbColor: AppColors.primary,
                    onChanged: _toggleNotifications,
                  ),
                  const SizedBox(height: 24),

                  // 4. Security
                  _buildSectionHeader(
                    context.isEn ? 'ACCOUNT & SECURITY' : 'KONTO & SICHERHEIT',
                    Icons.security_rounded,
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: AppColors.border(context)),
                    ),
                    tileColor: AppColors.surfaceLight(context),
                    leading: const Icon(
                      Icons.lock_reset_rounded,
                      color: AppColors.primary,
                    ),
                    title: Text(
                      context.l10n.resetPassword,
                      style: TextStyle(
                        color: AppColors.text(context),
                        fontSize: 14,
                      ),
                    ),
                    subtitle: Text(
                      context.isEn
                          ? 'Request security code via email'
                          : 'Sicherheits-Code per E-Mail anfordern',
                      style: const TextStyle(
                        color: Color(0xFF94A3B8),
                        fontSize: 11,
                      ),
                    ),
                    trailing: _isResettingPassword
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 14,
                            color: AppColors.textSecondary(context),
                          ),
                    onTap: _isResettingPassword ? null : _requestPasswordReset,
                  ),
                  const SizedBox(height: 10),

                  ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: AppColors.border(context)),
                    ),
                    tileColor: AppColors.surfaceLight(context),
                    leading: Icon(
                      Icons.cleaning_services_rounded,
                      color: AppColors.textSecondary(context),
                    ),
                    title: Text(
                      context.l10n.clearCache,
                      style: TextStyle(
                        color: AppColors.text(context),
                        fontSize: 14,
                      ),
                    ),
                    subtitle: Text(
                      context.l10n.clearCacheDesc,
                      style: TextStyle(
                        color: AppColors.textSecondary(context),
                        fontSize: 11,
                      ),
                    ),
                    trailing: Icon(
                      Icons.chevron_right_rounded,
                      color: AppColors.textSecondary(context),
                    ),
                    onTap: _clearCache,
                  ),
                  const SizedBox(height: 24),

                  // 5. App Info
                  Center(
                    child: Column(
                      children: [
                        Text(
                          '${context.l10n.appTitle} • Version 1.2.0',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textSecondary(context),
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'Powered by Serverpod 4.x & Flutter Material 3',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Logout
                  OutlinedButton.icon(
                    onPressed: _logout,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.priorityHigh,
                      side: BorderSide(
                        color: AppColors.priorityHigh.withValues(alpha: 0.5),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.logout_rounded, size: 18),
                    label: Text(
                      context.l10n.signOut,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 14, color: AppColors.primary),
        const SizedBox(width: 6),
        Text(
          title,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.8,
            color: AppColors.textSecondary(context),
          ),
        ),
      ],
    );
  }

  Widget _buildThemeOption(
    String title,
    IconData icon,
    bool isSelected,
    VoidCallback onTap,
  ) {
    final isLight = AppColors.isLight(context);
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primary.withValues(alpha: isLight ? 0.15 : 0.22)
                : AppColors.surfaceLight(context),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.border(context),
              width: isSelected ? 1.8 : 1.0,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                size: 22,
                color: isSelected
                    ? AppColors.primary
                    : AppColors.textSecondary(context),
              ),
              const SizedBox(height: 6),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected
                      ? (isLight ? AppColors.primaryDark : Colors.white)
                      : AppColors.textSecondary(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
