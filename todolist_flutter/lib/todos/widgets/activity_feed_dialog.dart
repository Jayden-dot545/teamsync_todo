import 'package:flutter/material.dart';
import '../../core/client.dart';
import '../../core/constants.dart';
import '../../core/localization_helper.dart';

class ActivityFeedDialog extends StatefulWidget {
  final TodoList todoList;

  const ActivityFeedDialog({
    super.key,
    required this.todoList,
  });

  @override
  State<ActivityFeedDialog> createState() => _ActivityFeedDialogState();
}

class _ActivityFeedDialogState extends State<ActivityFeedDialog> {
  List<TodoActivity> _activities = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadActivities();
  }

  Future<void> _loadActivities() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final list = await client.todoItem.getActivities(
        listId: widget.todoList.id!,
      );
      if (mounted) {
        setState(() {
          _activities = list;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  String _formatRelativeTime(DateTime time, bool isEn) {
    final now = DateTime.now();
    final diff = now.difference(time);

    if (diff.inSeconds < 60) return isEn ? 'Just now' : 'Gerade eben';
    if (diff.inMinutes < 60) return isEn ? '${diff.inMinutes}m ago' : 'vor ${diff.inMinutes} Min.';
    if (diff.inHours < 24 && now.day == time.day) {
      final hour = time.hour.toString().padLeft(2, '0');
      final minute = time.minute.toString().padLeft(2, '0');
      return isEn ? 'Today, $hour:$minute' : 'Heute, $hour:$minute';
    }
    final day = time.day.toString().padLeft(2, '0');
    final month = time.month.toString().padLeft(2, '0');
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$day.$month. $hour:$minute';
  }

  (IconData, Color) _getActionStyle(String actionType) => switch (actionType) {
    'created' => (Icons.add_task_rounded, const Color(0xFF0284C7)),
    'completed' => (Icons.check_circle_rounded, AppColors.priorityLow),
    'reopened' => (Icons.replay_rounded, const Color(0xFFF59E0B)),
    'timer' => (Icons.timer_rounded, const Color(0xFF38BDF8)),
    'joined' => (Icons.person_add_rounded, AppColors.viewerColor),
    'deleted' => (Icons.delete_outline_rounded, AppColors.priorityHigh),
    _ => (Icons.notifications_active_outlined, AppColors.secondary),
  };

  @override
  Widget build(BuildContext context) {
    final isLight = AppColors.isLight(context);
    final isEn = context.isEn;

    return Dialog(
      backgroundColor: AppColors.surface(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
        side: BorderSide(color: AppColors.border(context), width: 1.2),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 540, maxHeight: 680),
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.history_rounded,
                      color: AppColors.secondary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isEn ? 'Activity Feed & History' : 'Aktivitäts-Feed & Verlauf',
                          style: TextStyle(
                            fontSize: 16,
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
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    tooltip: isEn ? 'Refresh' : 'Aktualisieren',
                    icon: Icon(
                      Icons.refresh_rounded,
                      color: AppColors.textSecondary(context),
                      size: 20,
                    ),
                    onPressed: _loadActivities,
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

            // Content
            Expanded(
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : _errorMessage != null
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(color: AppColors.priorityHigh),
                        ),
                      ),
                    )
                  : _activities.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.auto_awesome_outlined,
                            size: 36,
                            color: AppColors.textSecondary(context),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            isEn
                                ? 'No activities logged yet.'
                                : 'Noch keine Aktivitäten protokolliert.',
                            style: TextStyle(
                              color: AppColors.textSecondary(context),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: _activities.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final act = _activities[index];
                        final (icon, color) = _getActionStyle(act.actionType);

                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceLight(context),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColors.border(context),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: color.withValues(
                                    alpha: isLight ? 0.14 : 0.22,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(icon, color: color, size: 14),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      act.details,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.text(context),
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Row(
                                      children: [
                                        Text(
                                          act.actorName,
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500,
                                            color: color,
                                          ),
                                        ),
                                        Text(
                                          ' • ${_formatRelativeTime(act.timestamp, isEn)}',
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: AppColors.textSecondary(
                                              context,
                                            ),
                                          ),
                                        ),
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
            ),

            // Footer
            Divider(height: 1, color: AppColors.border(context)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(isEn ? 'Close' : 'Schließen'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
