import 'package:flutter/material.dart';
import 'package:todolist_client/todolist_client.dart';
import '../core/constants.dart';
import '../core/localization_helper.dart';
import '../core/widgets/app_background.dart';
import '../core/widgets/confetti_overlay.dart';
import '../core/widgets/skeleton_loading.dart';
import '../auth/widgets/user_profile_dialog.dart';
import '../lists/list_controller.dart';
import '../lists/widgets/create_list_dialog.dart';
import '../lists/widgets/invite_member_dialog.dart';
import '../lists/widgets/list_switcher_sheet.dart';
import '../settings/settings_dialog.dart';
import 'todo_controller.dart';
import 'widgets/activity_feed_dialog.dart';
import 'widgets/calendar_view.dart';
import 'widgets/create_todo_sheet.dart';
import 'widgets/eisenhower_matrix_view.dart';
import 'widgets/kanban_board_view.dart';
import 'widgets/list_chat_drawer.dart';
import 'widgets/member_avatar_stack.dart';
import 'widgets/member_profile_dialog.dart';
import 'widgets/notes_dialog.dart';
import 'widgets/time_report_dialog.dart';
import 'widgets/todo_tile.dart';

enum TodoViewMode { list, kanban, calendar, matrix }

class TodoListScreen extends StatefulWidget {
  final TodoList todoList;
  final ListController listController;

  const TodoListScreen({
    super.key,
    required this.todoList,
    required this.listController,
  });

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  late final TodoController _todoController;
  final _quickAddController = TextEditingController();
  final _searchController = TextEditingController();
  bool _isSearching = false;
  TodoViewMode _viewMode = TodoViewMode.list;
  bool _confettiTriggered = false;
  bool _hasPlayedConfetti = false;

  @override
  void initState() {
    super.initState();
    _todoController = TodoController(listId: widget.todoList.id!);
    _todoController.addListener(_onControllerUpdate);
  }

  void _onControllerUpdate() {
    if (mounted) {
      if (_todoController.items.isNotEmpty &&
          _todoController.progress == 1.0 &&
          !_hasPlayedConfetti) {
        _hasPlayedConfetti = true;
        _confettiTriggered = true;
      } else if (_todoController.progress < 1.0) {
        _hasPlayedConfetti = false;
        _confettiTriggered = false;
      }
      setState(() {});
    }
  }

  @override
  void dispose() {
    _todoController.removeListener(_onControllerUpdate);
    _todoController.dispose();
    _quickAddController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _quickAdd() {
    final title = _quickAddController.text.trim();
    if (title.isEmpty) return;
    _todoController.createItem(title: title, priority: TodoPriority.medium);
    _quickAddController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final listColor = Color(widget.todoList.color);
    final items = _todoController.filteredItems;
    final isViewer = _todoController.isViewer;

    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        endDrawer: ListChatDrawer(
          todoController: _todoController,
          todoList: widget.todoList,
        ),
        appBar: _buildAppBar(listColor, isViewer),
        body: SafeArea(
          child: ConfettiOverlay(
            trigger: _confettiTriggered,
            onFinished: () {
              if (mounted) setState(() => _confettiTriggered = false);
            },
            child: Column(
              children: [
                if (isViewer) const _ViewerBanner(),
                _ProgressBanner(
                  controller: _todoController,
                  listColor: listColor,
                ),
                if (_isSearching) _buildSearchField(),
                _buildFilterBar(),
                const SizedBox(height: 6),
                Expanded(
                  child: switch (_viewMode) {
                    TodoViewMode.list => _buildTasksList(items, isViewer),
                    TodoViewMode.kanban => KanbanBoardView(
                        todoController: _todoController,
                        items: items,
                        isViewer: isViewer,
                      ),
                    TodoViewMode.calendar => CalendarView(
                        todoController: _todoController,
                        items: items,
                        isViewer: isViewer,
                      ),
                    TodoViewMode.matrix => EisenhowerMatrixView(
                        todoController: _todoController,
                        items: items,
                        isViewer: isViewer,
                      ),
                  },
                ),
                _buildBottomBar(isViewer),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(Color listColor, bool isViewer) {
    return AppBar(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      foregroundColor: AppColors.text(context),
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.text(context)),
      actionsIconTheme: IconThemeData(color: AppColors.text(context)),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_rounded, color: AppColors.text(context)),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => ListSwitcherSheet(
            listController: widget.listController,
            currentListId: widget.todoList.id!,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: listColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            widget.todoList.title,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: AppColors.text(context),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_down_rounded,
                          color: AppColors.textSecondary(context),
                          size: 20,
                        ),
                      ],
                    ),
                    if (isViewer)
                      Text(
                        context.isEn
                            ? 'Viewer Mode (Live View)'
                            : 'Zuschauer-Modus (Live-Ansicht)',
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.viewerColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        IconButton(
          tooltip: context.isEn
              ? 'Team Notes & Memos'
              : 'Team-Notizen & Memos',
          icon: const Icon(
            Icons.sticky_note_2_outlined,
            color: AppColors.primary,
          ),
          onPressed: () => showDialog(
            context: context,
            builder: (_) => NotesDialog(
              todoList: widget.todoList,
              isViewer: isViewer,
            ),
          ),
        ),
        Builder(
          builder: (ctx) => IconButton(
            tooltip: context.isEn
                ? 'Team Chat & Discussion'
                : 'Team-Diskussion / Chat',
            icon: const Icon(
              Icons.chat_bubble_outline_rounded,
              color: AppColors.primary,
            ),
            onPressed: () => Scaffold.of(ctx).openEndDrawer(),
          ),
        ),
        MemberAvatarStack(
          members: _todoController.members,
          onAddMember: () => showDialog(
            context: context,
            builder: (_) => InviteMemberDialog(
              listController: widget.listController,
              todoList: widget.todoList,
            ),
          ),
          onMemberTap: (member) => showDialog(
            context: context,
            builder: (_) => MemberProfileDialog(
              member: member,
              todoController: _todoController,
              listId: widget.todoList.id!,
            ),
          ),
        ),
        const SizedBox(width: 4),
        PopupMenuButton<String>(
          icon: Icon(Icons.more_vert_rounded, color: AppColors.text(context)),
          color: AppColors.surface(context),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: BorderSide(color: AppColors.border(context)),
          ),
          onSelected: _handleMenuAction,
          itemBuilder: (context) {
            final isOwner =
                widget.todoList.ownerId == widget.listController.currentUserId;
            return [
              _buildMenuItem(
                'notes',
                Icons.sticky_note_2_outlined,
                AppColors.primary,
                context.isEn ? 'Team Notes & Memos' : 'Team-Notizen & Memos',
              ),
              _buildMenuItem(
                'activity',
                Icons.history_rounded,
                AppColors.secondary,
                context.isEn
                    ? 'Activity Feed & History'
                    : 'Aktivitäts-Feed & Verlauf',
              ),
              _buildMenuItem(
                'timeReport',
                Icons.analytics_outlined,
                AppColors.primary,
                context.isEn
                    ? 'Time Tracking & Report'
                    : 'Zeitauswertung & Stundenzettel',
              ),
              _buildMenuItem(
                'profile',
                Icons.badge_outlined,
                AppColors.primary,
                context.isEn
                    ? 'My Profile & Avatar'
                    : 'Mein Profil & Avatar bearbeiten',
              ),
              if (!isViewer)
                _buildMenuItem(
                  'edit',
                  Icons.edit_rounded,
                  AppColors.textSecondary(context),
                  context.isEn
                      ? 'Edit List & Color'
                      : 'Liste bearbeiten & Farbe',
                ),
              _buildMenuItem(
                'invite',
                Icons.person_add_rounded,
                AppColors.textSecondary(context),
                context.isEn
                    ? 'Manage Members & Roles'
                    : 'Mitglieder verwalten & Rollen',
              ),
              _buildMenuItem(
                'settings',
                Icons.settings_rounded,
                AppColors.textSecondary(context),
                context.l10n.settings,
              ),
              const PopupMenuDivider(),
              _buildMenuItem(
                'delete',
                Icons.delete_outline_rounded,
                AppColors.priorityHigh,
                isOwner ? context.l10n.deleteList : context.l10n.leaveList,
              ),
            ];
          },
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  PopupMenuItem<String> _buildMenuItem(
    String value,
    IconData icon,
    Color color,
    String title,
  ) {
    return PopupMenuItem(
      value: value,
      child: Row(
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              color: color == AppColors.priorityHigh
                  ? color
                  : AppColors.text(context),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _handleMenuAction(String action) {
    switch (action) {
      case 'notes':
        showDialog(
          context: context,
          builder: (_) => NotesDialog(
            todoList: widget.todoList,
            isViewer: _todoController.isViewer,
          ),
        );
        break;
      case 'profile':
        showDialog(
          context: context,
          builder: (_) =>
              UserProfileDialog(listController: widget.listController),
        );
        break;
      case 'edit':
        if (!_todoController.isViewer) {
          showDialog(
            context: context,
            builder: (_) => CreateListDialog(
              listController: widget.listController,
              existingList: widget.todoList,
            ),
          );
        }
        break;
      case 'invite':
        showDialog(
          context: context,
          builder: (_) => InviteMemberDialog(
            listController: widget.listController,
            todoList: widget.todoList,
          ),
        );
        break;
      case 'activity':
        showDialog(
          context: context,
          builder: (_) => ActivityFeedDialog(todoList: widget.todoList),
        );
        break;
      case 'timeReport':
        showDialog(
          context: context,
          builder: (_) => TimeReportDialog(
            todoList: widget.todoList,
            items: _todoController.items,
            members: _todoController.members,
          ),
        );
        break;
      case 'settings':
        showDialog(
          context: context,
          builder: (_) => SettingsDialog(listController: widget.listController),
        );
        break;
      case 'delete':
        _confirmDeleteOrLeave(context);
        break;
    }
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.surface(context),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.border(context)),
        ),
        child: TextField(
          controller: _searchController,
          autofocus: true,
          style: TextStyle(fontSize: 13, color: AppColors.text(context)),
          decoration: InputDecoration(
            hintText: context.l10n.localeName.startsWith('en')
                ? 'Search tasks...'
                : 'Aufgaben durchsuchen...',
            hintStyle: TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary(context),
            ),
            prefixIcon: const Icon(
              Icons.search_rounded,
              size: 18,
              color: AppColors.primary,
            ),
            suffixIcon: IconButton(
              icon: const Icon(Icons.close_rounded, size: 16),
              onPressed: () {
                _searchController.clear();
                _todoController.setSearchQuery('');
                setState(() => _isSearching = false);
              },
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 10),
          ),
          onChanged: (val) => _todoController.setSearchQuery(val),
        ),
      ),
    );
  }

  Widget _buildFilterBar() {
    final filters = [
      (TodoFilter.all, context.l10n.filterAll, Icons.list_rounded),
      (TodoFilter.active, context.l10n.filterActive, Icons.radio_button_unchecked_rounded),
      (TodoFilter.completed, context.l10n.filterCompleted, Icons.check_circle_outline_rounded),
      (TodoFilter.highPriority, context.l10n.filterHighPriority, Icons.flag_rounded),
      (TodoFilter.assignedToMe, context.l10n.filterAssignedToMe, Icons.person_outline_rounded),
    ];

    return Container(
      height: 38,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              separatorBuilder: (_, _) => const SizedBox(width: 6),
              itemBuilder: (context, idx) {
                final (filter, label, icon) = filters[idx];
                final isSelected = _todoController.currentFilter == filter;
                return ChoiceChip(
                  avatar: Icon(
                    icon,
                    size: 14,
                    color: isSelected
                        ? Colors.white
                        : AppColors.textSecondary(context),
                  ),
                  label: Text(label),
                  labelStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: isSelected
                        ? FontWeight.w600
                        : FontWeight.normal,
                    color: isSelected ? Colors.white : AppColors.text(context),
                  ),
                  selected: isSelected,
                  selectedColor: AppColors.primary,
                  backgroundColor: AppColors.surfaceLight(context),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.border(context),
                    ),
                  ),
                  showCheckmark: false,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  visualDensity: VisualDensity.compact,
                  onSelected: (_) => _todoController.setFilter(filter),
                );
              },
            ),
          ),
          const SizedBox(width: 6),
          PopupMenuButton<TodoViewMode>(
            initialValue: _viewMode,
            tooltip: context.isEn ? 'Switch View' : 'Ansicht wechseln',
            color: AppColors.surface(context),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: AppColors.border(context)),
            ),
            child: Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: AppColors.surfaceLight(context),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: _viewMode != TodoViewMode.list
                      ? AppColors.primary
                      : AppColors.border(context),
                ),
              ),
              child: Icon(
                switch (_viewMode) {
                  TodoViewMode.list => Icons.format_list_bulleted_rounded,
                  TodoViewMode.kanban => Icons.view_kanban_outlined,
                  TodoViewMode.calendar => Icons.calendar_month_outlined,
                  TodoViewMode.matrix => Icons.grid_view_rounded,
                },
                size: 18,
                color: _viewMode != TodoViewMode.list
                    ? AppColors.primary
                    : AppColors.textSecondary(context),
              ),
            ),
            onSelected: (mode) => setState(() => _viewMode = mode),
            itemBuilder: (context) => [
              _buildViewMenuItem(
                TodoViewMode.list,
                context.isEn ? 'List' : 'Liste',
                Icons.format_list_bulleted_rounded,
              ),
              _buildViewMenuItem(
                TodoViewMode.kanban,
                'Kanban-Board',
                Icons.view_kanban_outlined,
              ),
              _buildViewMenuItem(
                TodoViewMode.calendar,
                context.isEn ? 'Calendar' : 'Kalender',
                Icons.calendar_month_outlined,
              ),
              _buildViewMenuItem(
                TodoViewMode.matrix,
                'Eisenhower-Matrix',
                Icons.grid_view_rounded,
              ),
            ],
          ),
          const SizedBox(width: 4),
          IconButton(
            tooltip: context.isEn ? 'Search' : 'Suche',
            icon: Icon(
              Icons.search_rounded,
              size: 18,
              color: _isSearching
                  ? AppColors.primary
                  : AppColors.textSecondary(context),
            ),
            style: IconButton.styleFrom(
              backgroundColor: AppColors.surfaceLight(context),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: _isSearching
                      ? AppColors.primary
                      : AppColors.border(context),
                ),
              ),
              padding: const EdgeInsets.all(6),
              minimumSize: const Size(36, 36),
            ),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchController.clear();
                  _todoController.setSearchQuery('');
                }
              });
            },
          ),
        ],
      ),
    );
  }

  PopupMenuItem<TodoViewMode> _buildViewMenuItem(
    TodoViewMode mode,
    String label,
    IconData icon,
  ) {
    final isSelected = _viewMode == mode;
    return PopupMenuItem<TodoViewMode>(
      value: mode,
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: isSelected
                ? AppColors.primary
                : AppColors.textSecondary(context),
          ),
          const SizedBox(width: 10),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected ? AppColors.primary : AppColors.text(context),
            ),
          ),
          if (isSelected) ...[
            const Spacer(),
            const Icon(Icons.check_rounded, size: 16, color: AppColors.primary),
          ],
        ],
      ),
    );
  }

  Widget _buildTasksList(List<TodoItem> items, bool isViewer) {
    if (_todoController.isLoading) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: List.generate(
            4,
            (_) => const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: SkeletonCard(height: 72),
            ),
          ),
        ),
      );
    }

    if (items.isEmpty) {
      return RefreshIndicator(
        onRefresh: _todoController.fetchItems,
        color: AppColors.primary,
        backgroundColor: AppColors.surface(context),
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.18),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _todoController.currentFilter == TodoFilter.completed
                        ? Icons.task_alt_rounded
                        : Icons.checklist_rtl_rounded,
                    size: 56,
                    color: AppColors.textSecondary(context).withValues(alpha: 0.4),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _getEmptyStateText(),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary(context),
                    ),
                  ),
                  if (_todoController.errorMessage != null) ...[
                    const SizedBox(height: 10),
                    TextButton.icon(
                      onPressed: _todoController.fetchItems,
                      icon: const Icon(Icons.refresh_rounded, size: 16),
                      label: Text(
                        context.isEn ? 'Try Again' : 'Erneut versuchen',
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _todoController.fetchItems,
      color: AppColors.primary,
      backgroundColor: AppColors.surface(context),
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return TodoTile(
            key: ValueKey(item.id),
            item: item,
            todoController: _todoController,
          );
        },
      ),
    );
  }

  String _getEmptyStateText() => switch (_todoController.currentFilter) {
    TodoFilter.active => context.isEn
        ? 'No open tasks. All done! 🎉'
        : 'Keine offenen Aufgaben. Alles erledigt! 🎉',
    TodoFilter.completed => context.isEn
        ? 'No completed tasks yet.'
        : 'Noch keine erledigten Aufgaben.',
    TodoFilter.highPriority => context.isEn
        ? 'No high priority tasks.'
        : 'Keine Aufgaben mit hoher Priorität.',
    TodoFilter.assignedToMe => context.isEn
        ? 'No tasks currently assigned to you.'
        : 'Dir sind derzeit keine Aufgaben zugewiesen.',
    _ => context.isEn
        ? 'No tasks in this list yet.'
        : 'Noch keine Aufgaben in dieser Liste.',
  };

  Widget _buildBottomBar(bool isViewer) {
    if (isViewer) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.surface(context),
        border: Border(top: BorderSide(color: AppColors.border(context))),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.surfaceLight(context),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border(context)),
              ),
              child: TextField(
                controller: _quickAddController,
                style: TextStyle(fontSize: 14, color: AppColors.text(context)),
                decoration: InputDecoration(
                  hintText: context.isEn
                      ? 'Add task quickly...'
                      : 'Aufgabe schnell hinzufügen...',
                  hintStyle: TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary(context),
                  ),
                  prefixIcon: const Icon(
                    Icons.add_rounded,
                    size: 20,
                    color: AppColors.primary,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                ),
                onSubmitted: (_) => _quickAdd(),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            tooltip: context.isEn ? 'Quick Add' : 'Schnell anlegen',
            icon: const Icon(
              Icons.arrow_upward_rounded,
              color: Colors.white,
              size: 20,
            ),
            style: IconButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              minimumSize: const Size(44, 44),
            ),
            onPressed: _quickAdd,
          ),
          const SizedBox(width: 6),
          IconButton(
            tooltip: context.isEn
                ? 'Detailed task setup (due date, assignees, etc.)'
                : 'Detailliert anlegen (Fälligkeit, Zuweisung, etc.)',
            icon: const Icon(
              Icons.tune_rounded,
              color: AppColors.primary,
              size: 20,
            ),
            style: IconButton.styleFrom(
              backgroundColor: AppColors.surfaceLight(context),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: AppColors.border(context)),
              ),
              minimumSize: const Size(44, 44),
            ),
            onPressed: () => showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (_) => CreateTodoSheet(todoController: _todoController),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmDeleteOrLeave(BuildContext context) async {
    final myId = widget.listController.currentUserId;
    final isOwner = widget.todoList.ownerId == myId;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surface(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(color: AppColors.border(context)),
        ),
        title: Text(
          isOwner ? context.l10n.deleteList : context.l10n.leaveList,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.text(context),
          ),
        ),
        content: Text(
          isOwner
              ? context.l10n.deleteListConfirm(widget.todoList.title)
              : context.l10n.leaveListConfirm(widget.todoList.title),
          style: TextStyle(color: AppColors.textSecondary(context)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(
              context.l10n.cancel,
              style: TextStyle(color: AppColors.textSecondary(context)),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.priorityHigh,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(
              isOwner ? context.l10n.delete : context.l10n.leave,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      if (isOwner) {
        await widget.listController.deleteList(widget.todoList.id!);
      } else {
        await widget.listController.removeMember(
          listId: widget.todoList.id!,
          memberUserId: myId,
        );
      }
      if (context.mounted) Navigator.of(context).pop();
    }
  }
}

class _ViewerBanner extends StatelessWidget {
  const _ViewerBanner();

  @override
  Widget build(BuildContext context) {
    final isLight = AppColors.isLight(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.viewerColor.withValues(alpha: isLight ? 0.15 : 0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.viewerColor.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.visibility_rounded,
            color: AppColors.viewerColor,
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              context.isEn
                  ? 'You are logged in as a Viewer: You see live progress and updates, but cannot edit tasks.'
                  : 'Du bist als Zuschauer eingeloggt: Du siehst den Fortschritt und Erledigungen live, kannst aber keine Aufgaben verändern.',
              style: TextStyle(
                fontSize: 12,
                color: isLight
                    ? const Color(0xFF0F172A)
                    : const Color(0xFFE2E8F0),
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressBanner extends StatelessWidget {
  final TodoController controller;
  final Color listColor;

  const _ProgressBanner({required this.controller, required this.listColor});

  @override
  Widget build(BuildContext context) {
    final isLight = AppColors.isLight(context);
    final progress = controller.progress;
    final isAllDone =
        controller.totalCount > 0 &&
        controller.completedCount == controller.totalCount;

    return RepaintBoundary(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface(context),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isAllDone
                  ? AppColors.priorityLow.withValues(alpha: 0.6)
                  : AppColors.borderSubtle(context),
              width: 1.3,
            ),
            boxShadow: [
              BoxShadow(
                color: (isAllDone ? AppColors.priorityLow : listColor)
                    .withValues(alpha: isLight ? 0.08 : 0.14),
                blurRadius: 14,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: (isAllDone ? AppColors.priorityLow : listColor)
                              .withValues(alpha: 0.16),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          isAllDone
                              ? Icons.verified_rounded
                              : Icons.trending_up_rounded,
                          color: isAllDone ? AppColors.priorityLow : listColor,
                          size: 16,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        context.isEn
                            ? '${controller.completedCount} of ${controller.totalCount} tasks completed'
                            : '${controller.completedCount} von ${controller.totalCount} Aufgaben erledigt',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: AppColors.text(context),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: (isAllDone ? AppColors.priorityLow : listColor)
                          .withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: (isAllDone ? AppColors.priorityLow : listColor)
                            .withValues(alpha: 0.4),
                      ),
                    ),
                    child: Text(
                      '${(progress * 100).toInt()}%',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: isAllDone ? AppColors.priorityLow : listColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.0, end: progress),
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutCubic,
                builder: (context, animatedValue, _) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: animatedValue,
                      minHeight: 8,
                      backgroundColor: AppColors.surfaceLight(context),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        isAllDone ? AppColors.priorityLow : listColor,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
