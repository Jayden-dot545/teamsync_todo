import 'package:flutter/material.dart';
import '../../core/constants.dart';
import '../../core/localization_helper.dart';
import '../list_controller.dart';
import '../../todos/todo_list_screen.dart';

class ListSwitcherSheet extends StatelessWidget {
  final ListController listController;
  final int currentListId;

  const ListSwitcherSheet({
    super.key,
    required this.listController,
    required this.currentListId,
  });

  @override
  Widget build(BuildContext context) {
    final currentUserId = listController.currentUserId;
    final lists = listController.lists;
    final isLight = AppColors.isLight(context);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface(context),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border.all(color: AppColors.border(context), width: 1.2),
      ),
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag Handle
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: isLight ? const Color(0xFFCBD5E1) : Colors.white24,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.isEn ? 'Your Lists & Roles' : 'Deine Listen & Rollen',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.text(context),
                ),
              ),
              Text(
                context.isEn
                    ? '${lists.length} ${lists.length == 1 ? "list" : "lists"}'
                    : '${lists.length} ${lists.length == 1 ? "Liste" : "Listen"}',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary(context),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Lists
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.5,
            ),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: lists.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final list = lists[index];
                final isCurrent = list.id == currentListId;
                final isOwner =
                    currentUserId != null && list.ownerId == currentUserId;
                final listColor = Color(list.color);

                return Material(
                  color: isCurrent
                      ? (isLight
                            ? AppColors.primary.withValues(alpha: 0.12)
                            : AppColors.surfaceLightDark)
                      : AppColors.surfaceLight(context),
                  borderRadius: BorderRadius.circular(14),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: () {
                      Navigator.of(context).pop();
                      if (!isCurrent) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => TodoListScreen(
                              todoList: list,
                              listController: listController,
                            ),
                          ),
                        );
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isCurrent
                              ? AppColors.primary
                              : AppColors.border(context),
                          width: isCurrent ? 1.5 : 1.0,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: listColor,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: listColor.withValues(alpha: 0.5),
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  list.title,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: isCurrent
                                        ? FontWeight.bold
                                        : FontWeight.w600,
                                    color: AppColors.text(context),
                                  ),
                                ),
                                if (list.description != null &&
                                    list.description!.isNotEmpty)
                                  Text(
                                    list.description!,
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
                          const SizedBox(width: 8),

                          // Role Badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  (isOwner
                                          ? const Color(0xFFF59E0B)
                                          : AppColors.primary)
                                      .withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              isOwner
                                  ? (context.isEn ? '👑 Lead' : '👑 Chef')
                                  : (context.isEn ? '✏️ Member' : '✏️ Mitglied'),
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: isOwner
                                    ? const Color(0xFFF59E0B)
                                    : (isLight
                                          ? AppColors.primaryDark
                                          : AppColors.primary),
                              ),
                            ),
                          ),

                          if (isCurrent) ...[
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.check_circle_rounded,
                              size: 18,
                              color: AppColors.primary,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
