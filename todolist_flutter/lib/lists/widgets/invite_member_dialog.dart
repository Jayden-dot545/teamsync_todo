import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todolist_client/todolist_client.dart';
import '../../core/constants.dart';
import '../../core/localization_helper.dart';
import '../../core/widgets/role_selection_card.dart';
import '../list_controller.dart';

enum ListInviteTab { link, email }

class InviteMemberDialog extends StatefulWidget {
  final ListController listController;
  final TodoList todoList;

  const InviteMemberDialog({
    super.key,
    required this.listController,
    required this.todoList,
  });

  @override
  State<InviteMemberDialog> createState() => _InviteMemberDialogState();
}

class _InviteMemberDialogState extends State<InviteMemberDialog> {
  ListInviteTab _currentTab = ListInviteTab.link;
  final _emailController = TextEditingController();
  MemberRole _selectedRole = MemberRole.editor;
  bool _isInviting = false;
  bool _isCopied = false;
  String? _inviteCode;
  bool _isLoadingCode = true;
  List<TodoListMember> _members = [];
  bool _isLoadingMembers = true;

  @override
  void initState() {
    super.initState();
    _loadMembers();
    _loadInviteCode();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _loadInviteCode() async {
    setState(() => _isLoadingCode = true);
    final code = await widget.listController.getOrCreateInviteCode(
      widget.todoList.id!,
    );
    if (mounted) {
      setState(() {
        _inviteCode = code;
        _isLoadingCode = false;
      });
    }
  }

  String get _fullInviteLink => _inviteCode != null && _inviteCode!.isNotEmpty
      ? 'https://teamsync.app/join/$_inviteCode'
      : '';

  Future<void> _copyInviteLink() async {
    if (_fullInviteLink.isEmpty) return;
    await Clipboard.setData(ClipboardData(text: _fullInviteLink));
    if (mounted) {
      setState(() => _isCopied = true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Einladungslink in Zwischenablage kopiert! 📋',
            style: TextStyle(color: AppColors.text(context)),
          ),
          backgroundColor: AppColors.surface(context),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: AppColors.border(context)),
          ),
        ),
      );
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) setState(() => _isCopied = false);
      });
    }
  }

  Future<void> _loadMembers() async {
    setState(() => _isLoadingMembers = true);
    final members = await widget.listController.getMembers(widget.todoList.id!);
    if (mounted) {
      setState(() {
        _members = members;
        _isLoadingMembers = false;
      });
    }
  }

  Future<void> _invite() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) return;
    setState(() => _isInviting = true);
    try {
      await widget.listController.inviteMember(
        listId: widget.todoList.id!,
        email: email,
        role: _selectedRole,
      );
      _emailController.clear();
      await _loadMembers();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '$email erfolgreich als ${AppColors.getRoleLabel(_selectedRole)} hinzugefügt!',
            ),
            backgroundColor: AppColors.priorityLow,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Fehler beim Einladen: $e'),
            backgroundColor: AppColors.priorityHigh,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isInviting = false);
    }
  }

  Future<void> _removeMember(TodoListMember member) async {
    final success = await widget.listController.removeMember(
      listId: widget.todoList.id!,
      memberUserId: member.userId,
      memberId: member.id,
    );
    if (success) await _loadMembers();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.surface(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
        side: BorderSide(color: AppColors.border(context), width: 1.2),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520, maxHeight: 680),
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
                      color: AppColors.primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.group_add_outlined,
                      color: AppColors.primary,
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
                              ? 'Manage Team Members'
                              : 'Teammitglieder verwalten',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.text(context),
                          ),
                        ),
                        Text(
                          '${context.isEn ? 'Project' : 'Projekt'}: ${widget.todoList.title}',
                          style: TextStyle(
                            fontSize: 11,
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
                      size: 20,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: AppColors.border(context)),

            // Body
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SegmentedButton<ListInviteTab>(
                      segments: [
                        ButtonSegment(
                          value: ListInviteTab.link,
                          label: Text(
                            context.isEn ? '🔗 Share Link' : '🔗 Link teilen',
                          ),
                          icon: const Icon(Icons.link_rounded, size: 16),
                        ),
                        ButtonSegment(
                          value: ListInviteTab.email,
                          label: Text(
                            context.isEn ? '✉️ Via Email' : '✉️ Per E-Mail',
                          ),
                          icon: const Icon(Icons.email_outlined, size: 16),
                        ),
                      ],
                      selected: {_currentTab},
                      onSelectionChanged: (set) =>
                          setState(() => _currentTab = set.first),
                    ),
                    const SizedBox(height: 16),

                    if (_currentTab == ListInviteTab.link)
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceLight(context),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.border(context)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.isEn
                                  ? 'Invite Code:'
                                  : 'Einladungscode:',
                              style: TextStyle(
                                fontSize: 11,
                                color: AppColors.textSecondary(context),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    _isLoadingCode
                                        ? (context.isEn
                                            ? 'Loading code...'
                                            : 'Code wird geladen...')
                                        : (_inviteCode ??
                                            (context.isEn
                                                ? 'No Code'
                                                : 'Kein Code')),
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2.0,
                                      color: AppColors.text(context),
                                    ),
                                  ),
                                ),
                                IconButton.filled(
                                  onPressed:
                                      _isLoadingCode || _inviteCode == null
                                      ? null
                                      : _copyInviteLink,
                                  icon: Icon(
                                    _isCopied
                                        ? Icons.check_rounded
                                        : Icons.copy_rounded,
                                    size: 18,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              context.isEn
                                  ? 'Anyone with this code or link can join the list immediately.'
                                  : 'Jeder mit diesem Code oder Link kann der Liste sofort beitreten.',
                              style: TextStyle(
                                fontSize: 11,
                                color: AppColors.textSecondary(context),
                              ),
                            ),
                          ],
                        ),
                      )
                    else ...[
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(
                          color: AppColors.text(context),
                          fontSize: 13.5,
                        ),
                        decoration: InputDecoration(
                          labelText: context.isEn
                              ? 'Email Address'
                              : 'E-Mail-Adresse',
                          hintText: context.isEn
                              ? 'teammate@company.com'
                              : 'kollege@firma.de',
                          prefixIcon: const Icon(
                            Icons.mail_outline_rounded,
                            size: 18,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      RoleSelectionCard(
                        role: MemberRole.editor,
                        selectedRole: _selectedRole,
                        onSelected: (r) => setState(() => _selectedRole = r),
                      ),
                      const SizedBox(height: 8),
                      RoleSelectionCard(
                        role: MemberRole.viewer,
                        selectedRole: _selectedRole,
                        onSelected: (r) => setState(() => _selectedRole = r),
                      ),
                      const SizedBox(height: 14),
                      ElevatedButton.icon(
                        onPressed: _isInviting ? null : _invite,
                        icon: _isInviting
                            ? const SizedBox(
                                width: 14,
                                height: 14,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Icon(Icons.send_rounded, size: 16),
                        label: Text(
                          context.isEn ? 'Send Invite' : 'Einladung senden',
                        ),
                      ),
                    ],

                    const SizedBox(height: 22),
                    Text(
                      '${context.isEn ? 'MEMBERS' : 'MITGLIEDER'} (${_members.length})',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8,
                        color: AppColors.textSecondary(context),
                      ),
                    ),
                    const SizedBox(height: 10),

                    if (_isLoadingMembers)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      )
                    else if (_members.isEmpty)
                      Text(
                        context.isEn
                            ? 'No other members yet.'
                            : 'Noch keine weiteren Mitglieder.',
                        style: TextStyle(
                          color: AppColors.textSecondary(context),
                          fontSize: 12,
                        ),
                      )
                    else
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _members.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 6),
                        itemBuilder: (context, index) {
                          final m = _members[index];
                          final isOwner = m.role == MemberRole.owner;
                          final roleColor = m.role == MemberRole.owner
                              ? AppColors.ownerColor
                              : (m.role == MemberRole.editor
                                    ? AppColors.editorColor
                                    : AppColors.viewerColor);

                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceLight(context),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: AppColors.border(context),
                              ),
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 16,
                                  backgroundColor: roleColor.withValues(
                                    alpha: 0.2,
                                  ),
                                  child: Text(
                                    (m.userName ?? m.userEmail ?? '?')
                                        .substring(0, 1)
                                        .toUpperCase(),
                                    style: TextStyle(
                                      color: roleColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        m.userName ??
                                            m.userEmail ??
                                            (context.isEn
                                                ? 'Unknown'
                                                : 'Unbekannt'),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                          color: AppColors.text(context),
                                        ),
                                      ),
                                      Text(
                                        AppColors.getRoleLabel(m.role),
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: roleColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (!isOwner)
                                  IconButton(
                                    icon: const Icon(
                                      Icons.remove_circle_outline_rounded,
                                      color: AppColors.priorityHigh,
                                      size: 18,
                                    ),
                                    onPressed: () => _removeMember(m),
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

            // Footer
            Divider(height: 1, color: AppColors.border(context)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(context.l10n.close),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
