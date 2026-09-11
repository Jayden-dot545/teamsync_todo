import 'package:flutter/material.dart';
import 'package:todolist_client/todolist_client.dart';
import '../../../core/constants.dart';
import '../../../core/localization_helper.dart';
import '../todo_controller.dart';

class MemberProfileDialog extends StatefulWidget {
  final TodoListMember member;
  final TodoController todoController;
  final int listId;

  const MemberProfileDialog({
    super.key,
    required this.member,
    required this.todoController,
    required this.listId,
  });

  @override
  State<MemberProfileDialog> createState() => _MemberProfileDialogState();
}

class _MemberProfileDialogState extends State<MemberProfileDialog> {
  final _dmController = TextEditingController();
  bool _isSending = false;
  List<TodoChatMessage> _privateThread = [];
  bool _isLoadingThread = true;

  @override
  void initState() {
    super.initState();
    _loadPrivateMessages();
  }

  @override
  void dispose() {
    _dmController.dispose();
    super.dispose();
  }

  Future<void> _loadPrivateMessages() async {
    final myId = widget.todoController.currentUserId;
    final targetId = widget.member.userId;

    if (myId == null || targetId == null) {
      if (mounted) setState(() => _isLoadingThread = false);
      return;
    }

    final allMsgs = await widget.todoController.fetchChatMessages(
      widget.listId,
    );
    if (mounted) {
      setState(() {
        _privateThread = allMsgs.where((m) {
          if (m.isPrivate != true) return false;
          final isFromMeToThem =
              m.senderUserId == myId && m.recipientUserId == targetId;
          final isFromThemToMe =
              m.senderUserId == targetId && m.recipientUserId == myId;
          return isFromMeToThem || isFromThemToMe;
        }).toList();
        _isLoadingThread = false;
      });
    }
  }

  Future<void> _sendPrivateMessage() async {
    final text = _dmController.text.trim();
    if (text.isEmpty) return;

    final targetId = widget.member.userId;
    if (targetId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            context.isEn
                ? 'This member does not have a registered user account yet.'
                : 'Dieses Mitglied hat noch kein registriertes Benutzerkonto.',
          ),
          backgroundColor: AppColors.priorityHigh,
        ),
      );
      return;
    }

    setState(() => _isSending = true);

    final success = await widget.todoController.sendPrivateDirectMessage(
      listId: widget.listId,
      recipientUserId: targetId,
      recipientName:
          widget.member.userName ??
          widget.member.userEmail ??
          (context.isEn ? 'Member' : 'Mitglied'),
      message: text,
    );

    if (mounted) {
      setState(() => _isSending = false);
      if (success) {
        _dmController.clear();
        await _loadPrivateMessages();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: AppColors.surface(context),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: AppColors.border(context)),
              ),
              content: Row(
                children: [
                  const Icon(
                    Icons.lock_rounded,
                    color: AppColors.priorityLow,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      context.isEn
                          ? 'Private message sent to ${widget.member.userName ?? "the member"}! 🔒'
                          : 'Private Nachricht an ${widget.member.userName ?? "das Mitglied"} gesendet! 🔒',
                      style: TextStyle(color: AppColors.text(context)),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.todoController.errorMessage ??
                  (context.isEn
                      ? 'Error sending private message'
                      : 'Fehler beim Senden der privaten Nachricht'),
            ),
            backgroundColor: AppColors.priorityHigh,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final member = widget.member;
    final isOwner = member.role == MemberRole.owner;
    final isViewer = member.role == MemberRole.viewer;
    final myId = widget.todoController.currentUserId;
    final isSelf = member.userId != null && member.userId == myId;
    final isLight = AppColors.isLight(context);

    final roleColor = isOwner
        ? const Color(0xFFF59E0B)
        : isViewer
        ? AppColors.viewerColor
        : (isLight ? const Color(0xFF0284C7) : AppColors.primary);

    final roleTitle = isOwner
        ? (context.isEn
              ? '👑 Team Lead & Owner'
              : '👑 Chef & Projektleitung')
        : isViewer
        ? (context.isEn
              ? '👁️ Viewer (Supervisor)'
              : '👁️ Zuschauer (Supervisor)')
        : (context.isEn ? '✍️ Editor (Active)' : '✍️ Arbeiter (Aktiv)');

    final displayName =
        member.userName ??
        member.userEmail ??
        (context.isEn ? 'Team Member' : 'Teammitglied');
    final parts = displayName
        .trim()
        .split(' ')
        .where((p) => p.isNotEmpty)
        .toList();
    final initials = parts.length > 1
        ? '${parts[0][0]}${parts[1][0]}'.toUpperCase()
        : displayName
              .substring(0, displayName.length >= 2 ? 2 : 1)
              .toUpperCase();
    final bio =
        member.userBio ??
        (context.isEn
            ? 'TeamSync Project Member'
            : 'TeamSync Projektmitglied');
    final status = member.userStatus ?? roleTitle;

    return Dialog(
      backgroundColor: AppColors.surface(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: AppColors.border(context), width: 1.2),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: roleColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.badge_outlined,
                          color: roleColor,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        context.isEn ? 'Team Profile' : 'Team-Profil',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: AppColors.text(context),
                        ),
                      ),
                    ],
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
              const SizedBox(height: 14),

              // Avatar & Basic Info Card
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [roleColor, roleColor.withValues(alpha: 0.7)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        border: Border.all(color: Colors.white, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: roleColor.withValues(alpha: 0.35),
                            blurRadius: 14,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          initials,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      displayName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.text(context),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: roleColor.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: roleColor.withValues(alpha: 0.4),
                        ),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: roleColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Bio / Details Container
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight(context),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.border(context)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.isEn ? 'About Me / Bio' : 'Über mich / Bio',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textSecondary(context),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      bio,
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.text(context),
                        height: 1.4,
                      ),
                    ),
                    if (member.userEmail != null &&
                        member.userEmail!.isNotEmpty) ...[
                      const SizedBox(height: 10),
                      Divider(color: AppColors.border(context), height: 1),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(
                            Icons.email_outlined,
                            size: 15,
                            color: AppColors.textSecondary(context),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              member.userEmail!,
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary(context),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Private Message Section (Only if not self)
              if (!isSelf) ...[
                Row(
                  children: [
                    Icon(
                      Icons.lock_outline_rounded,
                      size: 16,
                      color: isLight
                          ? const Color(0xFF0284C7)
                          : AppColors.primary,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      context.isEn
                          ? 'Private message to $displayName'
                          : 'Private Nachricht an $displayName',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: AppColors.text(context),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  context.isEn
                      ? '🔒 Only visible to you and this user in the project.'
                      : '🔒 Nur für dich und diesen Nutzer im Projekt sichtbar.',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary(context),
                  ),
                ),
                const SizedBox(height: 10),

                // Mini Private Chat History
                if (_isLoadingThread)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  )
                else if (_privateThread.isNotEmpty)
                  Container(
                    constraints: const BoxConstraints(maxHeight: 140),
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isLight ? Colors.white : const Color(0xFF0F172A),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border(context)),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _privateThread.length,
                      itemBuilder: (context, index) {
                        final msg = _privateThread[index];
                        final isMe = msg.senderUserId == myId;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          child: Align(
                            alignment: isMe
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: isMe
                                    ? AppColors.primary.withValues(
                                        alpha: isLight ? 0.15 : 0.25,
                                      )
                                    : AppColors.surfaceLight(context),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: isMe
                                      ? (isLight
                                            ? const Color(0xFF0284C7)
                                            : AppColors.primary.withValues(
                                                alpha: 0.5,
                                              ))
                                      : AppColors.border(context),
                                ),
                              ),
                              child: Text(
                                msg.message,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.text(context),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                // DM Input Box
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _dmController,
                        style: TextStyle(
                          color: AppColors.text(context),
                          fontSize: 13,
                        ),
                        onSubmitted: (_) => _sendPrivateMessage(),
                        decoration: InputDecoration(
                          hintText: context.isEn
                              ? 'Write private message...'
                              : 'Private Nachricht schreiben...',
                          hintStyle: TextStyle(
                            color: AppColors.textSecondary(context),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          prefixIcon: Icon(
                            Icons.chat_bubble_outline_rounded,
                            size: 16,
                            color: AppColors.textSecondary(context),
                          ),
                          filled: true,
                          fillColor: AppColors.surfaceLight(context),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: AppColors.border(context),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: AppColors.border(context),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _isSending ? null : _sendPrivateMessage,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(12),
                        minimumSize: const Size(44, 44),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isSending
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(Icons.send_rounded, size: 18),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
