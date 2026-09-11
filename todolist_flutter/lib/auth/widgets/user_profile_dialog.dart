import 'package:flutter/material.dart';
import '../../core/client.dart';
import '../../core/constants.dart';
import '../../core/localization_helper.dart';
import '../../core/user_prefs.dart';
import '../../lists/list_controller.dart';

class AvatarThemePreset {
  final String name;
  final List<Color> colors;
  final IconData icon;

  const AvatarThemePreset({
    required this.name,
    required this.colors,
    required this.icon,
  });
}

class UserProfileDialog extends StatefulWidget {
  final ListController? listController;

  const UserProfileDialog({super.key, this.listController});

  @override
  State<UserProfileDialog> createState() => _UserProfileDialogState();
}

class _UserProfileDialogState extends State<UserProfileDialog> {
  late final TextEditingController _nameController;
  late final TextEditingController _bioController;
  late int _selectedThemeIndex;
  late String _selectedStatus;
  bool _useInitials = true;
  bool _isSaving = false;

  static const List<AvatarThemePreset> _presets = [
    AvatarThemePreset(
      name: 'Sky Blue',
      colors: [Color(0xFF0284C7), Color(0xFF38BDF8)],
      icon: Icons.shield_outlined,
    ),
    AvatarThemePreset(
      name: 'Royal Indigo',
      colors: [Color(0xFF4F46E5), Color(0xFF818CF8)],
      icon: Icons.rocket_launch_outlined,
    ),
    AvatarThemePreset(
      name: 'Emerald Mint',
      colors: [Color(0xFF059669), Color(0xFF34D399)],
      icon: Icons.bolt_outlined,
    ),
    AvatarThemePreset(
      name: 'Amber Gold',
      colors: [Color(0xFFD97706), Color(0xFFFBBF24)],
      icon: Icons.workspace_premium_outlined,
    ),
    AvatarThemePreset(
      name: 'Rose Coral',
      colors: [Color(0xFFE11D48), Color(0xFFFB7185)],
      icon: Icons.auto_awesome_outlined,
    ),
    AvatarThemePreset(
      name: 'Slate Quartz',
      colors: [Color(0xFF334155), Color(0xFF64748B)],
      icon: Icons.terminal_outlined,
    ),
    AvatarThemePreset(
      name: 'Violet Iris',
      colors: [Color(0xFF7C3AED), Color(0xFFA78BFA)],
      icon: Icons.radar_outlined,
    ),
    AvatarThemePreset(
      name: 'Cyber Cyan',
      colors: [Color(0xFF0891B2), Color(0xFF22D3EE)],
      icon: Icons.code_rounded,
    ),
  ];

  static const List<String> _professionalStatusesDe = [
    '👑 Teamleitung & Projekt-Lead',
    '💻 Entwicklung & Umsetzung',
    '📊 Aufgaben- & Prozessmanagement',
    '🔍 Review & Qualitätssicherung',
    '🎯 Fokus & Deep Work',
    '⚡ Sprint-Koordination',
  ];

  static const List<String> _professionalStatusesEn = [
    '👑 Team Lead & Project Lead',
    '💻 Software Development & Execution',
    '📊 Task & Process Management',
    '🔍 Review & Quality Assurance',
    '🎯 Focus & Deep Work',
    '⚡ Sprint Coordination',
  ];

  List<String> get _currentStatuses =>
      context.isEn ? _professionalStatusesEn : _professionalStatusesDe;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: UserPrefs.displayNameNotifier.value ?? '',
    );
    _bioController = TextEditingController(
      text: UserPrefs.bioNotifier.value ?? '',
    );
    _selectedThemeIndex = UserPrefs.avatarIndexNotifier.value.clamp(
      0,
      _presets.length - 1,
    );
    final curStatus = UserPrefs.statusNotifier.value;
    _selectedStatus = curStatus.isNotEmpty
        ? curStatus
        : _professionalStatusesDe.first;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  String _getInitials(String name) {
    final clean = name.trim();
    if (clean.isEmpty) return 'U';
    final parts = clean.split(' ').where((p) => p.isNotEmpty).toList();
    if (parts.length > 1) return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    return clean.substring(0, clean.length >= 2 ? 2 : 1).toUpperCase();
  }

  Future<void> _save() async {
    setState(() => _isSaving = true);
    await UserPrefs.setDisplayName(_nameController.text.trim());
    await UserPrefs.setBio(_bioController.text.trim());
    await UserPrefs.setAvatarIndex(_selectedThemeIndex);
    await UserPrefs.setStatus(_selectedStatus);
    await UserPrefs.syncProfileToServer();

    if (mounted) {
      setState(() => _isSaving = false);
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.surface(context),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: AppColors.border(context), width: 1.2),
          ),
          content: Row(
            children: [
              const Icon(
                Icons.check_circle_rounded,
                color: AppColors.priorityLow,
              ),
              const SizedBox(width: 10),
              Text(
                context.isEn
                    ? 'Profile saved successfully!'
                    : 'Profil erfolgreich gespeichert!',
                style: TextStyle(
                  color: AppColors.text(context),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authUser = client.auth.authInfo;
    final currentUserId = authUser?.authUserId;
    final totalLists = widget.listController?.lists.length ?? 0;
    final ownedCount =
        widget.listController?.lists
            .where((l) => l.ownerId == currentUserId)
            .length ??
        0;
    final sharedCount = totalLists - ownedCount;

    final isEn = context.isEn;
    final preset = _presets[_selectedThemeIndex];
    final previewName = _nameController.text.trim().isNotEmpty
        ? _nameController.text.trim()
        : (UserPrefs.displayNameNotifier.value ?? (isEn ? 'User' : 'Benutzer'));
    final isLight = AppColors.isLight(context);

    return Dialog(
      backgroundColor: AppColors.surface(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: AppColors.border(context), width: 1.2),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480, maxHeight: 700),
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.manage_accounts_outlined,
                      color: isLight
                          ? const Color(0xFF0284C7)
                          : AppColors.primary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isEn ? 'User Profile' : 'Benutzerprofil',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.text(context),
                          ),
                        ),
                        Text(
                          isEn
                              ? 'Identity, role & accent color in team'
                              : 'Identität, Rolle & Farbakzent im Team',
                          style: TextStyle(
                            fontSize: 11,
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
                      size: 20,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: AppColors.border(context)),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Avatar Showcase Card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceLight(context),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.border(context)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: preset.colors,
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              border: Border.all(color: Colors.white, width: 2),
                              boxShadow: [
                                BoxShadow(
                                  color: preset.colors.first.withValues(
                                    alpha: 0.35,
                                  ),
                                  blurRadius: 12,
                                ),
                              ],
                            ),
                            child: Center(
                              child: _useInitials
                                  ? Text(
                                      _getInitials(previewName),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    )
                                  : Icon(
                                      preset.icon,
                                      size: 28,
                                      color: Colors.white,
                                    ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  previewName,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.text(context),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: preset.colors.first.withValues(
                                      alpha: 0.15,
                                    ),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    _selectedStatus,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: preset.colors.first,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Theme Picker
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          isEn ? 'COLOR ACCENT & PROFILE STYLE' : 'FARBAKZENT & PROFILSTIL',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.8,
                            color: AppColors.textSecondary(context),
                          ),
                        ),
                        InkWell(
                          onTap: () =>
                              setState(() => _useInitials = !_useInitials),
                          borderRadius: BorderRadius.circular(6),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            child: Text(
                              _useInitials
                                  ? (isEn ? 'Mode: Initials' : 'Modus: Initialen')
                                  : (isEn ? 'Mode: Icon' : 'Modus: Icon'),
                              style: TextStyle(
                                fontSize: 11,
                                color: isLight
                                    ? const Color(0xFF0284C7)
                                    : AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 44,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _presets.length,
                        separatorBuilder: (_, _) => const SizedBox(width: 8),
                        itemBuilder: (context, index) {
                          final p = _presets[index];
                          final isSelected = _selectedThemeIndex == index;
                          return GestureDetector(
                            onTap: () =>
                                setState(() => _selectedThemeIndex = index),
                            child: Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(colors: p.colors),
                                border: Border.all(
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.transparent,
                                  width: isSelected ? 2.5 : 1,
                                ),
                              ),
                              child: isSelected
                                  ? const Icon(
                                      Icons.check_rounded,
                                      color: Colors.white,
                                      size: 18,
                                    )
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Inputs
                    Text(
                      isEn ? 'Name / Display Name' : 'Name / Anzeigename',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.text(context),
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      controller: _nameController,
                      style: TextStyle(
                        color: AppColors.text(context),
                        fontSize: 13.5,
                      ),
                      onChanged: (_) => setState(() {}),
                      decoration: InputDecoration(
                        hintText: isEn ? 'e.g. Alexander Miller' : 'z. B. Alexander Müller',
                        prefixIcon: const Icon(
                          Icons.person_outline_rounded,
                          size: 18,
                        ),
                        isDense: true,
                      ),
                    ),
                    const SizedBox(height: 14),

                    Text(
                      isEn ? 'Work Focus / Bio' : 'Arbeitsfokus / Bio',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.text(context),
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      controller: _bioController,
                      maxLines: 2,
                      style: TextStyle(
                        color: AppColors.text(context),
                        fontSize: 13,
                      ),
                      decoration: InputDecoration(
                        hintText: isEn
                            ? 'e.g. Lead Sprint Q3, Fullstack development...'
                            : 'z. B. Leitung Sprint Q3, Fullstack Entwicklung...',
                        prefixIcon: const Icon(Icons.description_outlined, size: 18),
                        isDense: true,
                      ),
                    ),
                    const SizedBox(height: 14),

                    Text(
                      isEn ? 'Role & Area of Responsibility' : 'Rolle & Tätigkeitsbereich',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.text(context),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceLight(context),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.border(context)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _currentStatuses.contains(_selectedStatus)
                              ? _selectedStatus
                              : _currentStatuses.first,
                          isExpanded: true,
                          dropdownColor: AppColors.surface(context),
                          items: _currentStatuses
                              .map(
                                (s) => DropdownMenuItem(
                                  value: s,
                                  child: Text(
                                    s,
                                    style: TextStyle(
                                      color: AppColors.text(context),
                                      fontSize: 12.5,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (val) => val != null
                              ? setState(() => _selectedStatus = val)
                              : null,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Quick Stats
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceLight(context),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.border(context)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            isEn
                                ? '📁 $ownedCount Personal Lists'
                                : '📁 $ownedCount Eigene Listen',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.text(context),
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 16,
                            color: AppColors.border(context),
                          ),
                          Text(
                            isEn
                                ? '👥 $sharedCount Team Lists'
                                : '👥 $sharedCount Team-Listen',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.text(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Footer
            Divider(height: 1, color: AppColors.border(context)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _isSaving
                        ? null
                        : () => Navigator.of(context).pop(),
                    child: Text(
                      context.l10n.cancel,
                      style: TextStyle(color: AppColors.textSecondary(context)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: _isSaving ? null : _save,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: preset.colors.first,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    icon: _isSaving
                        ? const SizedBox(
                            width: 14,
                            height: 14,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.save_outlined, size: 16),
                    label: Text(
                      isEn ? 'Save' : 'Speichern',
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
}
