import 'package:flutter/material.dart';
import '../../core/client.dart';
import '../../core/constants.dart';
import '../../core/debouncer.dart';
import '../../core/localization_helper.dart';
import '../../core/user_prefs.dart';
import '../../core/widgets/app_background.dart';
import '../../core/widgets/skeleton_loading.dart';
import '../../core/widgets/team_sync_logo.dart';
import '../auth/widgets/name_setup_dialog.dart';
import '../settings/settings_dialog.dart';
import '../todos/todo_list_screen.dart';
import 'list_controller.dart';
import 'widgets/create_list_dialog.dart';
import 'widgets/hero_stats_banner.dart';
import 'widgets/join_list_dialog.dart';
import 'widgets/list_card.dart';
import 'widgets/quick_templates_view.dart';
import 'widgets/team_lead_invite_dialog.dart';

enum ListTabFilter { all, owned, shared }

class ListOverviewScreen extends StatefulWidget {
  const ListOverviewScreen({super.key});

  @override
  State<ListOverviewScreen> createState() => _ListOverviewScreenState();
}

class _ListOverviewScreenState extends State<ListOverviewScreen> {
  final _listController = ListController();
  final _searchController = TextEditingController();
  final _searchDebouncer = Debouncer(milliseconds: 250);
  String _searchQuery = '';
  ListTabFilter _selectedTab = ListTabFilter.all;

  @override
  void initState() {
    super.initState();
    _listController.fetchLists();
    _listController.addListener(_onControllerUpdate);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await UserPrefs.syncFromServer();
      if (!mounted) return;
      if (UserPrefs.displayNameNotifier.value == null ||
          UserPrefs.displayNameNotifier.value!.trim().isEmpty) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => NameSetupDialog(onNameSaved: () => setState(() {})),
        );
      }
    });
  }

  @override
  void dispose() {
    _searchDebouncer.dispose();
    _listController.removeListener(_onControllerUpdate);
    _listController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onControllerUpdate() {
    if (mounted) setState(() {});
  }

  void _onSearchChanged(String val) {
    _searchDebouncer.run(() {
      if (mounted) setState(() => _searchQuery = val.trim());
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = client.auth.authInfo?.authUserId;

    final lists = _listController.lists.where((l) {
      if (_selectedTab == ListTabFilter.owned && l.ownerId != currentUserId) {
        return false;
      }
      if (_selectedTab == ListTabFilter.shared && l.ownerId == currentUserId) {
        return false;
      }
      if (_searchQuery.isEmpty) return true;
      final query = _searchQuery.toLowerCase();
      return l.title.toLowerCase().contains(query) ||
          (l.description?.toLowerCase().contains(query) ?? false);
    }).toList();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AppBackground(
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: _listController.fetchLists,
            color: AppColors.primary,
            backgroundColor: AppColors.surfaceDark,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              slivers: [
                _buildTopBar(),
                SliverToBoxAdapter(
                  child: HeroStatsBanner(listController: _listController),
                ),
                SliverToBoxAdapter(
                  child: QuickTemplatesView(listController: _listController),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 12)),
                _buildSearchBar(),
                _buildFilterTabs(),
                _buildContent(lists),
                const SliverToBoxAdapter(child: SizedBox(height: 80)),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
          context: context,
          builder: (_) => CreateListDialog(listController: _listController),
        ),
        icon: const Icon(Icons.add_rounded),
        label: Text(
          context.l10n.newList,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      sliver: SliverToBoxAdapter(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => showDialog(
                    context: context,
                    builder: (_) =>
                        NameSetupDialog(onNameSaved: () => setState(() {})),
                  ),
                  child: const TeamSyncLogo(size: 28, showGlow: false),
                ),
                const SizedBox(width: 14),
                ValueListenableBuilder<String?>(
                  valueListenable: UserPrefs.displayNameNotifier,
                  builder: (context, userName, _) {
                    final hasName =
                        userName != null && userName.trim().isNotEmpty;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              hasName
                                  ? (context.l10n.localeName.startsWith('en')
                                      ? 'Hello, ${userName.trim()}'
                                      : 'Hallo, ${userName.trim()}')
                                  : context.l10n.myLists,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: AppColors.text(context),
                              ),
                            ),
                            const SizedBox(width: 6),
                            GestureDetector(
                              onTap: () => showDialog(
                                context: context,
                                builder: (_) => NameSetupDialog(
                                  onNameSaved: () => setState(() {}),
                                ),
                              ),
                              child: Icon(
                                Icons.edit_outlined,
                                size: 16,
                                color: AppColors.textSecondary(context),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          context.l10n.localeName.startsWith('en')
                              ? '${_listController.lists.length} ${_listController.lists.length == 1 ? "list" : "lists"} active'
                              : '${_listController.lists.length} ${_listController.lists.length == 1 ? "Liste" : "Listen"} aktiv',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary(context),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
            Row(
              children: [
                OutlinedButton.icon(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (_) =>
                        JoinListDialog(listController: _listController),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.text(context),
                    side: BorderSide(
                      color: AppColors.border(context),
                      width: 1.2,
                    ),
                    backgroundColor: AppColors.surface(context),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(
                    Icons.login_rounded,
                    size: 16,
                    color: Color(0xFF0284C7),
                  ),
                  label: Text(
                    context.l10n.localeName.startsWith('en')
                        ? 'Join'
                        : 'Beitreten',
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (_) =>
                        TeamLeadInviteDialog(listController: _listController),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.text(context),
                    side: BorderSide(
                      color: AppColors.border(context),
                      width: 1.2,
                    ),
                    backgroundColor: AppColors.surface(context),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(
                    Icons.share_rounded,
                    size: 16,
                    color: AppColors.primary,
                  ),
                  label: Text(
                    context.l10n.localeName.startsWith('en')
                        ? 'Share / Invite'
                        : 'Teilen / Einladen',
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                _buildAvatarButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatarButton() {
    return ValueListenableBuilder<int>(
      valueListenable: UserPrefs.avatarIndexNotifier,
      builder: (context, avatarIdx, _) {
        final emoji = avatarIdx < UserPrefs.avatarEmojis.length
            ? UserPrefs.avatarEmojis[avatarIdx]
            : '👑';
        return Tooltip(
          message: context.l10n.settings,
          child: InkWell(
            onTap: () => showDialog(
              context: context,
              builder: (_) => SettingsDialog(listController: _listController),
            ),
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: AppColors.surfaceLight(context),
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.6),
                  width: 1.5,
                ),
              ),
              alignment: Alignment.center,
              child: Text(emoji, style: const TextStyle(fontSize: 18)),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSearchBar() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
      sliver: SliverToBoxAdapter(
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surface(context),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.border(context)),
          ),
          child: TextField(
            controller: _searchController,
            onChanged: _onSearchChanged,
            style: TextStyle(color: AppColors.text(context), fontSize: 14),
            decoration: InputDecoration(
              hintText: context.l10n.searchLists,
              hintStyle: TextStyle(
                color: AppColors.textSecondary(context),
                fontSize: 14,
              ),
              prefixIcon: const Icon(
                Icons.search_rounded,
                size: 20,
                color: AppColors.primary,
              ),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear_rounded, size: 18),
                      onPressed: () {
                        _searchController.clear();
                        _onSearchChanged('');
                      },
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterTabs() {
    final tabs = [
      (ListTabFilter.all, context.l10n.allTab),
      (ListTabFilter.owned, context.l10n.ownedTab),
      (ListTabFilter.shared, context.l10n.sharedTab),
    ];

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      sliver: SliverToBoxAdapter(
        child: Row(
          children: tabs.map((tab) {
            final (filter, label) = tab;
            final isSelected = _selectedTab == filter;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ChoiceChip(
                label: Text(label),
                selected: isSelected,
                selectedColor: AppColors.primary,
                backgroundColor: AppColors.surfaceLight(context),
                labelStyle: TextStyle(
                  fontSize: 12.5,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? Colors.white : AppColors.text(context),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.border(context),
                  ),
                ),
                showCheckmark: false,
                onSelected: (_) => setState(() => _selectedTab = filter),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildContent(List<TodoList> lists) {
    if (_listController.isLoading && lists.isEmpty) {
      return SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            (_, _) => const Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: SkeletonCard(height: 100),
            ),
            childCount: 3,
          ),
        ),
      );
    }

    if (lists.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _searchQuery.isNotEmpty
                    ? Icons.search_off_rounded
                    : Icons.playlist_add_rounded,
                size: 64,
                color: AppColors.textSecondary(context).withValues(alpha: 0.4),
              ),
              const SizedBox(height: 16),
              Text(
                _searchQuery.isNotEmpty
                    ? context.l10n.noListsFound
                    : (context.l10n.localeName.startsWith('en')
                        ? 'No lists yet'
                        : 'Noch keine Listen vorhanden'),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.text(context),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                _searchQuery.isNotEmpty
                    ? (context.l10n.localeName.startsWith('en')
                        ? 'Try a different search term.'
                        : 'Versuche einen anderen Suchbegriff.')
                    : context.l10n.createFirstList,
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary(context),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final list = lists[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: ListCard(
                todoList: list,
                listController: _listController,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => TodoListScreen(
                      todoList: list,
                      listController: _listController,
                    ),
                  ),
                ),
              ),
            );
          },
          childCount: lists.length,
        ),
      ),
    );
  }
}
