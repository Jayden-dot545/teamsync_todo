import 'package:flutter/material.dart';
import 'package:todolist_client/todolist_client.dart';
import '../../core/constants.dart';
import '../../core/localization_helper.dart';
import '../todo_controller.dart';
import 'member_profile_dialog.dart';

class ListChatDrawer extends StatefulWidget {
  final TodoController todoController;
  final TodoList todoList;

  const ListChatDrawer({
    super.key,
    required this.todoController,
    required this.todoList,
  });

  @override
  State<ListChatDrawer> createState() => _ListChatDrawerState();
}

class _ListChatDrawerState extends State<ListChatDrawer> {
  final TextEditingController _msgController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<TodoChatMessage> _messages = [];
  bool _isLoading = true;
  bool _isSending = false;
  bool _showOnlyPrivateDMs = false;

  @override
  void initState() {
    super.initState();
    _loadMessages();

    // Listen for live chat messages
    widget.todoController.onEvent.listen((event) {
      if (!mounted) return;
      if (event.eventType == TodoEventType.chatMessageSent &&
          event.chatMessage != null) {
        setState(() {
          _messages.add(event.chatMessage!);
        });
        _scrollToBottom();
      }
    });
  }

  @override
  void dispose() {
    _msgController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadMessages() async {
    setState(() => _isLoading = true);
    final msgs = await widget.todoController.fetchChatMessages(
      widget.todoList.id!,
    );
    if (mounted) {
      setState(() {
        _messages.clear();
        _messages.addAll(msgs);
        _isLoading = false;
      });
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _sendMessage() async {
    final text = _msgController.text.trim();
    if (text.isEmpty || _isSending) return;

    setState(() => _isSending = true);
    _msgController.clear();

    final success = await widget.todoController.sendChatMessage(
      listId: widget.todoList.id!,
      message: text,
    );

    if (mounted) {
      setState(() => _isSending = false);
      if (!success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              context.isEn
                  ? 'Failed to send message.'
                  : 'Nachricht konnte nicht gesendet werden.',
            ),
            backgroundColor: AppColors.priorityHigh,
          ),
        );
      }
    }
  }

  void _openMemberProfileForUser(
    UuidValue senderUserId,
    String senderName,
    MemberRole senderRole,
  ) {
    final existingMember = widget.todoController.members.firstWhere(
      (m) => m.userId == senderUserId,
      orElse: () => TodoListMember(
        todoListId: widget.todoList.id!,
        userId: senderUserId,
        userName: senderName,
        role: senderRole,
        joinedAt: DateTime.now(),
      ),
    );

    showDialog(
      context: context,
      builder: (_) => MemberProfileDialog(
        member: existingMember,
        todoController: widget.todoController,
        listId: widget.todoList.id!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isViewer = widget.todoController.isViewer;
    final currentUserId = widget.todoController.currentUserId;
    final isLight = AppColors.isLight(context);

    final displayedMessages = _showOnlyPrivateDMs
        ? _messages.where((m) => m.isPrivate == true).toList()
        : _messages;

    return Drawer(
      width: MediaQuery.of(context).size.width > 480
          ? 420
          : MediaQuery.of(context).size.width * 0.90,
      backgroundColor: AppColors.surface(context),
      child: SafeArea(
        child: Column(
          children: [
            // Drawer Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.surface(context),
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.border(context),
                    width: 1.0,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.chat_bubble_outline_rounded,
                          color: isLight
                              ? const Color(0xFF0284C7)
                              : AppColors.primary,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.isEn
                                  ? 'Team Discussion'
                                  : 'Team-Diskussion',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.text(context),
                              ),
                            ),
                            Text(
                              widget.todoList.title,
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary(context),
                              ),
                              overflow: TextOverflow.ellipsis,
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
                  const SizedBox(height: 8),
                  // Chat Filter Switcher (Alle vs Private DMs)
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () =>
                              setState(() => _showOnlyPrivateDMs = false),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            decoration: BoxDecoration(
                              color: !_showOnlyPrivateDMs
                                  ? AppColors.primary.withValues(
                                      alpha: isLight ? 0.15 : 0.2,
                                    )
                                  : AppColors.surfaceLight(context),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: !_showOnlyPrivateDMs
                                    ? (isLight
                                          ? const Color(0xFF0284C7)
                                          : AppColors.primary)
                                    : AppColors.border(context),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '💬 ${context.isEn ? "Team Chat" : "Team-Chat"} (${_messages.where((m) => m.isPrivate != true).length})',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: !_showOnlyPrivateDMs
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: !_showOnlyPrivateDMs
                                      ? (isLight
                                            ? const Color(0xFF0284C7)
                                            : Colors.white)
                                      : AppColors.textSecondary(context),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: GestureDetector(
                          onTap: () =>
                              setState(() => _showOnlyPrivateDMs = true),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            decoration: BoxDecoration(
                              color: _showOnlyPrivateDMs
                                  ? AppColors.secondary.withValues(
                                      alpha: isLight ? 0.15 : 0.25,
                                    )
                                  : AppColors.surfaceLight(context),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: _showOnlyPrivateDMs
                                    ? AppColors.secondary
                                    : AppColors.border(context),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '🔒 ${context.isEn ? "Direct Messages" : "Private DMs"} (${_messages.where((m) => m.isPrivate == true).length})',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: _showOnlyPrivateDMs
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: _showOnlyPrivateDMs
                                      ? AppColors.secondary
                                      : AppColors.textSecondary(context),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Messages View
            Expanded(
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : displayedMessages.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              _showOnlyPrivateDMs
                                  ? Icons.lock_outline_rounded
                                  : Icons.chat_bubble_outline_rounded,
                              size: 44,
                              color: AppColors.textSecondary(context),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              _showOnlyPrivateDMs
                                  ? (context.isEn
                                      ? 'No direct messages'
                                      : 'Keine privaten Direktnachrichten')
                                  : (context.isEn
                                      ? 'No messages yet'
                                      : 'Noch keine Nachrichten'),
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: AppColors.text(context),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              _showOnlyPrivateDMs
                                  ? (context.isEn
                                      ? 'Tap on a member profile to send a private message.'
                                      : 'Tippe auf das Profil eines Mitglieds, um eine private Nachricht zu senden.')
                                  : isViewer
                                  ? (context.isEn
                                      ? 'Once team lead or editors write messages, they will appear here live.'
                                      : 'Sobald Chef oder Arbeiter Nachrichten schreiben, erscheinen sie hier live.')
                                  : (context.isEn
                                      ? 'Start the discussion with your team!'
                                      : 'Starte die Diskussion mit deinem Team!'),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      itemCount: displayedMessages.length,
                      itemBuilder: (context, index) {
                        final msg = displayedMessages[index];
                        final isMe =
                            currentUserId != null &&
                            msg.senderUserId == currentUserId;
                        return _buildMessageBubble(msg, isMe);
                      },
                    ),
            ),

            // Input Bar OR Viewer Read-Only Banner
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface(context),
                border: Border(
                  top: BorderSide(color: AppColors.border(context), width: 1.0),
                ),
              ),
              child: isViewer
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceLight(context),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border(context)),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.visibility_rounded,
                            size: 18,
                            color: AppColors.viewerColor,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              context.isEn
                                  ? 'Viewer mode: You can read along, but cannot send messages.'
                                  : 'Zuschauer-Modus: Du kannst mitlesen, aber keine Nachrichten schreiben.',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary(context),
                                height: 1.25,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _msgController,
                            textCapitalization: TextCapitalization.sentences,
                            onSubmitted: (_) => _sendMessage(),
                            style: TextStyle(
                              color: AppColors.text(context),
                              fontSize: 14,
                            ),
                            decoration: InputDecoration(
                              hintText: context.isEn
                                  ? 'Write a message to everyone...'
                                  : 'Nachricht an alle schreiben...',
                              hintStyle: TextStyle(
                                color: AppColors.textSecondary(context),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              filled: true,
                              fillColor: AppColors.surfaceLight(context),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: BorderSide(
                                  color: AppColors.border(context),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: BorderSide(
                                  color: AppColors.border(context),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: _isSending ? null : _sendMessage,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(14),
                            minimumSize: const Size(48, 48),
                          ),
                          child: _isSending
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Icon(Icons.send_rounded, size: 20),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageBubble(TodoChatMessage msg, bool isMe) {
    final isChef = msg.senderRole == MemberRole.owner;
    final isWorker = msg.senderRole == MemberRole.editor;
    final isPrivate = msg.isPrivate == true;
    final isLight = AppColors.isLight(context);

    final roleLabel = isChef
        ? (context.isEn ? '👑 Lead' : '👑 Chef')
        : isWorker
        ? (context.isEn ? '✏️ Editor' : '✏️ Arbeiter')
        : (context.isEn ? '👁️ Viewer' : '👁️ Zuschauer');

    final roleColor = isChef
        ? const Color(0xFFF59E0B)
        : isWorker
        ? (isLight ? const Color(0xFF0284C7) : AppColors.primary)
        : AppColors.viewerColor;

    final timeStr =
        '${msg.sentAt.hour.toString().padLeft(2, '0')}:${msg.sentAt.minute.toString().padLeft(2, '0')}';

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: isMe
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          // Header row with clickable avatar, sender name, role & time
          GestureDetector(
            onTap: () => _openMemberProfileForUser(
              msg.senderUserId,
              msg.senderName,
              msg.senderRole,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!isMe) ...[
                  CircleAvatar(
                    radius: 10,
                    backgroundColor: roleColor.withValues(alpha: 0.25),
                    child: Text(
                      msg.senderName.substring(0, 1).toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: roleColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                ],
                Text(
                  isMe ? (context.isEn ? 'You' : 'Du') : msg.senderName,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.text(context),
                    decoration: TextDecoration.underline,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 1,
                  ),
                  decoration: BoxDecoration(
                    color: roleColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    roleLabel,
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      color: roleColor,
                    ),
                  ),
                ),
                if (isPrivate) ...[
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 1,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: AppColors.secondary.withValues(alpha: 0.4),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.lock_rounded,
                          size: 9,
                          color: AppColors.secondary,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          msg.recipientName != null
                              ? (context.isEn
                                  ? '🔒 to ${msg.recipientName}'
                                  : '🔒 an ${msg.recipientName}')
                              : (context.isEn ? '🔒 Private' : '🔒 Privat'),
                          style: const TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(width: 6),
                Text(
                  timeStr,
                  style: TextStyle(
                    fontSize: 10,
                    color: AppColors.textSecondary(context),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),

          // Message Bubble
          Container(
            constraints: const BoxConstraints(maxWidth: 300),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: isPrivate
                  ? (isLight
                        ? const Color(0xFFF1F5F9)
                        : const Color(0xFF1E293B))
                  : isMe
                  ? AppColors.primary.withValues(alpha: isLight ? 0.18 : 0.22)
                  : AppColors.surfaceLight(context),
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(14),
                topRight: const Radius.circular(14),
                bottomLeft: Radius.circular(isMe ? 14 : 2),
                bottomRight: Radius.circular(isMe ? 2 : 14),
              ),
              border: Border.all(
                color: isPrivate
                    ? AppColors.secondary.withValues(alpha: 0.5)
                    : isMe
                    ? (isLight
                          ? const Color(0xFF0284C7).withValues(alpha: 0.5)
                          : AppColors.primary.withValues(alpha: 0.45))
                    : AppColors.border(context),
                width: 1.1,
              ),
            ),
            child: Text(
              msg.message,
              style: TextStyle(
                fontSize: 13,
                color: AppColors.text(context),
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
