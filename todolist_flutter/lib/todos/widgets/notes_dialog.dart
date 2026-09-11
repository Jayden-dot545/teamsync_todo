import 'package:flutter/material.dart';
import 'package:todolist_client/todolist_client.dart';
import '../../core/constants.dart';
import '../../core/localization_helper.dart';
import '../note_controller.dart';
import 'edit_note_sheet.dart';

class NotesDialog extends StatefulWidget {
  final TodoList todoList;
  final bool isViewer;

  const NotesDialog({
    super.key,
    required this.todoList,
    required this.isViewer,
  });

  @override
  State<NotesDialog> createState() => _NotesDialogState();
}

class _NotesDialogState extends State<NotesDialog> {
  late final NoteController _noteController;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _noteController = NoteController(listId: widget.todoList.id!);
    _noteController.addListener(_onUpdate);
  }

  void _onUpdate() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _noteController.removeListener(_onUpdate);
    _noteController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _openEditNote([TodoNote? note]) {
    if (widget.isViewer) return;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => EditNoteSheet(
        noteController: _noteController,
        existingNote: note,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLight = AppColors.isLight(context);
    final notes = _noteController.notes;
    final listColor = Color(widget.todoList.color);

    return Dialog(
      backgroundColor: AppColors.surface(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
        side: BorderSide(color: AppColors.border(context), width: 1.2),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 580, maxHeight: 720),
        child: Column(
          children: [
            // Dialog Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: listColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.sticky_note_2_rounded,
                      color: listColor,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.isEn ? 'Team Notes' : 'Team-Notizen',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: AppColors.text(context),
                          ),
                        ),
                        Text(
                          context.isEn
                              ? '${widget.todoList.title} • ${notes.length} ${notes.length == 1 ? "note" : "notes"}'
                              : '${widget.todoList.title} • ${notes.length} ${notes.length == 1 ? "Notiz" : "Notizen"}',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!widget.isViewer)
                    ElevatedButton.icon(
                      onPressed: () => _openEditNote(),
                      icon: const Icon(Icons.add_rounded, size: 16),
                      label: Text(context.isEn ? 'New Note' : 'Neue Notiz'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  const SizedBox(width: 6),
                  IconButton(
                    icon: const Icon(Icons.close_rounded, size: 20),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            // Search Field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Container(
                height: 38,
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight(context),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.borderSubtle(context)),
                ),
                child: TextField(
                  controller: _searchController,
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.text(context),
                  ),
                  decoration: InputDecoration(
                    hintText: context.isEn ? 'Search notes...' : 'Notizen durchsuchen...',
                    hintStyle: TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary(context),
                    ),
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      size: 18,
                      color: AppColors.primary,
                    ),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear_rounded, size: 16),
                            onPressed: () {
                              _searchController.clear();
                              _noteController.setSearchQuery('');
                            },
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 9),
                  ),
                  onChanged: (val) => _noteController.setSearchQuery(val),
                ),
              ),
            ),

            // Notes List / Content
            Expanded(
              child: _noteController.isLoading && notes.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : notes.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.note_add_outlined,
                            size: 48,
                            color: AppColors.textSecondary(context).withValues(
                              alpha: 0.4,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            _noteController.searchQuery.isNotEmpty
                                ? (context.isEn ? 'No notes found' : 'Keine Notizen gefunden')
                                : (context.isEn ? 'No notes in this list yet' : 'Noch keine Notizen in dieser Liste'),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.text(context),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _noteController.searchQuery.isNotEmpty
                                ? (context.isEn ? 'Try a different search term.' : 'Probiere einen anderen Suchbegriff.')
                                : (context.isEn ? 'Capture important thoughts, links, and meeting notes.' : 'Halte wichtige Gedanken, Links und Protokolle fest.'),
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary(context),
                            ),
                          ),
                        ],
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: _noteController.fetchNotes,
                      color: AppColors.primary,
                      backgroundColor: AppColors.surface(context),
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        itemCount: notes.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final note = notes[index];
                          final noteColor = Color(note.color ?? 0xFF38BDF8);

                          return InkWell(
                            onTap: () => _openEditNote(note),
                            borderRadius: BorderRadius.circular(14),
                            child: Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: AppColors.cardBg(context),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: note.isPinned
                                      ? noteColor.withValues(
                                          alpha: isLight ? 0.6 : 0.8,
                                        )
                                      : AppColors.borderSubtle(context),
                                  width: note.isPinned ? 1.5 : 1.0,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: noteColor.withValues(
                                      alpha: isLight ? 0.05 : 0.08,
                                    ),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 8,
                                        height: 8,
                                        decoration: BoxDecoration(
                                          color: noteColor,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          note.title,
                                          style: TextStyle(
                                            fontSize: 14.5,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.text(context),
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      if (note.isPinned)
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 6,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: noteColor.withValues(
                                              alpha: 0.15,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.push_pin_rounded,
                                                size: 11,
                                                color: noteColor,
                                              ),
                                              const SizedBox(width: 3),
                                              Text(
                                                context.isEn ? 'Pinned' : 'Fixiert',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color: noteColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                    ],
                                  ),
                                  if (note.content.isNotEmpty) ...[
                                    const SizedBox(height: 6),
                                    Text(
                                      note.content,
                                      style: TextStyle(
                                        fontSize: 12.5,
                                        color: AppColors.textSecondary(context),
                                        height: 1.35,
                                      ),
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        note.createdByName ?? (context.isEn ? 'Member' : 'Mitarbeiter'),
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.textSecondary(
                                            context,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        '${(note.updatedAt ?? note.createdAt).day}.${(note.updatedAt ?? note.createdAt).month}.${(note.updatedAt ?? note.createdAt).year}',
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
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
