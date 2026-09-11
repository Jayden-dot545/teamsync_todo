import 'package:flutter/material.dart';
import 'package:todolist_client/todolist_client.dart';
import '../../core/constants.dart';
import '../../core/localization_helper.dart';
import '../note_controller.dart';

class EditNoteSheet extends StatefulWidget {
  final NoteController noteController;
  final TodoNote? existingNote;

  const EditNoteSheet({
    super.key,
    required this.noteController,
    this.existingNote,
  });

  @override
  State<EditNoteSheet> createState() => _EditNoteSheetState();
}

class _EditNoteSheetState extends State<EditNoteSheet> {
  late final TextEditingController _titleController;
  late final TextEditingController _contentController;
  late int? _selectedColor;
  late bool _isPinned;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _titleController =
        TextEditingController(text: widget.existingNote?.title ?? '');
    _contentController =
        TextEditingController(text: widget.existingNote?.content ?? '');
    _selectedColor = widget.existingNote?.color ?? 0xFF38BDF8;
    _isPinned = widget.existingNote?.isPinned ?? false;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if (title.isEmpty && content.isEmpty) {
      Navigator.of(context).pop();
      return;
    }

    setState(() => _isSaving = true);

    final finalTitle = title.isEmpty
        ? (context.isEn ? 'Untitled Note' : 'Notiz ohne Titel')
        : title;

    if (widget.existingNote == null) {
      await widget.noteController.createNote(
        title: finalTitle,
        content: content,
        color: _selectedColor,
        isPinned: _isPinned,
      );
    } else {
      await widget.noteController.updateNote(
        noteId: widget.existingNote!.id!,
        title: finalTitle,
        content: content,
        color: _selectedColor,
        isPinned: _isPinned,
      );
    }

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _delete() async {
    if (widget.existingNote == null) return;
    final isEn = context.isEn;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surface(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(color: AppColors.border(context)),
        ),
        title: Text(
          isEn ? 'Delete note?' : 'Notiz löschen?',
          style: TextStyle(
            color: AppColors.text(context),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          isEn
              ? 'Are you sure you want to permanently delete this note?'
              : 'Möchtest du diese Notiz wirklich unwiderruflich aus der Datenbank löschen?',
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
            child: Text(isEn ? 'Delete' : 'Löschen'),
          ),
        ],
      ),
    );

    if (confirm == true && mounted) {
      await widget.noteController.deleteNote(widget.existingNote!.id!);
      if (mounted) Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLight = AppColors.isLight(context);
    final noteColor = Color(_selectedColor ?? 0xFF38BDF8);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface(context),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border.all(color: AppColors.border(context)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        left: 20,
        right: 20,
        top: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag Handle
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.textSecondary(context).withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Header with Pin and Action buttons
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: noteColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.sticky_note_2_rounded,
                  color: noteColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                widget.existingNote == null
                    ? (context.isEn ? 'New Note' : 'Neue Notiz')
                    : (context.isEn ? 'Edit Note' : 'Notiz bearbeiten'),
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: AppColors.text(context),
                ),
              ),
              const Spacer(),
              // Pin Toggle Button
              IconButton(
                tooltip: _isPinned
                    ? (context.isEn ? 'Unpin' : 'Fixierung aufheben')
                    : (context.isEn ? 'Pin to top' : 'Oben anheften'),
                icon: Icon(
                  _isPinned
                      ? Icons.push_pin_rounded
                      : Icons.push_pin_outlined,
                  color: _isPinned
                      ? AppColors.primary
                      : AppColors.textSecondary(context),
                  size: 20,
                ),
                onPressed: () => setState(() => _isPinned = !_isPinned),
              ),
              if (widget.existingNote != null)
                IconButton(
                  tooltip: context.isEn ? 'Delete' : 'Löschen',
                  icon: const Icon(
                    Icons.delete_outline_rounded,
                    color: AppColors.priorityHigh,
                    size: 20,
                  ),
                  onPressed: _delete,
                ),
            ],
          ),
          const SizedBox(height: 12),

          // Title Input
          TextField(
            controller: _titleController,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.text(context),
            ),
            decoration: InputDecoration(
              hintText: context.isEn ? 'Note title...' : 'Titel der Notiz...',
              hintStyle: TextStyle(
                fontSize: 16,
                color: AppColors.textSecondary(context),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
          ),
          const Divider(height: 20),

          // Content Input
          TextField(
            controller: _contentController,
            maxLines: 8,
            minLines: 4,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.text(context),
              height: 1.4,
            ),
            decoration: InputDecoration(
              hintText: context.isEn
                  ? 'Write notes, links, thoughts or details...'
                  : 'Schreibe Notizen, Links, Gedanken oder Details...',
              hintStyle: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary(context),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
          ),
          const SizedBox(height: 14),

          // Color Palette
          Row(
            children: [
              Text(
                context.isEn ? 'Color:' : 'Farbe:',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary(context),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: AppColors.listColors.take(7).map((c) {
                      final isSelected = _selectedColor == c;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedColor = c),
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                            color: Color(c),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected
                                  ? (isLight
                                      ? const Color(0xFF0F172A)
                                      : Colors.white)
                                  : Colors.transparent,
                              width: 2.2,
                            ),
                          ),
                          child: isSelected
                              ? const Icon(
                                  Icons.check_rounded,
                                  size: 14,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  context.l10n.cancel,
                  style: TextStyle(color: AppColors.textSecondary(context)),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: _isSaving ? null : _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 11,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: _isSaving
                    ? const SizedBox(
                        width: 14,
                        height: 14,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.save_rounded, size: 16),
                label: Text(
                  _isSaving
                      ? (context.isEn ? 'Saving...' : 'Speichern...')
                      : (context.isEn ? 'Save' : 'Speichern'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
