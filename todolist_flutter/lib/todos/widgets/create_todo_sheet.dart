import 'package:flutter/material.dart';
import 'package:todolist_client/todolist_client.dart';
import '../../core/constants.dart';
import '../../core/localization_helper.dart';
import '../models/subtask.dart';
import '../todo_controller.dart';
import 'work_session_timeline.dart';

class CreateTodoSheet extends StatefulWidget {
  final TodoController todoController;
  final TodoItem? existingItem;

  const CreateTodoSheet({
    super.key,
    required this.todoController,
    this.existingItem,
  });

  @override
  State<CreateTodoSheet> createState() => _CreateTodoSheetState();
}

class _CreateTodoSheetState extends State<CreateTodoSheet> {
  late final TextEditingController _titleController;
  late final TextEditingController _descController;
  late final TextEditingController _subtaskInputController;
  late TodoPriority _priority;
  DateTime? _dueDate;
  TodoListMember? _selectedAssignee;
  String? _recurrence;
  late List<SubTask> _subtasks;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    final item = widget.existingItem;
    _titleController = TextEditingController(text: item?.title ?? '');
    _descController = TextEditingController(text: item?.description ?? '');
    _subtaskInputController = TextEditingController();
    _priority = item?.priority ?? TodoPriority.medium;
    _dueDate = item?.dueDate;
    _recurrence = item?.recurrence;
    _subtasks = SubTask.decodeList(item?.subtasksJson);

    if (item?.assignedToUserId != null) {
      _selectedAssignee = widget.todoController.members
          .where((m) => m.userId == item!.assignedToUserId)
          .firstOrNull;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _subtaskInputController.dispose();
    super.dispose();
  }

  void _addSubtask() {
    final text = _subtaskInputController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _subtasks.add(
        SubTask(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: text,
        ),
      );
      _subtaskInputController.clear();
    });
  }

  Future<void> _pickDueDate() async {
    final now = DateTime.now();
    final isLight = AppColors.isLight(context);
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? now,
      firstDate: now.subtract(const Duration(days: 365)),
      lastDate: now.add(const Duration(days: 365 * 5)),
      builder: (context, child) => Theme(
        data: isLight
            ? ThemeData.light().copyWith(
                colorScheme: const ColorScheme.light(
                  primary: Color(0xFF0284C7),
                  surface: Colors.white,
                  onSurface: Color(0xFF0F172A),
                ),
              )
            : ThemeData.dark().copyWith(
                colorScheme: const ColorScheme.dark(
                  primary: AppColors.primary,
                  surface: AppColors.surfaceDark,
                  onSurface: Colors.white,
                ),
              ),
        child: child!,
      ),
    );

    if (picked != null) setState(() => _dueDate = picked);
  }

  Future<void> _submit() async {
    final title = _titleController.text.trim();
    if (title.isEmpty) return;

    setState(() => _isSubmitting = true);
    final desc = _descController.text.trim();
    final subtasksJson = SubTask.encodeList(_subtasks);

    try {
      if (widget.existingItem != null) {
        await widget.todoController.updateItem(
          itemId: widget.existingItem!.id!,
          title: title,
          description: desc.isEmpty ? null : desc,
          priority: _priority,
          dueDate: _dueDate,
          assignedToUserId: _selectedAssignee?.userId,
          recurrence: _recurrence,
          subtasksJson: subtasksJson,
        );
      } else {
        await widget.todoController.createItem(
          title: title,
          description: desc.isEmpty ? null : desc,
          priority: _priority,
          dueDate: _dueDate,
          assignedToUserId: _selectedAssignee?.userId,
          recurrence: _recurrence,
          subtasksJson: subtasksJson,
        );
      }
      if (mounted) Navigator.of(context).pop();
    } catch (_) {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.existingItem != null;
    final members = widget.todoController.members;
    final isLight = AppColors.isLight(context);

    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface(context),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isEditing
                      ? (context.isEn ? 'Edit task' : 'Aufgabe bearbeiten')
                      : (context.isEn ? 'Create new task' : 'Neue Aufgabe erstellen'),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.text(context),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () => Navigator.of(context).pop(),
                  color: AppColors.textSecondary(context),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Title Field
            TextField(
              controller: _titleController,
              autofocus: !isEditing,
              style: TextStyle(color: AppColors.text(context)),
              decoration: InputDecoration(
                labelText: context.isEn ? 'Task title *' : 'Titel der Aufgabe *',
                hintText: context.isEn
                    ? 'e.g. Implement dashboard UI'
                    : 'z. B. Dashboard UI implementieren',
              ),
            ),
            const SizedBox(height: 14),

            // Description Field
            TextField(
              controller: _descController,
              maxLines: 2,
              style: TextStyle(color: AppColors.text(context)),
              decoration: InputDecoration(
                labelText: context.isEn ? 'Description (optional)' : 'Beschreibung (optional)',
                hintText: context.isEn
                    ? 'Additional details, notes or links...'
                    : 'Zusätzliche Details, Notizen oder Links...',
              ),
            ),
            const SizedBox(height: 16),

            // Priority Selector
            Text(
              context.isEn ? 'Priority' : 'Priorität',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary(context),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: TodoPriority.values.map((p) {
                final isSelected = _priority == p;
                final color = AppColors.getPriorityColor(p);
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: p != TodoPriority.high ? 8 : 0,
                    ),
                    child: InkWell(
                      onTap: () => setState(() => _priority = p),
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? color.withValues(alpha: 0.2)
                              : AppColors.surfaceLight(context),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isSelected
                                ? color
                                : AppColors.border(context),
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            AppColors.getPriorityLabel(p, isEn: context.isEn),
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                              color: isSelected
                                  ? color
                                  : AppColors.textSecondary(context),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // Subtasks Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.isEn
                      ? 'Subtasks & Checklist (${_subtasks.length})'
                      : 'Teilschritte & Checkliste (${_subtasks.length})',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary(context),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Subtasks list
            if (_subtasks.isNotEmpty) ...[
              ..._subtasks.asMap().entries.map((entry) {
                final idx = entry.key;
                final st = entry.value;
                return Container(
                  margin: const EdgeInsets.only(bottom: 6),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight(context),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.border(context)),
                  ),
                  child: Row(
                    children: [
                      Checkbox(
                        value: st.isDone,
                        onChanged: (val) =>
                            setState(() => st.isDone = val ?? false),
                        activeColor: const Color(0xFF10B981),
                        visualDensity: VisualDensity.compact,
                      ),
                      Expanded(
                        child: Text(
                          st.title,
                          style: TextStyle(
                            fontSize: 13,
                            color: st.isDone
                                ? AppColors.textSecondary(context)
                                : AppColors.text(context),
                            decoration: st.isDone
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close_rounded, size: 16),
                        color: AppColors.textSecondary(context),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () =>
                            setState(() => _subtasks.removeAt(idx)),
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 6),
            ],

            // Add subtask input row
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 38,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceLight(context),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.border(context)),
                    ),
                    child: TextField(
                      controller: _subtaskInputController,
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.text(context),
                      ),
                      decoration: InputDecoration(
                        hintText: context.isEn ? 'Add subtask...' : 'Teilschritt eingeben...',
                        hintStyle: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary(context),
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                      ),
                      onSubmitted: (_) => _addSubtask(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  tooltip: context.isEn ? 'Add' : 'Hinzufügen',
                  icon: const Icon(
                    Icons.add_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    minimumSize: const Size(38, 38),
                  ),
                  onPressed: _addSubtask,
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Due Date & Assignee Row
            Row(
              children: [
                // Due Date
                Expanded(
                  child: InkWell(
                    onTap: _pickDueDate,
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceLight(context),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border(context)),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_today_rounded,
                            size: 16,
                            color: _dueDate != null
                                ? (isLight
                                      ? const Color(0xFF0284C7)
                                      : AppColors.primary)
                                : AppColors.textSecondary(context),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _dueDate != null
                                  ? '${_dueDate!.day}.${_dueDate!.month}.${_dueDate!.year}'
                                  : (context.isEn ? 'Due Date' : 'Fälligkeit'),
                              style: TextStyle(
                                fontSize: 13,
                                color: _dueDate != null
                                    ? AppColors.text(context)
                                    : AppColors.textSecondary(context),
                                fontWeight: _dueDate != null
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (_dueDate != null)
                            GestureDetector(
                              onTap: () => setState(() => _dueDate = null),
                              child: Icon(
                                Icons.close_rounded,
                                size: 16,
                                color: AppColors.textSecondary(context),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                // Assignee Selector
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceLight(context),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border(context)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<TodoListMember?>(
                        value: _selectedAssignee,
                        isExpanded: true,
                        dropdownColor: AppColors.surface(context),
                        icon: Icon(
                          Icons.arrow_drop_down_rounded,
                          color: AppColors.textSecondary(context),
                        ),
                        items: [
                          DropdownMenuItem<TodoListMember?>(
                            value: null,
                            child: Text(
                              context.isEn ? 'Unassigned' : 'Niemand',
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.textSecondary(context),
                              ),
                            ),
                          ),
                          ...members.map(
                            (m) => DropdownMenuItem<TodoListMember?>(
                              value: m,
                              child: Text(
                                m.userName ?? m.userEmail ?? 'User',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.text(context),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                        onChanged: (val) =>
                            setState(() => _selectedAssignee = val),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Recurrence Selector
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.surfaceLight(context),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border(context)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.repeat_rounded,
                    size: 18,
                    color: _recurrence != null
                        ? (isLight
                              ? const Color(0xFF0284C7)
                              : AppColors.primary)
                        : AppColors.textSecondary(context),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    context.isEn ? 'Repeat:' : 'Wiederholung:',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.text(context),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String?>(
                        value: _recurrence,
                        isExpanded: true,
                        dropdownColor: AppColors.surface(context),
                        items: [
                          DropdownMenuItem(
                            value: null,
                            child: Text(context.isEn ? 'No repeat' : 'Keine Wiederholung'),
                          ),
                          DropdownMenuItem(
                            value: 'daily',
                            child: Text(context.isEn ? '🔁 Daily' : '🔁 Täglich'),
                          ),
                          DropdownMenuItem(
                            value: 'workdays',
                            child: Text(context.isEn ? '💼 Weekdays (Mon-Fri)' : '💼 Werktags (Mo-Fr)'),
                          ),
                          DropdownMenuItem(
                            value: 'weekly',
                            child: Text(context.isEn ? '📅 Weekly' : '📅 Wöchentlich'),
                          ),
                          DropdownMenuItem(
                            value: 'monthly',
                            child: Text(context.isEn ? '🗓️ Monthly' : '🗓️ Monatlich'),
                          ),
                        ],
                        onChanged: (val) => setState(() => _recurrence = val),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // Work Timer Tracking & Timeline (for existing tasks)
            if (isEditing) ...[
              Builder(
                builder: (context) {
                  final item = widget.existingItem!;
                  final isRunning = item.isTimerRunning == true;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      WorkSessionTimeline(item: item),
                      if (!item.isCompleted &&
                          !widget.todoController.isViewer) ...[
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            OutlinedButton.icon(
                              onPressed: () async {
                                if (isRunning) {
                                  await widget.todoController.pauseTaskTimer(
                                    item.id!,
                                  );
                                } else {
                                  await widget.todoController.startTaskTimer(
                                    item.id!,
                                  );
                                }
                                if (context.mounted) {
                                  Navigator.of(context).pop();
                                }
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: isRunning
                                    ? AppColors.priorityMedium
                                    : (isLight
                                          ? const Color(0xFF0284C7)
                                          : AppColors.primary),
                                side: BorderSide(
                                  color: isRunning
                                      ? AppColors.priorityMedium
                                      : (isLight
                                            ? const Color(0xFF0284C7)
                                            : AppColors.primary),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 8,
                                ),
                              ),
                              icon: Icon(
                                isRunning
                                    ? Icons.pause_rounded
                                    : Icons.play_arrow_rounded,
                                size: 16,
                              ),
                              label: Text(
                                isRunning
                                    ? (context.isEn ? 'Pause Timer' : 'Timer pausieren')
                                    : (context.isEn ? 'Start Timer' : 'Timer starten'),
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  );
                },
              ),
              const SizedBox(height: 18),
            ],

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submit,
                child: _isSubmitting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        isEditing
                            ? (context.isEn ? 'Save changes' : 'Änderungen speichern')
                            : (context.isEn ? 'Add task' : 'Aufgabe hinzufügen'),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
