import 'package:flutter/material.dart';
import 'package:todolist_client/todolist_client.dart';
import '../../core/constants.dart';
import '../../core/localization_helper.dart';
import '../todo_controller.dart';
import 'create_todo_sheet.dart';

class EisenhowerMatrixView extends StatelessWidget {
  final TodoController todoController;
  final List<TodoItem> items;
  final bool isViewer;

  const EisenhowerMatrixView({
    super.key,
    required this.todoController,
    required this.items,
    required this.isViewer,
  });

  bool _isUrgent(TodoItem item) {
    if (item.dueDate == null) return false;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day, 23, 59, 59);
    return item.dueDate!.isBefore(today);
  }

  bool _isImportant(TodoItem item) {
    return item.priority == TodoPriority.high || item.priority == TodoPriority.medium;
  }

  @override
  Widget build(BuildContext context) {
    final isLight = AppColors.isLight(context);
    final isEn = context.isEn;

    // Categorize tasks into 4 quadrants
    final q1DoFirst = <TodoItem>[]; // Urgent & Important
    final q2Schedule = <TodoItem>[]; // Not Urgent & Important
    final q3Delegate = <TodoItem>[]; // Urgent & Not Important
    final q4Eliminate = <TodoItem>[]; // Not Urgent & Not Important

    for (final item in items) {
      if (item.isCompleted) continue; // Show active items in matrix
      final urgent = _isUrgent(item);
      final important = _isImportant(item);

      if (urgent && important) {
        q1DoFirst.add(item);
      } else if (!urgent && important) {
        q2Schedule.add(item);
      } else if (urgent && !important) {
        q3Delegate.add(item);
      } else {
        q4Eliminate.add(item);
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          // Top Row: Q1 (Do First) & Q2 (Schedule)
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: _buildQuadrant(
                    context,
                    title: isEn ? '1. Do First' : '1. Sofort erledigen',
                    subtitle: isEn ? 'Urgent & Important' : 'Dringend & Wichtig',
                    icon: Icons.local_fire_department_rounded,
                    accentColor: AppColors.priorityHigh,
                    items: q1DoFirst,
                    isLight: isLight,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildQuadrant(
                    context,
                    title: isEn ? '2. Schedule' : '2. Planen & Terminieren',
                    subtitle: isEn ? 'Important, Not Urgent' : 'Wichtig, nicht dringend',
                    icon: Icons.event_note_rounded,
                    accentColor: const Color(0xFF0284C7),
                    items: q2Schedule,
                    isLight: isLight,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Bottom Row: Q3 (Delegate) & Q4 (Eliminate / Later)
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: _buildQuadrant(
                    context,
                    title: isEn ? '3. Delegate / Quick' : '3. Delegieren / Schnell',
                    subtitle: isEn ? 'Urgent, Low Priority' : 'Dringend, wenig Prio',
                    icon: Icons.groups_rounded,
                    accentColor: const Color(0xFFF59E0B),
                    items: q3Delegate,
                    isLight: isLight,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildQuadrant(
                    context,
                    title: isEn ? '4. Later / Optional' : '4. Später / Optional',
                    subtitle: isEn ? 'Neither Urgent Nor Important' : 'Weder dringend noch wichtig',
                    icon: Icons.inventory_2_outlined,
                    accentColor: const Color(0xFF10B981),
                    items: q4Eliminate,
                    isLight: isLight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuadrant(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color accentColor,
    required List<TodoItem> items,
    required bool isLight,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface(context),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: accentColor.withValues(alpha: isLight ? 0.35 : 0.45),
          width: 1.3,
        ),
        boxShadow: [
          BoxShadow(
            color: accentColor.withValues(alpha: isLight ? 0.06 : 0.12),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quadrant Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: accentColor.withValues(alpha: isLight ? 0.12 : 0.18),
                border: Border(
                  bottom: BorderSide(
                    color: accentColor.withValues(alpha: 0.25),
                  ),
                ),
              ),
              child: Row(
                children: [
                  Icon(icon, size: 16, color: accentColor),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: AppColors.text(context),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 9.5,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textSecondary(context),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: accentColor.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${items.length}',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: accentColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Quadrant Task List
            Expanded(
              child: items.isEmpty
                  ? Center(
                      child: Text(
                        context.isEn ? 'No tasks' : 'Keine Aufgaben',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.textSecondary(context).withValues(alpha: 0.6),
                        ),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.all(8),
                      itemCount: items.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 6),
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return _buildMiniTaskCard(context, item, accentColor);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMiniTaskCard(BuildContext context, TodoItem item, Color accentColor) {
    final isLight = AppColors.isLight(context);

    return InkWell(
      onTap: isViewer
          ? null
          : () => showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (_) => CreateTodoSheet(
                todoController: todoController,
                existingItem: item,
              ),
            ),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight(context),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.borderSubtle(context)),
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: isViewer ? null : () => todoController.toggleComplete(item),
              child: Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: isLight ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                    width: 1.5,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                item.title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.text(context),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (item.assignedToName != null && item.assignedToName!.isNotEmpty)
              Container(
                margin: const EdgeInsets.only(left: 4),
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                decoration: BoxDecoration(
                  color: AppColors.surface(context),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  item.assignedToName!.substring(0, 1).toUpperCase(),
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textSecondary(context),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
