import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/constants.dart';
import '../../core/localization_helper.dart';
import '../../todos/todo_list_screen.dart';
import '../list_controller.dart';

class JoinListDialog extends StatefulWidget {
  final ListController listController;

  const JoinListDialog({
    super.key,
    required this.listController,
  });

  @override
  State<JoinListDialog> createState() => _JoinListDialogState();
}

class _JoinListDialogState extends State<JoinListDialog> {
  final _codeController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _pasteFromClipboard() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    if (data?.text != null && data!.text!.trim().isNotEmpty) {
      setState(() {
        _codeController.text = data.text!.trim();
        _errorMessage = null;
      });
    }
  }

  Future<void> _joinList() async {
    final input = _codeController.text.trim();
    if (input.isEmpty) {
      setState(
        () => _errorMessage = 'Bitte gib einen Einladungscode oder Link ein.',
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final joinedList = await widget.listController.joinListByInviteCode(
        input,
      );
      if (mounted && joinedList != null) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.surface(context),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: AppColors.border(context), width: 1.2),
            ),
            content: Row(
              children: [
                const Icon(
                  Icons.celebration_rounded,
                  color: AppColors.priorityLow,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Erfolgreich der Liste "${joinedList.title}" beigetreten! 🎉',
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

        // Open the joined list directly
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => TodoListScreen(
              todoList: joinedList,
              listController: widget.listController,
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = e
              .toString()
              .replaceAll('Exception:', '')
              .replaceAll('TodoListException:', '')
              .trim();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.surface(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(color: AppColors.border(context), width: 1.2),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.group_add_rounded,
                      color: AppColors.primary,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.isEn ? 'Join List' : 'Liste beitreten',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.text(context),
                          ),
                        ),
                        Text(
                          context.isEn
                              ? 'Enter invite link or code'
                              : 'Gib den Einladungs-Link oder Code ein',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close_rounded,
                      color: AppColors.textSecondary(context),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Divider(color: AppColors.border(context), height: 1),
              const SizedBox(height: 16),

              if (_errorMessage != null) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.priorityHigh.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColors.priorityHigh.withValues(alpha: 0.4),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: AppColors.priorityHigh,
                        size: 18,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(
                            color: Color(0xFFFDA4AF),
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],

              TextField(
                controller: _codeController,
                autofocus: true,
                style: TextStyle(color: AppColors.text(context)),
                decoration: InputDecoration(
                  labelText: context.isEn
                      ? 'Invite Link or Code *'
                      : 'Einladungs-Link oder Code *',
                  hintText: context.isEn
                      ? 'e.g. TS-A1B2C3D4 or Link'
                      : 'z. B. TS-A1B2C3D4 oder Link',
                  prefixIcon: const Icon(Icons.vpn_key_outlined),
                  suffixIcon: IconButton(
                    tooltip: context.isEn
                        ? 'Paste from clipboard'
                        : 'Aus Zwischenablage einfügen',
                    icon: const Icon(
                      Icons.content_paste_rounded,
                      color: AppColors.primary,
                    ),
                    onPressed: _pasteFromClipboard,
                  ),
                ),
              ),

              const SizedBox(height: 12),
              Text(
                context.isEn
                    ? 'Tip: You can paste the full link (e.g. https://teamsync.app/join/TS-...) or just the code.'
                    : 'Tipp: Du kannst den kompletten Link (z. B. https://teamsync.app/join/TS-...) oder einfach den Code einfügen.',
                style: TextStyle(
                  fontSize: 11.5,
                  color: AppColors.textSecondary(context),
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 24),
              Row(
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      context.l10n.cancel,
                      style: TextStyle(color: AppColors.textSecondary(context)),
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton.icon(
                    onPressed: _isLoading ? null : _joinList,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    icon: _isLoading
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.login_rounded, size: 18),
                    label: Text(
                      context.isEn ? 'Join Now' : 'Jetzt beitreten',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
