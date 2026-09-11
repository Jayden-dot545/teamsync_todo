import 'package:flutter/material.dart';
import '../../core/constants.dart';
import '../../core/localization_helper.dart';
import '../../core/user_prefs.dart';
import '../../core/widgets/team_sync_logo.dart';

class NameSetupDialog extends StatefulWidget {
  final VoidCallback? onNameSaved;

  const NameSetupDialog({super.key, this.onNameSaved});

  @override
  State<NameSetupDialog> createState() => _NameSetupDialogState();
}

class _NameSetupDialogState extends State<NameSetupDialog> {
  late final TextEditingController _nameController;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: UserPrefs.displayNameNotifier.value ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;

    setState(() => _isSaving = true);
    await UserPrefs.setDisplayName(name);

    if (mounted) {
      widget.onNameSaved?.call();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.surface(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(color: AppColors.border(context)),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 440),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon Header
              const TeamSyncLogo(
                size: 38,
                showGlow: false,
              ),
              const SizedBox(height: 18),

              Text(
                context.isEn ? 'What is your name?' : 'Wie heißt du?',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.text(context),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                context.isEn
                    ? 'Enter your name so your team members and collaborators recognize you.'
                    : 'Gib deinen Namen ein, damit dich deine Teammitglieder und Kollaborateure wiedererkennen.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary(context),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 22),

              TextField(
                controller: _nameController,
                autofocus: true,
                textCapitalization: TextCapitalization.words,
                style: TextStyle(
                  color: AppColors.text(context),
                  fontWeight: FontWeight.w500,
                ),
                onSubmitted: (_) => _save(),
                decoration: InputDecoration(
                  hintText: context.isEn
                      ? 'e.g. Alex Johnson, Sarah, Dad...'
                      : 'z. B. Max Mustermann, Sarah, Mama...',
                  hintStyle: TextStyle(color: AppColors.textSecondary(context)),
                  prefixIcon: const Icon(
                    Icons.person_outline_rounded,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSaving ? null : _save,
                  child: _isSaving
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          context.isEn
                              ? 'Save & Continue'
                              : 'Speichern & Fortfahren',
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
