import 'package:flutter/material.dart';
import 'package:todolist_client/todolist_client.dart';
import '../../core/constants.dart';
import '../../core/localization_helper.dart';
import '../list_controller.dart';
import 'create_list_dialog.dart';
import 'invite_member_dialog.dart';

class ListCard extends StatelessWidget {
  final TodoList todoList;
  final ListController listController;
  final VoidCallback onTap;

  const ListCard({
    super.key,
    required this.todoList,
    required this.listController,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final listColor = Color(todoList.color);
    final hasDescription =
        todoList.description != null && todoList.description!.trim().isNotEmpty;
    final isLight = AppColors.isLight(context);

    return RepaintBoundary(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.cardBg(context),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isLight
                  ? AppColors.borderSubtle(context)
                  : listColor.withValues(alpha: 0.28),
              width: 1.3,
            ),
            boxShadow: [
              BoxShadow(
                color: listColor.withValues(alpha: isLight ? 0.08 : 0.14),
                blurRadius: 14,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                // Subtle Ambient Color Glow in Top Right Corner
                Positioned(
                  top: -20,
                  right: -20,
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          listColor.withValues(alpha: isLight ? 0.15 : 0.22),
                          listColor.withValues(alpha: 0.0),
                        ],
                      ),
                    ),
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Top Color Accent Bar with subtle gradient
                    Container(
                      height: 5,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            listColor,
                            listColor.withValues(alpha: 0.6),
                          ],
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 13,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Header: Icon Badge + Title + Popup Menu
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: listColor.withValues(alpha: 0.16),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: listColor.withValues(alpha: 0.35),
                                  ),
                                ),
                                child: Icon(
                                  Icons.format_list_bulleted_rounded,
                                  color: listColor,
                                  size: 18,
                                ),
                              ),
                              const SizedBox(width: 11),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      todoList.title,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.text(context),
                                        letterSpacing: -0.2,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    if (hasDescription) ...[
                                      const SizedBox(height: 3),
                                      Text(
                                        todoList.description!.trim(),
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.textSecondary(
                                            context,
                                          ),
                                          height: 1.25,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                              PopupMenuButton<String>(
                                icon: Icon(
                                  Icons.more_vert_rounded,
                                  color: AppColors.textSecondary(context),
                                  size: 18,
                                ),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                color: AppColors.surface(context),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  side: BorderSide(
                                    color: AppColors.border(context),
                                  ),
                                ),
                                onSelected: (action) {
                                  if (action == 'edit') {
                                    showDialog(
                                      context: context,
                                      builder: (_) => CreateListDialog(
                                        listController: listController,
                                        existingList: todoList,
                                      ),
                                    );
                                  } else if (action == 'invite') {
                                    showDialog(
                                      context: context,
                                      builder: (_) => InviteMemberDialog(
                                        listController: listController,
                                        todoList: todoList,
                                      ),
                                    );
                                  } else if (action == 'delete') {
                                    _confirmDelete(context);
                                  }
                                },
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    value: 'edit',
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.edit_outlined,
                                          size: 18,
                                          color: AppColors.text(context),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          context.l10n.edit,
                                          style: TextStyle(
                                            color: AppColors.text(context),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: 'invite',
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.person_add_outlined,
                                          size: 18,
                                          color: AppColors.text(context),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          context.isEn
                                              ? 'Members'
                                              : 'Mitglieder',
                                          style: TextStyle(
                                            color: AppColors.text(context),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const PopupMenuDivider(),
                                  PopupMenuItem(
                                    value: 'delete',
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.delete_outline,
                                          size: 18,
                                          color: AppColors.priorityHigh,
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          context.l10n.delete,
                                          style: const TextStyle(
                                            color: AppColors.priorityHigh,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          // Footer: Sync Badge + Arrow Indicator
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 9,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.surfaceLight(context),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: AppColors.borderSubtle(context),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 6,
                                      height: 6,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: listColor,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      'Team-Sync',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textSecondary(
                                          context,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: listColor.withValues(alpha: 0.12),
                                ),
                                child: Icon(
                                  Icons.arrow_forward_rounded,
                                  size: 14,
                                  color: listColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.surface(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: AppColors.border(context)),
        ),
        title: Text(
          context.l10n.deleteList,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.text(context),
          ),
        ),
        content: Text(
          context.l10n.deleteListConfirm(todoList.title),
          style: TextStyle(color: AppColors.textSecondary(context)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              context.l10n.cancel,
              style: TextStyle(color: AppColors.textSecondary(context)),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.priorityHigh,
            ),
            onPressed: () async {
              Navigator.of(context).pop();
              await listController.deleteList(todoList.id!);
            },
            child: Text(
              context.l10n.delete,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
