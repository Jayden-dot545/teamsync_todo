import 'dart:async';
import 'package:flutter/material.dart';
import 'package:todolist_client/todolist_client.dart';
import '../../core/constants.dart';
import '../../core/localization_helper.dart';
import '../models/subtask.dart';
import '../models/work_session.dart';
import '../todo_controller.dart';
import 'create_todo_sheet.dart';
import 'work_session_timeline.dart';

class TodoTile extends StatefulWidget {
  final TodoItem item;
  final TodoController todoController;

  const TodoTile({
    super.key,
    required this.item,
    required this.todoController,
  });

  @override
  State<TodoTile> createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  Timer? _ticker;
  bool _subtasksExpanded = false;
  bool _timelineExpanded = false;

  @override
  void initState() {
    super.initState();
    _checkTicker();
  }

  @override
  void didUpdateWidget(covariant TodoTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.item.isTimerRunning != widget.item.isTimerRunning) {
      _checkTicker();
    }
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  void _checkTicker() {
    if (widget.item.isTimerRunning == true) {
      _ticker ??= Timer.periodic(const Duration(seconds: 1), (_) {
        if (mounted) setState(() {});
      });
    } else {
      _ticker?.cancel();
      _ticker = null;
    }
  }

  void _toggleTimer() {
    if (widget.todoController.isViewer || widget.item.isCompleted) return;
    if (widget.item.isTimerRunning == true) {
      widget.todoController.pauseTaskTimer(widget.item.id!);
    } else {
      widget.todoController.startTaskTimer(widget.item.id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final isEn = context.isEn;
    final priorityColor = AppColors.getPriorityColor(item.priority);
    final isDone = item.isCompleted;
    final isViewer = widget.todoController.isViewer;
    final isRunning = item.isTimerRunning == true;
    final totalSeconds = TodoController.getElapsedSeconds(item);
    final subtasks = SubTask.decodeList(item.subtasksJson);
    final doneSubtasks = subtasks.where((s) => s.isDone).length;
    final isLight = AppColors.isLight(context);

    final tileContent = RepaintBoundary(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: isRunning
              ? (isLight ? const Color(0xFFE0F2FE) : const Color(0xFF0F2644))
              : isDone
              ? (isLight
                    ? Colors.white.withValues(alpha: 0.7)
                    : AppColors.surfaceDark.withValues(alpha: 0.5))
              : AppColors.surface(context),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isRunning
                ? (isLight ? const Color(0xFF0284C7) : AppColors.primary)
                : isDone
                ? (isLight
                      ? const Color(0xFFE2E8F0)
                      : AppColors.borderDark.withValues(alpha: 0.4))
                : AppColors.border(context),
            width: isRunning ? 1.6 : 1.2,
          ),
          boxShadow: isRunning
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(
                      alpha: isLight ? 0.2 : 0.25,
                    ),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ]
              : (isLight
                    ? const [
                        BoxShadow(
                          color: Color(0x080F172A),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ]
                    : null),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: isViewer
                  ? null
                  : () => showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (_) => CreateTodoSheet(
                        todoController: widget.todoController,
                        existingItem: item,
                      ),
                    ),
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Interactive Checkbox with Micro-Interaction Bounce
                    Tooltip(
                      message: isViewer
                          ? (isEn ? 'Viewer mode' : 'Zuschauer-Modus')
                          : isDone
                          ? (isEn ? 'Mark as open' : 'Als offen markieren')
                          : (isEn ? 'Complete task (stops timer)' : 'Abhaken (stoppt Timer)'),
                      child: GestureDetector(
                        onTap: isViewer
                            ? null
                            : () => widget.todoController.toggleComplete(item),
                        child: AnimatedScale(
                          scale: isDone ? 1.08 : 1.0,
                          duration: const Duration(milliseconds: 180),
                          curve: Curves.easeOutBack,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 220),
                            width: 26,
                            height: 26,
                            decoration: BoxDecoration(
                              color: isDone
                                  ? AppColors.priorityLow
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: isDone
                                  ? [
                                      BoxShadow(
                                        color: AppColors.priorityLow.withValues(
                                          alpha: 0.4,
                                        ),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ]
                                  : null,
                              border: Border.all(
                                color: isDone
                                    ? AppColors.priorityLow
                                    : (isLight
                                          ? const Color(0xFF94A3B8)
                                          : const Color(0xFF64748B)),
                                width: 2,
                              ),
                            ),
                            child: isDone
                                ? const Icon(
                                    Icons.check_rounded,
                                    size: 18,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),

                    // Content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: isDone
                                  ? (isLight
                                        ? const Color(0xFF94A3B8)
                                        : const Color(0xFF64748B))
                                  : (isLight ? Colors.black : Colors.white),
                              decoration: isDone
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                          if (item.description != null &&
                              item.description!.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text(
                              item.description!,
                              style: TextStyle(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w500,
                                color: isDone
                                    ? (isLight
                                          ? const Color(0xFFCBD5E1)
                                          : const Color(0xFF475569))
                                    : (isLight
                                          ? const Color(0xFF1E293B)
                                          : AppColors.textSecondary(context)),
                                decoration: isDone
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                          const SizedBox(height: 8),

                          // Badges row
                          Wrap(
                            spacing: 8,
                            runSpacing: 4,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              // Priority Pill
                              _buildBadge(
                                color: priorityColor,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 6,
                                      height: 6,
                                      decoration: BoxDecoration(
                                        color: priorityColor,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      AppColors.getPriorityLabel(item.priority, isEn: isEn),
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: priorityColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Subtasks Progress Badge
                              if (subtasks.isNotEmpty)
                                InkWell(
                                  onTap: () => setState(
                                    () =>
                                        _subtasksExpanded = !_subtasksExpanded,
                                  ),
                                  borderRadius: BorderRadius.circular(6),
                                  child: _buildBadge(
                                    color: doneSubtasks == subtasks.length
                                        ? const Color(0xFF10B981)
                                        : const Color(0xFF6366F1),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.check_box_outlined,
                                          size: 11,
                                          color: doneSubtasks == subtasks.length
                                              ? const Color(0xFF10B981)
                                              : const Color(0xFF6366F1),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          '$doneSubtasks/${subtasks.length}',
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                            color:
                                                doneSubtasks == subtasks.length
                                                ? const Color(0xFF10B981)
                                                : const Color(0xFF6366F1),
                                          ),
                                        ),
                                        const SizedBox(width: 2),
                                        Icon(
                                          _subtasksExpanded
                                              ? Icons.keyboard_arrow_up_rounded
                                              : Icons
                                                    .keyboard_arrow_down_rounded,
                                          size: 12,
                                          color: AppColors.textSecondary(
                                            context,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                              // Due Date Badge
                              if (item.dueDate != null)
                                _buildDueDateBadge(item.dueDate!, isEn),

                              // Recurrence Badge
                              if (item.recurrence != null &&
                                  item.recurrence!.isNotEmpty)
                                _buildBadge(
                                  color: const Color(0xFF6366F1),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.repeat_rounded,
                                        size: 11,
                                        color: Color(0xFF6366F1),
                                      ),
                                      const SizedBox(width: 3),
                                      Text(
                                        _getRecurrenceLabel(item.recurrence!, isEn),
                                        style: const TextStyle(
                                          fontSize: 10.5,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF6366F1),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                              // Work Timer Badge
                              _buildWorkTimerBadge(
                                isRunning: isRunning,
                                isDone: isDone,
                                totalSeconds: totalSeconds,
                                sessionCount: WorkSession.decodeList(
                                  item.workSessionsJson,
                                ).length,
                                isEn: isEn,
                              ),

                              // Assignee Badge
                              if (item.assignedToName != null &&
                                  item.assignedToName!.isNotEmpty)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.surfaceLight(context),
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      color: AppColors.border(context),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.person_outline_rounded,
                                        size: 12,
                                        color: AppColors.textSecondary(context),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        item.assignedToName!,
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: AppColors.textSecondary(
                                            context,
                                          ),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                              // Completed info
                              if (isDone && item.completedByName != null)
                                _buildBadge(
                                  color: AppColors.priorityLow,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.check_circle_outline_rounded,
                                        size: 11,
                                        color: AppColors.priorityLow,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        isEn
                                            ? 'Completed by ${item.completedByName}'
                                            : 'Erledigt von ${item.completedByName}',
                                        style: const TextStyle(
                                          fontSize: 10.5,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.priorityLow,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Timer Play/Pause Action Button
                    if (!isViewer && !isDone)
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: IconButton(
                          onPressed: _toggleTimer,
                          icon: Icon(
                            isRunning
                                ? Icons.pause_circle_filled_rounded
                                : Icons.play_circle_fill_rounded,
                            size: 28,
                            color: isRunning
                                ? (isLight
                                      ? const Color(0xFF0284C7)
                                      : AppColors.primary)
                                : AppColors.textSecondary(context),
                          ),
                          tooltip: isRunning
                              ? (isEn ? 'Pause timer' : 'Timer pausieren')
                              : (isEn ? 'Start timer' : 'Timer starten'),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // Expandable Subtasks Checklist
            if (_subtasksExpanded && subtasks.isNotEmpty)
              Container(
                margin: const EdgeInsets.only(left: 48, right: 16, bottom: 12),
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight(context),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppColors.border(context).withValues(alpha: 0.5),
                  ),
                ),
                child: Column(
                  children: subtasks.map((st) {
                    return InkWell(
                      onTap: isViewer
                          ? null
                          : () => widget.todoController.toggleSubtask(
                              item: item,
                              subtaskId: st.id,
                            ),
                      borderRadius: BorderRadius.circular(6),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 4,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              st.isDone
                                  ? Icons.check_box_rounded
                                  : Icons.check_box_outline_blank_rounded,
                              size: 17,
                              color: st.isDone
                                  ? const Color(0xFF10B981)
                                  : AppColors.textSecondary(context),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                st.title,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: st.isDone
                                      ? (isLight
                                            ? const Color(0xFF94A3B8)
                                            : const Color(0xFF64748B))
                                      : AppColors.text(context),
                                  decoration: st.isDone
                                      ? TextDecoration.lineThrough
                                      : null,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

            // Expandable Work Session Timeline
            if (_timelineExpanded)
              Padding(
                padding: const EdgeInsets.only(
                  left: 48,
                  right: 16,
                  bottom: 12,
                  top: 4,
                ),
                child: WorkSessionTimeline(item: item, isCompact: true),
              ),
          ],
        ),
      ),
    );

    if (isViewer) return tileContent;

    return Dismissible(
      key: ValueKey(item.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: AppColors.priorityHigh.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(
          Icons.delete_outline,
          color: AppColors.priorityHigh,
          size: 24,
        ),
      ),
      onDismissed: (_) => widget.todoController.deleteItem(item.id!),
      child: tileContent,
    );
  }

  Widget _buildBadge({required Color color, required Widget child}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: child,
    );
  }

  Widget _buildWorkTimerBadge({
    required bool isRunning,
    required bool isDone,
    required int totalSeconds,
    required int sessionCount,
    required bool isEn,
  }) {
    if (totalSeconds <= 0 && !isRunning && sessionCount == 0) {
      return const SizedBox.shrink();
    }

    final formattedText = isRunning
        ? TodoController.formatDigitalTime(totalSeconds)
        : TodoController.formatDuration(totalSeconds);

    final isLight = AppColors.isLight(context);
    final badgeColor = isRunning
        ? (isLight ? const Color(0xFF0284C7) : AppColors.primary)
        : isDone
        ? const Color(0xFF10B981)
        : (isLight ? const Color(0xFF0284C7) : const Color(0xFF38BDF8));

    final prefix = isRunning
        ? (isEn ? 'Active: ' : 'Aktiv: ')
        : (isEn ? 'Spent: ' : 'Gebraucht: ');

    return InkWell(
      onTap: () => setState(() => _timelineExpanded = !_timelineExpanded),
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: badgeColor.withValues(alpha: isRunning ? 0.22 : 0.14),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: badgeColor.withValues(alpha: isRunning ? 0.7 : 0.35),
            width: isRunning ? 1.2 : 1.0,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isRunning ? Icons.timer_rounded : Icons.schedule_rounded,
              size: 11,
              color: badgeColor,
            ),
            const SizedBox(width: 4),
            Text(
              '$prefix$formattedText',
              style: TextStyle(
                fontSize: 11,
                fontWeight: isRunning ? FontWeight.bold : FontWeight.w600,
                color: badgeColor,
              ),
            ),
            const SizedBox(width: 3),
            Icon(
              _timelineExpanded
                  ? Icons.keyboard_arrow_up_rounded
                  : Icons.keyboard_arrow_down_rounded,
              size: 12,
              color: badgeColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDueDateBadge(DateTime date, bool isEn) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final target = DateTime(date.year, date.month, date.day);
    final diff = target.difference(today).inDays;
    final isLight = AppColors.isLight(context);

    final (badgeColor, label) = switch (diff) {
      < 0 => (AppColors.priorityHigh, isEn ? 'Overdue' : 'Überfällig'),
      0 => (AppColors.priorityMedium, isEn ? 'Today' : 'Heute'),
      1 => (isLight ? const Color(0xFF0284C7) : AppColors.primary, isEn ? 'Tomorrow' : 'Morgen'),
      _ => (
        AppColors.textSecondary(context),
        '${date.day}.${date.month}.${date.year}',
      ),
    };

    return _buildBadge(
      color: badgeColor,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.calendar_today_rounded, size: 11, color: badgeColor),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: badgeColor,
            ),
          ),
        ],
      ),
    );
  }

  String _getRecurrenceLabel(String recurrence, bool isEn) => switch (recurrence) {
    'daily' => isEn ? 'Daily' : 'Täglich',
    'workdays' => isEn ? 'Weekdays' : 'Werktags',
    'weekly' => isEn ? 'Weekly' : 'Wöchentlich',
    'monthly' => isEn ? 'Monthly' : 'Monatlich',
    _ => isEn ? 'Recurring' : 'Serie',
  };
}
