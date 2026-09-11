import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todolist_client/todolist_client.dart';
import '../../core/constants.dart';
import '../../core/localization_helper.dart';
import '../models/work_session.dart';
import '../services/time_report_service.dart';
import 'productivity_charts_view.dart';

class TimeReportDialog extends StatefulWidget {
  final TodoList todoList;
  final List<TodoItem> items;
  final List<TodoListMember> members;

  const TimeReportDialog({
    super.key,
    required this.todoList,
    required this.items,
    required this.members,
  });

  @override
  State<TimeReportDialog> createState() => _TimeReportDialogState();
}

class _TimeReportDialogState extends State<TimeReportDialog> {
  TimeReportPeriod _selectedPeriod = TimeReportPeriod.thisWeek;
  String? _selectedUserId;

  String _getPeriodLabel(TimeReportPeriod period, bool isEn) => switch (period) {
    TimeReportPeriod.today => isEn ? 'Today' : 'Heute',
    TimeReportPeriod.thisWeek => isEn ? 'This Week' : 'Diese Woche',
    TimeReportPeriod.thisMonth => isEn ? 'This Month' : 'Dieser Monat',
    TimeReportPeriod.allTime => isEn ? 'All Time' : 'Gesamter Zeitraum',
  };

  void _showCopiedSnackbar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.surface(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: AppColors.border(context), width: 1.2),
        ),
        content: Row(
          children: [
            const Icon(
              Icons.check_circle_rounded,
              color: AppColors.priorityLow,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  color: AppColors.text(context),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _copyCsv(TimeReportSummary summary) {
    final csv = TimeReportService.generateCsv(
      listTitle: widget.todoList.title,
      summary: summary,
    );
    Clipboard.setData(ClipboardData(text: csv));
    _showCopiedSnackbar(
      context.isEn
          ? 'Timesheet copied as CSV! 📊'
          : 'Stundenzettel als CSV kopiert! 📊',
    );
  }

  void _copyTextReport(TimeReportSummary summary) {
    final report = TimeReportService.generateTextReport(
      listTitle: widget.todoList.title,
      summary: summary,
      periodLabel: _getPeriodLabel(_selectedPeriod, context.isEn),
    );
    Clipboard.setData(ClipboardData(text: report));
    _showCopiedSnackbar(
      context.isEn
          ? 'Formatted timesheet report copied! 📋'
          : 'Formatierter Stundenzettel-Bericht kopiert! 📋',
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLight = AppColors.isLight(context);
    final isEn = context.isEn;
    final summary = TimeReportService.generateSummary(
      items: widget.items,
      period: _selectedPeriod,
      filterUserId: _selectedUserId,
    );

    return Dialog(
      backgroundColor: AppColors.surface(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
        side: BorderSide(color: AppColors.border(context), width: 1.2),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 680, maxHeight: 760),
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.analytics_outlined,
                      color: isLight
                          ? const Color(0xFF0284C7)
                          : AppColors.primary,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isEn ? 'Time Tracking & Timesheet' : 'Zeitauswertung & Stundenzettel',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: AppColors.text(context),
                          ),
                        ),
                        Text(
                          '${isEn ? "Project" : "Projekt"}: ${widget.todoList.title}',
                          style: TextStyle(
                            fontSize: 11.5,
                            color: AppColors.textSecondary(context),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close_rounded,
                      color: AppColors.textSecondary(context),
                      size: 20,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: AppColors.border(context)),

            // Period & Member Filter Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              color: AppColors.surfaceLight(context),
              child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: TimeReportPeriod.values.map((p) {
                        final isSelected = _selectedPeriod == p;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: FilterChip(
                            label: Text(_getPeriodLabel(p, isEn)),
                            selected: isSelected,
                            onSelected: (_) =>
                                setState(() => _selectedPeriod = p),
                            selectedColor: isLight
                                ? const Color(
                                    0xFF0284C7,
                                  ).withValues(alpha: 0.15)
                                : AppColors.primary.withValues(alpha: 0.2),
                            checkmarkColor: isLight
                                ? const Color(0xFF0284C7)
                                : AppColors.primary,
                            labelStyle: TextStyle(
                              fontSize: 12,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                              color: isSelected
                                  ? (isLight
                                        ? const Color(0xFF0284C7)
                                        : Colors.white)
                                  : AppColors.text(context),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  if (widget.members.length > 1) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          isEn ? 'Member:' : 'Mitarbeiter:',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary(context),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surface(context),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: AppColors.border(context),
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String?>(
                                value: _selectedUserId,
                                isDense: true,
                                dropdownColor: AppColors.surface(context),
                                items: [
                                  DropdownMenuItem<String?>(
                                    value: null,
                                    child: Text(
                                      isEn ? '👥 All team members' : '👥 Alle Teammitglieder',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.text(context),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  ...widget.members.map(
                                    (m) => DropdownMenuItem<String?>(
                                      value: m.userId?.toString(),
                                      child: Text(
                                        m.userName ?? m.userEmail ?? (isEn ? 'Member' : 'Mitglied'),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: AppColors.text(context),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                                onChanged: (val) =>
                                    setState(() => _selectedUserId = val),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            Divider(height: 1, color: AppColors.border(context)),

            // Content: KPIs + Chart + Sessions List
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // KPI Cards
                    Row(
                      children: [
                        Expanded(
                          child: _buildKpi(
                            context,
                            Icons.timer_outlined,
                            isLight
                                ? const Color(0xFF0284C7)
                                : AppColors.primary,
                            isEn ? 'Total Work Time' : 'Gesamtarbeitszeit',
                            WorkSession.formatDuration(
                              summary.totalWorkSeconds,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _buildKpi(
                            context,
                            Icons.coffee_outlined,
                            const Color(0xFFF59E0B),
                            isEn ? 'Break Time' : 'Pausenzeit',
                            WorkSession.formatDuration(
                              summary.totalPauseSeconds,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: _buildKpi(
                            context,
                            Icons.repeat_rounded,
                            AppColors.secondary,
                            isEn ? 'Work Sessions' : 'Arbeitsphasen',
                            '${summary.totalSessions}',
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _buildKpi(
                            context,
                            Icons.calendar_month_outlined,
                            AppColors.priorityLow,
                            isEn ? 'Active Days' : 'Aktive Tage',
                            '${summary.dailyStats.length}',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),

                    // Productivity & Team Charts
                    ProductivityChartsView(summary: summary),
                    const SizedBox(height: 20),

                    // Daily Bars
                    if (summary.dailyStats.isNotEmpty) ...[
                      Text(
                        isEn ? 'DAILY WORK DISTRIBUTION' : 'TÄGLICHE ARBEITSVERTEILUNG',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.8,
                          color: AppColors.textSecondary(context),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceLight(context),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.border(context)),
                        ),
                        child: Column(
                          children: summary.dailyStats.entries.map((e) {
                            final stat = e.value;
                            final dayLabel =
                                '${stat.date.day.toString().padLeft(2, '0')}.${stat.date.month.toString().padLeft(2, '0')}.${stat.date.year}';
                            final maxSec = summary.dailyStats.values
                                .map((s) => s.workSeconds)
                                .reduce((a, b) => a > b ? a : b);
                            final percent = maxSec > 0
                                ? (stat.workSeconds / maxSec).clamp(0.08, 1.0)
                                : 0.08;

                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 80,
                                    child: Text(
                                      dayLabel,
                                      style: TextStyle(
                                        fontSize: 11.5,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.text(context),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: LinearProgressIndicator(
                                        value: percent,
                                        minHeight: 10,
                                        backgroundColor: AppColors.surface(
                                          context,
                                        ),
                                        color: isLight
                                            ? const Color(0xFF0284C7)
                                            : AppColors.primary,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                    width: 95,
                                    child: Text(
                                      WorkSession.formatDuration(
                                        stat.workSeconds,
                                      ),
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        fontSize: 11.5,
                                        fontWeight: FontWeight.bold,
                                        color: isLight
                                            ? const Color(0xFF0284C7)
                                            : AppColors.primary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],

                    // Single Session Entries
                    Text(
                      isEn ? 'SESSION LOG' : 'PROTOKOLL DER EINZELPHASEN',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8,
                        color: AppColors.textSecondary(context),
                      ),
                    ),
                    const SizedBox(height: 8),

                    if (summary.entries.isEmpty)
                      Container(
                        padding: const EdgeInsets.all(20),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.surfaceLight(context),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.border(context)),
                        ),
                        child: Text(
                          isEn
                              ? 'No work sessions found in this period.'
                              : 'Keine Arbeitsphasen im Zeitraum gefunden.',
                          style: TextStyle(
                            color: AppColors.textSecondary(context),
                            fontSize: 12,
                          ),
                        ),
                      )
                    else
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: summary.entries.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 6),
                        itemBuilder: (context, index) {
                          final entry = summary.entries[index];
                          final isRunning = entry.session.isRunning;
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: isRunning
                                  ? (isLight
                                        ? const Color(0xFFE0F2FE)
                                        : AppColors.primary.withValues(
                                            alpha: 0.12,
                                          ))
                                  : AppColors.surfaceLight(context),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: isRunning
                                    ? (isLight
                                          ? const Color(0xFF38BDF8)
                                          : AppColors.primary)
                                    : AppColors.border(context),
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isRunning
                                        ? (isLight
                                              ? const Color(0xFF0284C7)
                                              : AppColors.primary)
                                        : AppColors.secondary.withValues(
                                            alpha: 0.2,
                                          ),
                                  ),
                                  child: Icon(
                                    isRunning
                                        ? Icons.play_arrow_rounded
                                        : Icons.check_rounded,
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              entry.item.title,
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.text(context),
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Text(
                                            entry.session.formattedDuration,
                                            style: TextStyle(
                                              fontSize: 12.5,
                                              fontWeight: FontWeight.bold,
                                              color: isRunning
                                                  ? (isLight
                                                        ? const Color(
                                                            0xFF0284C7,
                                                          )
                                                        : AppColors.primary)
                                                  : AppColors.text(context),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 2),
                                      Row(
                                        children: [
                                          Text(
                                            '${entry.session.dateFormatted} • ${entry.session.timeRangeFormatted}',
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: AppColors.textSecondary(
                                                context,
                                              ),
                                            ),
                                          ),
                                          if (entry.session.userName !=
                                              null) ...[
                                            Text(
                                              ' • ${entry.session.userName!}',
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: AppColors.textSecondary(
                                                  context,
                                                ),
                                              ),
                                            ),
                                          ],
                                          if (entry.pauseBeforeSeconds !=
                                                  null &&
                                              entry.pauseBeforeSeconds! >
                                                  30) ...[
                                            const Spacer(),
                                            Text(
                                              '☕ ${WorkSession.formatPause(entry.pauseBeforeSeconds!)}',
                                              style: TextStyle(
                                                fontSize: 10.5,
                                                fontStyle: FontStyle.italic,
                                                color: AppColors.textSecondary(
                                                  context,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),

            // Footer Buttons
            Divider(height: 1, color: AppColors.border(context)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                children: [
                  OutlinedButton.icon(
                    onPressed: summary.entries.isEmpty
                        ? null
                        : () => _copyTextReport(summary),
                    icon: const Icon(Icons.description_outlined, size: 15),
                    label: Text(
                      isEn ? 'Copy text report' : 'Textbericht kopieren',
                      style: const TextStyle(fontSize: 11.5),
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton.icon(
                    onPressed: summary.entries.isEmpty
                        ? null
                        : () => _copyCsv(summary),
                    icon: const Icon(Icons.table_chart_outlined, size: 15),
                    label: Text(
                      isEn ? 'CSV Timesheet' : 'CSV-Stundenzettel',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKpi(
    BuildContext context,
    IconData icon,
    Color color,
    String title,
    String value,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight(context),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border(context)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 10.5,
                    color: AppColors.textSecondary(context),
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.bold,
                    color: AppColors.text(context),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
