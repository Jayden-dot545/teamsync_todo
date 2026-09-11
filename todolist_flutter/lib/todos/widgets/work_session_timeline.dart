import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todolist_client/todolist_client.dart';
import '../../core/constants.dart';
import '../../core/localization_helper.dart';
import '../models/work_session.dart';
import '../services/time_report_service.dart';

class WorkSessionTimeline extends StatefulWidget {
  final TodoItem item;
  final bool isCompact;

  const WorkSessionTimeline({
    super.key,
    required this.item,
    this.isCompact = false,
  });

  @override
  State<WorkSessionTimeline> createState() => _WorkSessionTimelineState();
}

class _WorkSessionTimelineState extends State<WorkSessionTimeline> {
  Timer? _liveTimer;

  @override
  void initState() {
    super.initState();
    if (widget.item.isTimerRunning == true) {
      _liveTimer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (mounted) setState(() {});
      });
    }
  }

  @override
  void didUpdateWidget(covariant WorkSessionTimeline oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.item.isTimerRunning == true && _liveTimer == null) {
      _liveTimer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (mounted) setState(() {});
      });
    } else if (widget.item.isTimerRunning != true && _liveTimer != null) {
      _liveTimer?.cancel();
      _liveTimer = null;
    }
  }

  @override
  void dispose() {
    _liveTimer?.cancel();
    super.dispose();
  }

  void _exportTaskCsv() {
    final csv = TimeReportService.generateTaskCsv(item: widget.item);
    Clipboard.setData(ClipboardData(text: csv));

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
                context.isEn
                    ? 'Work sessions copied as CSV! 📊'
                    : 'Arbeitszeiten als CSV kopiert! 📊',
                style: TextStyle(
                  color: AppColors.text(context),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        action: SnackBarAction(
          label: context.isEn ? 'Preview' : 'Vorschau',
          textColor: const Color(0xFF0284C7),
          onPressed: () => _showCsvPreviewDialog(csv),
        ),
      ),
    );
  }

  void _showCsvPreviewDialog(String csv) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surface(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(color: AppColors.border(context)),
        ),
        title: Row(
          children: [
            const Icon(Icons.table_chart_rounded, color: Color(0xFF0284C7)),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                '${context.isEn ? "CSV Export" : "CSV-Export"}: ${widget.item.title}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.text(context),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        content: Container(
          constraints: const BoxConstraints(maxHeight: 280, maxWidth: 480),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.surfaceLight(context),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border(context)),
          ),
          child: SingleChildScrollView(
            child: SelectableText(
              csv,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                height: 1.4,
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(
              context.isEn ? 'Close' : 'Schließen',
              style: TextStyle(color: AppColors.textSecondary(context)),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: csv));
              Navigator.of(ctx).pop();
            },
            icon: const Icon(Icons.copy_rounded, size: 16),
            label: Text(context.isEn ? 'Copy Again' : 'Erneut kopieren'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLight = AppColors.isLight(context);
    final sessions = WorkSession.decodeList(widget.item.workSessionsJson);
    final isTimerRunning = widget.item.isTimerRunning == true;
    final timerStartedAt = widget.item.timerStartedAt;

    var currentRunningSeconds = 0;
    if (isTimerRunning && timerStartedAt != null) {
      currentRunningSeconds = DateTime.now()
          .difference(timerStartedAt)
          .inSeconds;
      if (currentRunningSeconds < 0) currentRunningSeconds = 0;
    }

    final totalLoggedSeconds =
        (widget.item.totalDurationSeconds ?? 0) + currentRunningSeconds;

    if (sessions.isEmpty && !isTimerRunning) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight(context),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border(context)),
        ),
        child: Row(
          children: [
            Icon(
              Icons.timer_outlined,
              size: 18,
              color: AppColors.textSecondary(context),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                context.isEn
                    ? 'No work sessions recorded yet. Start the timer with the play button.'
                    : 'Noch keine Arbeitsintervalle aufgezeichnet. Starte den Timer mit dem Play-Button.',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary(context),
                  height: 1.3,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(widget.isCompact ? 12 : 16),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight(context),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isTimerRunning
              ? (isLight
                    ? const Color(0xFF0284C7)
                    : AppColors.primary.withValues(alpha: 0.6))
              : AppColors.border(context),
          width: isTimerRunning ? 1.4 : 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Total Work Duration & Live Status + CSV Export Action
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color:
                      (isTimerRunning ? AppColors.primary : AppColors.secondary)
                          .withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  isTimerRunning
                      ? Icons.play_circle_fill_rounded
                      : Icons.history_toggle_off_rounded,
                  color: isTimerRunning
                      ? (isLight ? const Color(0xFF0284C7) : AppColors.primary)
                      : AppColors.secondary,
                  size: 16,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.isEn
                          ? 'Work Session Log'
                          : 'Zeiterfassungs-Protokoll',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: AppColors.text(context),
                      ),
                    ),
                    Text(
                      '${context.isEn ? "Total Work Time" : "Gesamtarbeitszeit"}: ${WorkSession.formatDuration(totalLoggedSeconds, isEn: context.isEn)}',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: isTimerRunning
                            ? (isLight
                                  ? const Color(0xFF0284C7)
                                  : AppColors.primary)
                            : AppColors.textSecondary(context),
                      ),
                    ),
                  ],
                ),
              ),
              if (isTimerRunning) ...[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.4),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        context.isEn ? 'Active' : 'Aktiv läuft',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: isLight
                              ? const Color(0xFF0284C7)
                              : AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 6),
              ],
              IconButton(
                tooltip: context.isEn
                    ? 'Export work sessions as CSV'
                    : 'Arbeitszeiten als CSV exportieren',
                icon: const Icon(
                  Icons.file_download_outlined,
                  size: 18,
                  color: Color(0xFF0284C7),
                ),
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.surface(context),
                  padding: const EdgeInsets.all(6),
                  minimumSize: const Size(32, 32),
                ),
                onPressed: _exportTaskCsv,
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Timeline of Work Sessions and Pauses
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: sessions.length + (isTimerRunning ? 1 : 0),
            separatorBuilder: (context, index) {
              if (index < sessions.length - 1) {
                final prev = sessions[index];
                final next = sessions[index + 1];
                final pauseSec = WorkSession.calculatePauseSeconds(prev, next);

                if (pauseSec != null && pauseSec > 30) {
                  return _buildPauseRow(
                    context,
                    pauseSec,
                    prev.getEndFormatted(isEn: context.isEn),
                    next.startFormatted,
                  );
                }
              } else if (index == sessions.length - 1 &&
                  isTimerRunning &&
                  timerStartedAt != null) {
                final prev = sessions[index];
                if (prev.endTime != null) {
                  final pauseSec = timerStartedAt
                      .difference(prev.endTime!)
                      .inSeconds;
                  if (pauseSec > 30) {
                    final prevEnd = prev.getEndFormatted(isEn: context.isEn);
                    final nextStart =
                        '${timerStartedAt.toLocal().hour.toString().padLeft(2, '0')}:${timerStartedAt.toLocal().minute.toString().padLeft(2, '0')}';
                    return _buildPauseRow(
                      context,
                      pauseSec,
                      prevEnd,
                      nextStart,
                    );
                  }
                }
              }
              return const SizedBox(height: 8);
            },
            itemBuilder: (context, index) {
              if (index < sessions.length) {
                final session = sessions[index];
                return _buildSessionCard(
                  context,
                  sessionNumber: index + 1,
                  timeRange: session.getTimeRangeFormatted(isEn: context.isEn),
                  durationStr: session.getFormattedDuration(isEn: context.isEn),
                  dateStr: session.getDateFormatted(isEn: context.isEn),
                  userName: session.userName,
                  isActive: false,
                );
              } else {
                final startHour =
                    timerStartedAt?.toLocal().hour.toString().padLeft(2, '0') ??
                    '--';
                final startMinute =
                    timerStartedAt?.toLocal().minute.toString().padLeft(
                      2,
                      '0',
                    ) ??
                    '--';
                final runningTimeStr = WorkSession.formatDuration(
                  currentRunningSeconds,
                  isEn: context.isEn,
                );

                return _buildSessionCard(
                  context,
                  sessionNumber: sessions.length + 1,
                  timeRange:
                      '$startHour:$startMinute – ${context.isEn ? "Now (Active)" : "Jetzt (Aktiv)"}',
                  durationStr: runningTimeStr,
                  dateStr: context.isEn ? 'Today' : 'Heute',
                  userName: widget.item.timerUserName,
                  isActive: true,
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSessionCard(
    BuildContext context, {
    required int sessionNumber,
    required String timeRange,
    required String durationStr,
    required String dateStr,
    String? userName,
    required bool isActive,
  }) {
    final isLight = AppColors.isLight(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: isActive
            ? (isLight
                  ? const Color(0xFFE0F2FE)
                  : AppColors.primary.withValues(alpha: 0.12))
            : AppColors.surface(context),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isActive
              ? (isLight ? const Color(0xFF38BDF8) : AppColors.primary)
              : AppColors.border(context),
          width: isActive ? 1.4 : 1.0,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive
                  ? (isLight ? const Color(0xFF0284C7) : AppColors.primary)
                  : AppColors.secondary.withValues(alpha: 0.2),
            ),
            child: Center(
              child: Text(
                '$sessionNumber',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: isActive
                      ? Colors.white
                      : (isLight ? AppColors.secondary : Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      timeRange,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: AppColors.text(context),
                      ),
                    ),
                    Text(
                      durationStr,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: isActive
                            ? (isLight
                                  ? const Color(0xFF0284C7)
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
                      dateStr,
                      style: TextStyle(
                        fontSize: 10.5,
                        color: AppColors.textSecondary(context),
                      ),
                    ),
                    if (userName != null && userName.trim().isNotEmpty) ...[
                      const SizedBox(width: 8),
                      Text(
                        '•',
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.textSecondary(context),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.person_outline_rounded,
                        size: 11,
                        color: AppColors.textSecondary(context),
                      ),
                      const SizedBox(width: 3),
                      Flexible(
                        child: Text(
                          userName.trim(),
                          style: TextStyle(
                            fontSize: 10.5,
                            color: AppColors.textSecondary(context),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
  }

  Widget _buildPauseRow(
    BuildContext context,
    int pauseSec,
    String prevEnd,
    String nextStart,
  ) {
    final pauseDurationStr = WorkSession.formatPause(
      pauseSec,
      isEn: context.isEn,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Row(
        children: [
          Container(
            width: 18,
            alignment: Alignment.center,
            child: const Text('☕', style: TextStyle(fontSize: 12)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(height: 1, color: AppColors.border(context)),
          ),
          const SizedBox(width: 8),
          Text(
            '$pauseDurationStr ($prevEnd ${context.isEn ? "to" : "bis"} $nextStart)',
            style: TextStyle(
              fontSize: 11,
              fontStyle: FontStyle.italic,
              color: AppColors.textSecondary(context),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(height: 1, color: AppColors.border(context)),
          ),
        ],
      ),
    );
  }
}
