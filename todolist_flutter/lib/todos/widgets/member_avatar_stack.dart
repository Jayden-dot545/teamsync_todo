import 'package:flutter/material.dart';
import 'package:todolist_client/todolist_client.dart';
import '../../core/constants.dart';
import '../../core/localization_helper.dart';

class MemberAvatarStack extends StatelessWidget {
  final List<TodoListMember> members;
  final VoidCallback onAddMember;
  final ValueChanged<TodoListMember>? onMemberTap;

  const MemberAvatarStack({
    super.key,
    required this.members,
    required this.onAddMember,
    this.onMemberTap,
  });

  @override
  Widget build(BuildContext context) {
    const maxVisible = 4;
    final visibleMembers = members.take(maxVisible).toList();
    final remaining = members.length - visibleMembers.length;
    final isEn = context.isEn;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 36,
          width: (visibleMembers.length * 26.0) + (remaining > 0 ? 30 : 10),
          child: Stack(
            children: [
              for (var i = 0; i < visibleMembers.length; i++)
                Positioned(
                  left: i * 24.0,
                  child: Tooltip(
                    message:
                        '${visibleMembers[i].userName ?? visibleMembers[i].userEmail} (${AppColors.getRoleLabel(visibleMembers[i].role, isEn: isEn)}) • ${isEn ? "Tap for profile" : "Tippen für Profil"}',
                    child: GestureDetector(
                      onTap: () {
                        if (onMemberTap != null) {
                          onMemberTap!(visibleMembers[i]);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.backgroundDark,
                            width: 2,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: Color(
                            AppColors.listColors[i %
                                AppColors.listColors.length],
                          ).withValues(alpha: 0.25),
                          child:
                              visibleMembers[i].userAvatar != null &&
                                  visibleMembers[i].userAvatar!.isNotEmpty
                              ? Text(
                                  visibleMembers[i].userAvatar!,
                                  style: const TextStyle(fontSize: 14),
                                )
                              : Text(
                                  (visibleMembers[i].userName ??
                                          visibleMembers[i].userEmail ??
                                          'U')
                                      .substring(0, 1)
                                      .toUpperCase(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
              if (remaining > 0)
                Positioned(
                  left: visibleMembers.length * 24.0,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.backgroundDark,
                        width: 2,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: const Color(0xFF334155),
                      child: Text(
                        '+$remaining',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(width: 4),
        IconButton(
          tooltip: isEn ? 'Invite members' : 'Mitglieder einladen',
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          icon: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.15),
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.3),
              ),
            ),
            child: const Icon(
              Icons.add_rounded,
              color: AppColors.primary,
              size: 16,
            ),
          ),
          onPressed: onAddMember,
        ),
      ],
    );
  }
}
