import 'package:flutter/material.dart';
import 'package:todolist_client/todolist_client.dart';
import '../../core/constants.dart';
import '../../core/localization_helper.dart';
import '../todo_controller.dart';
import 'create_todo_sheet.dart';
import 'todo_tile.dart';

class CalendarView extends StatefulWidget {
  final TodoController todoController;
  final List<TodoItem> items;
  final bool isViewer;

  const CalendarView({
    super.key,
    required this.todoController,
    required this.items,
    required this.isViewer,
  });

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  DateTime _currentMonth = DateTime(DateTime.now().year, DateTime.now().month, 1);
  DateTime _selectedDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  void _previousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1, 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 1);
    });
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  String _getMonthName(int month, bool isEn) {
    const monthsDe = [
      'Januar',
      'Februar',
      'März',
      'April',
      'Mai',
      'Juni',
      'Juli',
      'August',
      'September',
      'Oktober',
      'November',
      'Dezember',
    ];
    const monthsEn = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return isEn ? monthsEn[month - 1] : monthsDe[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    final isLight = AppColors.isLight(context);
    final isEn = context.isEn;
    final daysInMonth = DateTime(
      _currentMonth.year,
      _currentMonth.month + 1,
      0,
    ).day;
    final firstWeekday = _currentMonth.weekday; // 1 = Mo, 7 = So

    // Map tasks to dates
    final tasksByDay = <int, List<TodoItem>>{};
    for (final item in widget.items) {
      if (item.dueDate != null) {
        final due = item.dueDate!.toLocal();
        if (due.year == _currentMonth.year && due.month == _currentMonth.month) {
          tasksByDay.putIfAbsent(due.day, () => []).add(item);
        }
      }
    }

    final selectedDayTasks = widget.items.where((item) {
      if (item.dueDate == null) return false;
      final due = item.dueDate!.toLocal();
      return _isSameDay(due, _selectedDate);
    }).toList();

    return Column(
      children: [
        // Month Navigation Header
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.surface(context),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.borderSubtle(context)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left_rounded),
                onPressed: _previousMonth,
                color: AppColors.text(context),
              ),
              Row(
                children: [
                  const Icon(Icons.calendar_month_rounded, color: AppColors.primary, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    '${_getMonthName(_currentMonth.month, isEn)} ${_currentMonth.year}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: AppColors.text(context),
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right_rounded),
                onPressed: _nextMonth,
                color: AppColors.text(context),
              ),
            ],
          ),
        ),

        // Weekday Header (Mo - So or Mon - Sun)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: isEn
                ? const [
                    _WeekdayLabel('Mon'),
                    _WeekdayLabel('Tue'),
                    _WeekdayLabel('Wed'),
                    _WeekdayLabel('Thu'),
                    _WeekdayLabel('Fri'),
                    _WeekdayLabel('Sat'),
                    _WeekdayLabel('Sun'),
                  ]
                : const [
                    _WeekdayLabel('Mo'),
                    _WeekdayLabel('Di'),
                    _WeekdayLabel('Mi'),
                    _WeekdayLabel('Do'),
                    _WeekdayLabel('Fr'),
                    _WeekdayLabel('Sa'),
                    _WeekdayLabel('So'),
                  ],
          ),
        ),

        // Calendar Grid
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.surface(context),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.borderSubtle(context)),
          ),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 42, // 6 weeks
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              childAspectRatio: 1.1,
            ),
            itemBuilder: (context, index) {
              final dayOffset = index - (firstWeekday - 1);
              if (dayOffset < 0 || dayOffset >= daysInMonth) {
                return const SizedBox.shrink();
              }

              final dayNumber = dayOffset + 1;
              final dayDate = DateTime(
                _currentMonth.year,
                _currentMonth.month,
                dayNumber,
              );
              final isToday = _isSameDay(dayDate, DateTime.now());
              final isSelected = _isSameDay(dayDate, _selectedDate);
              final dayTasks = tasksByDay[dayNumber] ?? [];

              return InkWell(
                onTap: () {
                  setState(() => _selectedDate = dayDate);
                },
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected
                        ? (isLight ? const Color(0xFFE0F2FE) : AppColors.primary.withValues(alpha: 0.22))
                        : isToday
                        ? (isLight ? const Color(0xFFF1F5F9) : AppColors.surfaceLight(context))
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primary
                          : isToday
                          ? AppColors.primary.withValues(alpha: 0.5)
                          : Colors.transparent,
                      width: isSelected ? 1.6 : 1.0,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$dayNumber',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: isToday || isSelected ? FontWeight.w800 : FontWeight.w500,
                          color: isSelected
                              ? (isLight ? const Color(0xFF0284C7) : AppColors.primary)
                              : isToday
                              ? AppColors.primary
                              : AppColors.text(context),
                        ),
                      ),
                      if (dayTasks.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: dayTasks.take(3).map((task) {
                            final color = task.isCompleted
                                ? AppColors.priorityLow
                                : AppColors.getPriorityColor(task.priority);
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 1),
                              width: 5,
                              height: 5,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: color,
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        // Selected Date Tasks List Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isEn
                    ? 'Tasks for ${_selectedDate.day}.${_selectedDate.month}.${_selectedDate.year}'
                    : 'Aufgaben für ${_selectedDate.day}.${_selectedDate.month}.${_selectedDate.year}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: AppColors.text(context),
                ),
              ),
              Text(
                isEn
                    ? '${selectedDayTasks.length} due'
                    : '${selectedDayTasks.length} fällig',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary(context),
                ),
              ),
            ],
          ),
        ),

        // Selected Date Tasks List
        Expanded(
          child: selectedDayTasks.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.event_available_rounded,
                        size: 36,
                        color: AppColors.textSecondary(context).withValues(alpha: 0.5),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        isEn
                            ? 'No tasks due on this day.'
                            : 'Keine Aufgaben für diesen Tag fällig.',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary(context),
                        ),
                      ),
                      if (!widget.isViewer) ...[
                        const SizedBox(height: 10),
                        ElevatedButton.icon(
                          onPressed: () => showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (_) => CreateTodoSheet(
                              todoController: widget.todoController,
                            ),
                          ),
                          icon: const Icon(Icons.add_rounded, size: 16),
                          label: Text(
                            isEn
                                ? 'Create task for this day'
                                : 'Aufgabe für diesen Tag erstellen',
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                  itemCount: selectedDayTasks.length,
                  itemBuilder: (context, index) {
                    final item = selectedDayTasks[index];
                    return TodoTile(
                      key: ValueKey(item.id),
                      item: item,
                      todoController: widget.todoController,
                    );
                  },
                ),
        ),
      ],
    );
  }
}

class _WeekdayLabel extends StatelessWidget {
  final String label;

  const _WeekdayLabel(this.label);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32,
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: AppColors.textSecondary(context),
          ),
        ),
      ),
    );
  }
}
