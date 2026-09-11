import 'package:flutter/material.dart';
import '../../core/client.dart';
import '../../core/constants.dart';
import '../../core/localization_helper.dart';
import '../models/subtask.dart';
import '../models/work_session.dart';
import '../todo_controller.dart';
import 'create_todo_sheet.dart';

class KanbanBoardView extends StatelessWidget {
  final TodoController todoController;
  final List<TodoItem> items;
  final bool isViewer;

  const KanbanBoardView({
    super.key,
    required this.todoController,
    required this.items,
    required this.isViewer,
  });

  @override
  Widget build(BuildContext context) {
    final isEn = context.isEn;
    final openItems = items
        .where((i) => !i.isCompleted && i.isTimerRunning != true)
        .toList();
    final inProgressItems = items
        .where((i) => i.isTimerRunning == true)
        .toList();
    final completedItems = items.where((i) => i.isCompleted).toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        final columnWidth = (constraints.maxWidth > 900)
            ? (constraints.maxWidth - 48) / 3
            : 290.0;
        return ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          children: [
            _buildColumn(
              context,
              title: isEn ? 'To Do' : 'Zu erledigen',
              emoji: '📋',
              color: const Color(0xFF0284C7),
              items: openItems,
              width: columnWidth,
              statusKey: 'open',
            ),
            const SizedBox(width: 12),
            _buildColumn(
              context,
              title: isEn ? 'In Progress' : 'In Bearbeitung',
              emoji: '⏱️',
              color: const Color(0xFFF59E0B),
              items: inProgressItems,
              width: columnWidth,
              statusKey: 'progress',
            ),
            const SizedBox(width: 12),
            _buildColumn(
              context,
              title: isEn ? 'Done' : 'Erledigt',
              emoji: '✅',
              color: AppColors.priorityLow,
              items: completedItems,
              width: columnWidth,
              statusKey: 'done',
            ),
          ],
        );
      },
    );
  }

  Widget _buildColumn(
    BuildContext context, {
    required String title,
    required String emoji,
    required Color color,
    required List<TodoItem> items,
    required double width,
    required String statusKey,
  }) {
    final isLight = AppColors.isLight(context);

    return DragTarget<TodoItem>(
      onWillAcceptWithDetails: (details) => !isViewer,
      onAcceptWithDetails: (details) => _handleDrop(details.data, statusKey),
      builder: (context, candidateData, rejectedData) {
        final isHovered = candidateData.isNotEmpty;
        return Container(
          width: width,
          decoration: BoxDecoration(
            color: isHovered
                ? color.withValues(alpha: isLight ? 0.12 : 0.18)
                : (isLight ? const Color(0xFFF8FAFC) : AppColors.surfaceDark),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isHovered
                  ? color
                  : (isLight ? const Color(0xFFE2E8F0) : AppColors.borderDark),
              width: isHovered ? 2 : 1,
            ),
          ),
          child: Column(
            children: [
              // Column Header
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Text(emoji, style: const TextStyle(fontSize: 16)),
                    const SizedBox(width: 8),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isLight ? const Color(0xFF0F172A) : Colors.white,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${items.length}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),

              // Items List
              Expanded(
                child: items.isEmpty
                    ? Center(
                        child: Text(
                          context.isEn ? 'No tasks' : 'Keine Aufgaben',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary(context),
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(10),
                        itemCount: items.length,
                        itemBuilder: (context, index) =>
                            _buildCard(context, items[index]),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCard(BuildContext context, TodoItem item) {
    final isLight = AppColors.isLight(context);
    final priorityColor = AppColors.getPriorityColor(item.priority);
    final subtasks = SubTask.decodeList(item.subtasksJson);
    final completedSubtasks = subtasks.where((s) => s.isDone).length;

    final cardContent = RepaintBoundary(
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.surface(context),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: item.isTimerRunning == true
                ? const Color(0xFF0284C7)
                : (isLight ? const Color(0xFFE2E8F0) : AppColors.borderDark),
            width: item.isTimerRunning == true ? 1.5 : 1,
          ),
          boxShadow: isLight
              ? const [
                  BoxShadow(
                    color: Color(0x080F172A),
                    blurRadius: 4,
                    offset: Offset(0, 1),
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Badges row
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: priorityColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    AppColors.getPriorityLabel(item.priority, isEn: context.isEn),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: priorityColor,
                    ),
                  ),
                ),
                const Spacer(),
                if (item.isTimerRunning == true)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0284C7).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.timer_rounded,
                          size: 10,
                          color: Color(0xFF0284C7),
                        ),
                        const SizedBox(width: 3),
                        Text(
                          context.isEn ? 'Active' : 'Aktiv',
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0284C7),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),

            // Title
            Text(
              item.title,
              style: TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
                decoration: item.isCompleted
                    ? TextDecoration.lineThrough
                    : null,
                color: item.isCompleted
                    ? AppColors.textSecondary(context)
                    : AppColors.text(context),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            if (item.description != null &&
                item.description!.trim().isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                item.description!,
                style: TextStyle(
                  fontSize: 11.5,
                  color: AppColors.textSecondary(context),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            const SizedBox(height: 8),

            // Subtasks
            if (subtasks.isNotEmpty) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: completedSubtasks / subtasks.length,
                  minHeight: 4,
                  backgroundColor: AppColors.border(context),
                  valueColor: AlwaysStoppedAnimation(
                    completedSubtasks == subtasks.length
                        ? AppColors.priorityLow
                        : AppColors.secondary,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    Icons.checklist_rounded,
                    size: 12,
                    color: AppColors.textSecondary(context),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    context.isEn
                        ? '$completedSubtasks of ${subtasks.length}'
                        : '$completedSubtasks von ${subtasks.length}',
                    style: TextStyle(
                      fontSize: 10.5,
                      color: AppColors.textSecondary(context),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
            ],

            // Footer
            Row(
              children: [
                if (item.assignedToName != null &&
                    item.assignedToName!.isNotEmpty) ...[
                  Icon(
                    Icons.person_outline_rounded,
                    size: 12,
                    color: AppColors.textSecondary(context),
                  ),
                  const SizedBox(width: 3),
                  Expanded(
                    child: Text(
                      item.assignedToName!,
                      style: TextStyle(
                        fontSize: 10.5,
                        color: AppColors.textSecondary(context),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ] else ...[
                  const Spacer(),
                ],
                if ((item.totalDurationSeconds ?? 0) > 0) ...[
                  Icon(
                    Icons.schedule_rounded,
                    size: 11,
                    color: AppColors.textSecondary(context),
                  ),
                  const SizedBox(width: 3),
                  Text(
                    WorkSession.formatDuration(item.totalDurationSeconds ?? 0),
                    style: TextStyle(
                      fontSize: 10.5,
                      color: AppColors.textSecondary(context),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );

    if (isViewer) {
      return InkWell(
        onTap: () => _openDetail(context, item),
        borderRadius: BorderRadius.circular(12),
        child: cardContent,
      );
    }

    return LongPressDraggable<TodoItem>(
      data: item,
      feedback: Material(
        color: Colors.transparent,
        child: SizedBox(width: 260, child: cardContent),
      ),
      childWhenDragging: Opacity(opacity: 0.35, child: cardContent),
      child: InkWell(
        onTap: () => _openDetail(context, item),
        borderRadius: BorderRadius.circular(12),
        child: cardContent,
      ),
    );
  }

  void _handleDrop(TodoItem item, String statusKey) {
    switch (statusKey) {
      case 'open':
        if (item.isTimerRunning == true) {
          todoController.pauseTaskTimer(item.id!);
        }
        if (item.isCompleted) {
          todoController.toggleComplete(item);
        }
        break;
      case 'progress':
        if (item.isCompleted) {
          todoController.toggleComplete(item);
        }
        if (item.isTimerRunning != true) {
          todoController.startTaskTimer(item.id!);
        }
        break;
      case 'done':
        if (item.isTimerRunning == true) {
          todoController.pauseTaskTimer(item.id!);
        }
        if (!item.isCompleted) {
          todoController.toggleComplete(item);
        }
        break;
    }
  }

  void _openDetail(BuildContext context, TodoItem item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) =>
          CreateTodoSheet(todoController: todoController, existingItem: item),
    );
  }
}
