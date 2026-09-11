import 'package:flutter/material.dart';
import 'package:todolist_client/todolist_client.dart';
import '../constants.dart';
import '../localization_helper.dart';

class RoleSelectionCard extends StatelessWidget {
  final MemberRole role;
  final MemberRole selectedRole;
  final ValueChanged<MemberRole> onSelected;

  const RoleSelectionCard({
    super.key,
    required this.role,
    required this.selectedRole,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedRole == role;
    final isWorker = role == MemberRole.editor;
    final isLight = AppColors.isLight(context);

    final color = isWorker ? AppColors.secondary : AppColors.viewerColor;
    final icon = isWorker ? Icons.edit_note_rounded : Icons.visibility_rounded;
    final title = isWorker
        ? (context.isEn ? '✍️ Editor (Active)' : '✍️ Arbeiter (Aktiv)')
        : (context.isEn
              ? '👁️ Viewer (Home-Office / Supervisor)'
              : '👁️ Zuschauer (Home-Office / Supervisor)');
    final description = isWorker
        ? (context.isEn
              ? 'Can create, edit, and mark tasks as done.'
              : 'Kann Aufgaben anlegen, bearbeiten und als erledigt abhaken.')
        : (context.isEn
              ? 'Can view progress and completed tasks live in read-only mode.'
              : 'Sieht den Fortschritt & Erledigungen live, hat reine Leserechte.');

    return Container(
      decoration: BoxDecoration(
        color: isSelected
            ? color.withValues(alpha: isLight ? 0.12 : 0.15)
            : AppColors.surfaceLight(context),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? color : AppColors.border(context),
          width: isSelected ? 1.8 : 1.0,
        ),
      ),
      child: InkWell(
        onTap: () => onSelected(role),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: isSelected ? color : AppColors.textSecondary(context),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isSelected
                            ? (isLight ? color : Colors.white)
                            : AppColors.text(context),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary(context),
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                Icon(Icons.check_circle_rounded, color: color, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}
