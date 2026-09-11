import 'package:flutter/material.dart';
import '../../core/constants.dart';
import '../../core/localization_helper.dart';
import '../models/work_session.dart';
import '../services/time_report_service.dart';

class ProductivityChartsView extends StatelessWidget {
  final TimeReportSummary summary;

  const ProductivityChartsView({
    super.key,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    final isLight = AppColors.isLight(context);
    final isEn = context.isEn;

    // Group hours by user
    final userHours = <String, int>{};
    for (final entry in summary.entries) {
      final name = entry.session.userName ?? (isEn ? 'Unknown' : 'Unbekannt');
      userHours[name] = (userHours[name] ?? 0) + entry.session.durationSeconds;
    }

    final sortedUsers = userHours.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    // Calculate daily data for last 7 days
    final now = DateTime.now();
    final last7Days = List.generate(7, (i) {
      final d = now.subtract(Duration(days: 6 - i));
      return DateTime(d.year, d.month, d.day);
    });

    final dailySeconds = last7Days.map((date) {
      return summary.dailyStats[date]?.workSeconds ?? 0;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Weekly Work Hours Bar Chart Card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface(context),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.borderSubtle(context)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.bar_chart_rounded,
                        color: AppColors.primary,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        isEn ? 'Work Hours (Last 7 Days)' : 'Arbeitsstunden (Letzte 7 Tage)',
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w800,
                          color: AppColors.text(context),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '${isEn ? "Total" : "Gesamt"}: ${WorkSession.formatDuration(summary.totalWorkSeconds)}',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: isLight ? const Color(0xFF0284C7) : AppColors.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 120,
                child: CustomPaint(
                  size: Size.infinite,
                  painter: _BarChartPainter(
                    dailySeconds: dailySeconds,
                    dates: last7Days,
                    isLight: isLight,
                    isEn: isEn,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // 2. Team Member Work Distribution
        if (sortedUsers.isNotEmpty) ...[
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface(context),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.borderSubtle(context)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.groups_outlined,
                      color: AppColors.secondary,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      isEn ? 'Team Workload & Time Allocation' : 'Team-Auslastung & Zeiteinsatz',
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w800,
                        color: AppColors.text(context),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ...sortedUsers.map((entry) {
                  final percent = summary.totalWorkSeconds > 0
                      ? entry.value / summary.totalWorkSeconds
                      : 0.0;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              entry.key,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: AppColors.text(context),
                              ),
                            ),
                            Text(
                              '${WorkSession.formatDuration(entry.value)} (${(percent * 100).toStringAsFixed(0)}%)',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textSecondary(context),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: LinearProgressIndicator(
                            value: percent,
                            minHeight: 6,
                            backgroundColor: AppColors.surfaceLight(context),
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              AppColors.secondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _BarChartPainter extends CustomPainter {
  final List<int> dailySeconds;
  final List<DateTime> dates;
  final bool isLight;
  final bool isEn;

  _BarChartPainter({
    required this.dailySeconds,
    required this.dates,
    required this.isLight,
    required this.isEn,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (!size.width.isFinite || !size.height.isFinite || size.width <= 0 || size.height <= 0 || dailySeconds.isEmpty) {
      return;
    }

    final maxSec = dailySeconds.reduce((a, b) => a > b ? a : b);
    final effectiveMax = maxSec > 0 ? maxSec.toDouble() : 3600.0; // at least 1h scale
    final barWidth = (size.width / (dailySeconds.length * 2)).clamp(16.0, 32.0);
    final spacing = (size.width - (barWidth * dailySeconds.length)) / (dailySeconds.length + 1);

    final bgPaint = Paint()
      ..color = isLight ? const Color(0xFFE2E8F0) : const Color(0xFF1E293B)
      ..style = PaintingStyle.fill;

    final barPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: isLight
            ? const [Color(0xFF0284C7), Color(0xFF38BDF8)]
            : const [Color(0xFF38BDF8), Color(0xFF0284C7)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final weekDays = isEn
        ? const ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
        : const ['Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa', 'So'];

    for (var i = 0; i < dailySeconds.length; i++) {
      final x = spacing + i * (barWidth + spacing);
      final sec = dailySeconds[i];
      final ratio = (sec / effectiveMax).clamp(0.0, 1.0);
      final barHeight = (size.height - 24) * ratio;

      // Draw background bar slot
      final bgRRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(x, 0, barWidth, size.height - 24),
        const Radius.circular(6),
      );
      canvas.drawRRect(bgRRect, bgPaint);

      // Draw active fill bar
      if (barHeight > 0) {
        final fillRRect = RRect.fromRectAndRadius(
          Rect.fromLTWH(
            x,
            (size.height - 24) - barHeight,
            barWidth,
            barHeight,
          ),
          const Radius.circular(6),
        );
        canvas.drawRRect(fillRRect, barPaint);
      }

      // Draw day label text below bar
      final weekdayIndex = dates[i].weekday - 1;
      final dayLabel = weekDays[weekdayIndex];
      final textSpan = TextSpan(
        text: dayLabel,
        style: TextStyle(
          color: isLight ? const Color(0xFF334155) : const Color(0xFF94A3B8),
          fontSize: 10,
          fontWeight: FontWeight.w700,
        ),
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      )..layout();

      textPainter.paint(
        canvas,
        Offset(x + (barWidth - textPainter.width) / 2, size.height - 18),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _BarChartPainter oldDelegate) {
    return oldDelegate.dailySeconds != dailySeconds ||
        oldDelegate.isLight != isLight ||
        oldDelegate.isEn != isEn;
  }
}
