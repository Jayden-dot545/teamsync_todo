import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/client.dart';
import '../../core/constants.dart';
import '../../core/localization_helper.dart';
import '../../core/widgets/color_picker_row.dart';
import '../../core/widgets/role_selection_card.dart';
import '../../core/widgets/team_sync_logo.dart';
import '../list_controller.dart';

enum InviteMethod { link, email }

class TeamLeadInviteDialog extends StatefulWidget {
  final ListController listController;
  final TodoList? initialList;

  const TeamLeadInviteDialog({
    super.key,
    required this.listController,
    this.initialList,
  });

  @override
  State<TeamLeadInviteDialog> createState() => _TeamLeadInviteDialogState();
}

class _TeamLeadInviteDialogState extends State<TeamLeadInviteDialog> {
  late int
  _step; // 0 = Choose Mode, 1 = Boss Create & Share, 2 = Invite to Existing
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  int _selectedColor = AppColors.listColors.first;

  InviteMethod _inviteMethod = InviteMethod.link;
  final _emailController = TextEditingController();
  MemberRole _selectedRole = MemberRole.editor;

  TodoList? _selectedExistingList;
  String? _inviteCode;
  bool _isLoading = false;
  bool _isCopied = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    if (widget.initialList != null) {
      _step = 2;
      _selectedExistingList = widget.initialList;
      _loadInviteCode(widget.initialList!.id!);
    } else {
      _step = 0;
      final myId = client.auth.authInfo?.authUserId;
      final owned = widget.listController.lists
          .where((l) => l.ownerId == myId)
          .toList();
      if (owned.isNotEmpty) {
        _selectedExistingList = owned.first;
        if (_selectedExistingList?.id != null) {
          _loadInviteCode(_selectedExistingList!.id!);
        }
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _loadInviteCode(int listId) async {
    setState(() => _isLoading = true);
    final code = await widget.listController.getOrCreateInviteCode(listId);
    if (mounted) {
      setState(() {
        _inviteCode = code;
        _isLoading = false;
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

  Future<void> _createAndShare() async {
    final title = _titleController.text.trim();
    if (title.isEmpty) return;
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final newList = await widget.listController.createList(
      title: title,
      description: _descController.text.trim().isEmpty
          ? null
          : _descController.text.trim(),
      color: _selectedColor,
    );

    if (newList != null && newList.id != null) {
      final code = await widget.listController.getOrCreateInviteCode(
        newList.id!,
      );
      if (_inviteMethod == InviteMethod.email &&
          _emailController.text.trim().isNotEmpty) {
        await widget.listController.inviteMember(
          listId: newList.id!,
          email: _emailController.text.trim(),
          role: _selectedRole,
        );
      }
      if (mounted) {
        setState(() {
          _selectedExistingList = newList;
          _inviteCode = code;
          _step = 2;
          _isLoading = false;
        });
      }
    } else {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage =
              widget.listController.errorMessage ?? 'Fehler beim Erstellen';
        });
      }
    }
  }

  Future<void> _sendEmailInvite() async {
    final email = _emailController.text.trim();
    if (email.isEmpty || _selectedExistingList?.id == null) return;
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final member = await widget.listController.inviteMember(
        listId: _selectedExistingList!.id!,
        email: email,
        role: _selectedRole,
      );
      if (mounted) {
        setState(() => _isLoading = false);
        if (member != null) {
          _emailController.clear();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Einladung erfolgreich versendet! ✉️',
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
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = e.toString();
        });
      }
    }
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
        constraints: const BoxConstraints(maxWidth: 520),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Row(
                children: [
                  const TeamSyncLogo(size: 28, showGlow: false),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _step == 0
                          ? (context.isEn
                                ? 'Start Team Collaboration'
                                : 'Team-Kollaboration starten')
                          : (_step == 1
                                ? (context.isEn
                                    ? 'Lead Mode: Create List'
                                    : 'Chef-Modus: Liste erstellen')
                                : (context.isEn
                                    ? 'Invite Members'
                                    : 'Mitglieder einladen')),
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: AppColors.text(context),
                      ),
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
              const SizedBox(height: 16),

              if (_errorMessage != null)
                Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.priorityHigh.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(
                      color: AppColors.priorityHigh,
                      fontSize: 12,
                    ),
                  ),
                ),

              // Step 0: Choose Mode
              if (_step == 0) ...[
                _buildModeCard(
                  icon: Icons.admin_panel_settings_rounded,
                  color: AppColors.primary,
                  title: context.isEn
                      ? '👑 Create & Share New List as Lead'
                      : '👑 Neue Liste als Chef erstellen & teilen',
                  subtitle: context.isEn
                      ? 'Create a new ToDo list and invite teammates or viewers directly via link/email.'
                      : 'Erstelle eine neue ToDo-Liste und lade Mitarbeiter oder Zuschauer direkt mit Link/E-Mail ein.',
                  onTap: () => setState(() => _step = 1),
                ),
                const SizedBox(height: 12),
                _buildModeCard(
                  icon: Icons.group_add_rounded,
                  color: AppColors.secondary,
                  title: context.isEn
                      ? '👥 Invite to Existing List'
                      : '👥 Zu bestehender Liste einladen',
                  subtitle: context.isEn
                      ? 'Select one of your lists and create an invite link or send emails.'
                      : 'Wähle eine deiner Listen aus und erstelle einen Einladungs-Link oder verschicke E-Mails.',
                  onTap: () => setState(() => _step = 2),
                ),
              ]
              // Step 1: Create New List as Boss
              else if (_step == 1) ...[
                TextField(
                  controller: _titleController,
                  autofocus: true,
                  style: TextStyle(
                    color: AppColors.text(context),
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    labelText: context.isEn
                        ? 'Project Name / List Title'
                        : 'Projektname / Listen-Titel',
                    hintText: context.isEn
                        ? 'e.g. Sprint Q4, Marketing, Household'
                        : 'z. B. Sprint Q4, Marketing, Haushalt',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _descController,
                  style: TextStyle(
                    color: AppColors.text(context),
                    fontSize: 13,
                  ),
                  decoration: InputDecoration(
                    labelText: context.isEn
                        ? 'Description (Optional)'
                        : 'Beschreibung (Optional)',
                    hintText: context.isEn
                        ? 'Goals or instructions for team'
                        : 'Ziele oder Anweisungen fürs Team',
                  ),
                ),
                const SizedBox(height: 14),
                ColorPickerRow(
                  selectedColor: _selectedColor,
                  onColorSelected: (c) => setState(() => _selectedColor = c),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    TextButton(
                      onPressed: () => setState(() => _step = 0),
                      child: Text(
                        context.isEn ? 'Back' : 'Zurück',
                        style: TextStyle(
                          color: AppColors.textSecondary(context),
                        ),
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _createAndShare,
                      child: _isLoading
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              context.isEn
                                  ? 'Create & Invite'
                                  : 'Erstellen & Einladen',
                            ),
                    ),
                  ],
                ),
              ]
              // Step 2: Invite to List (Tabs: Link vs Email)
              else if (_step == 2) ...[
                if (widget.initialList == null &&
                    widget.listController.lists.isNotEmpty) ...[
                  DropdownButtonFormField<TodoList>(
                    initialValue: _selectedExistingList,
                    dropdownColor: AppColors.surface(context),
                    decoration: InputDecoration(
                      labelText: context.isEn
                          ? 'Select List'
                          : 'Liste auswählen',
                      isDense: true,
                    ),
                    items: widget.listController.lists
                        .map(
                          (l) => DropdownMenuItem(
                            value: l,
                            child: Text(
                              l.title,
                              style: TextStyle(color: AppColors.text(context)),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (val) {
                      if (val?.id != null) {
                        setState(() => _selectedExistingList = val);
                        _loadInviteCode(val!.id!);
                      }
                    },
                  ),
                  const SizedBox(height: 14),
                ],

                // Method Switcher
                SegmentedButton<InviteMethod>(
                  segments: [
                    ButtonSegment(
                      value: InviteMethod.link,
                      label: Text(
                        context.isEn ? '🔗 Invite Link' : '🔗 Einladungslink',
                      ),
                      icon: const Icon(Icons.link_rounded, size: 16),
                    ),
                    ButtonSegment(
                      value: InviteMethod.email,
                      label: Text(
                        context.isEn ? '✉️ Via Email' : '✉️ Per E-Mail',
                      ),
                      icon: const Icon(Icons.email_outlined, size: 16),
                    ),
                  ],
                  selected: {_inviteMethod},
                  onSelectionChanged: (set) =>
                      setState(() => _inviteMethod = set.first),
                ),
                const SizedBox(height: 16),

                if (_inviteMethod == InviteMethod.link) ...[
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
                          context.isEn ? 'Invite Code:' : 'Einladungscode:',
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
                                _isLoading
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
                              onPressed: _isLoading || _inviteCode == null
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
                              ? 'Anyone with this link can join the list immediately.'
                              : 'Jeder mit diesem Link kann der Liste direkt beitreten.',
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.textSecondary(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ] else ...[
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
                    onPressed: _isLoading ? null : _sendEmailInvite,
                    icon: _isLoading
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
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModeCard({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight(context),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border(context)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.bold,
                      color: AppColors.text(context),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.textSecondary(context),
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14,
              color: AppColors.textSecondary(context),
            ),
          ],
        ),
      ),
    );
  }
}
