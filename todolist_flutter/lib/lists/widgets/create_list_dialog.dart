import 'package:flutter/material.dart';
import 'package:todolist_client/todolist_client.dart';
import '../../core/constants.dart';
import '../../core/localization_helper.dart';
import '../../core/widgets/color_picker_row.dart';
import '../list_controller.dart';

class CreateListDialog extends StatefulWidget {
  final ListController listController;
  final TodoList? existingList;

  const CreateListDialog({
    super.key,
    required this.listController,
    this.existingList,
  });

  @override
  State<CreateListDialog> createState() => _CreateListDialogState();
}

class _CreateListDialogState extends State<CreateListDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descController;
  late int _selectedColor;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: widget.existingList?.title ?? '',
    );
    _descController = TextEditingController(
      text: widget.existingList?.description ?? '',
    );
    _selectedColor = widget.existingList?.color ?? AppColors.listColors.first;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    if (widget.existingList != null) {
      final success = await widget.listController.updateList(
        listId: widget.existingList!.id!,
        title: _titleController.text.trim(),
        description: _descController.text.trim().isEmpty
            ? null
            : _descController.text.trim(),
        color: _selectedColor,
      );
      if (!success && mounted) {
        setState(() => _isSubmitting = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.listController.errorMessage ??
                  'Fehler beim Aktualisieren der Liste',
            ),
            backgroundColor: AppColors.priorityHigh,
          ),
        );
        return;
      }
    } else {
      final newList = await widget.listController.createList(
        title: _titleController.text.trim(),
        description: _descController.text.trim().isEmpty
            ? null
            : _descController.text.trim(),
        color: _selectedColor,
      );
      if (newList == null && mounted) {
        setState(() => _isSubmitting = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.listController.errorMessage ??
                  'Fehler beim Erstellen der Liste',
            ),
            backgroundColor: AppColors.priorityHigh,
          ),
        );
        return;
      }
    }

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.existingList != null;

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
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(_selectedColor).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        isEditing
                            ? Icons.edit_note_rounded
                            : Icons.playlist_add_rounded,
                        color: Color(_selectedColor),
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Text(
                      isEditing
                          ? (context.isEn ? 'Edit List' : 'Liste bearbeiten')
                          : context.l10n.newList,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.text(context),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Title Input
                Text(
                  context.isEn ? 'List Title' : 'Titel der Liste',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary(context),
                  ),
                ),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _titleController,
                  autofocus: true,
                  style: TextStyle(color: AppColors.text(context)),
                  decoration: InputDecoration(
                    hintText: context.isEn
                        ? 'e.g. Sprint Planning, Grocery List, Project X'
                        : 'z. B. Sprint Planning, Einkaufsliste, Projekt X',
                  ),
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return context.isEn
                          ? 'Please enter a title'
                          : 'Bitte einen Titel eingeben';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Description Input
                Text(
                  context.isEn
                      ? 'Description (optional)'
                      : 'Beschreibung (optional)',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary(context),
                  ),
                ),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _descController,
                  maxLines: 2,
                  style: TextStyle(color: AppColors.text(context)),
                  decoration: InputDecoration(
                    hintText: context.isEn
                        ? 'What is this list about?'
                        : 'Worum geht es in dieser Liste?',
                  ),
                ),
                const SizedBox(height: 20),

                // Color Picker
                Text(
                  context.isEn ? 'Accent Color' : 'Akzentfarbe',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary(context),
                  ),
                ),
                const SizedBox(height: 10),
                ColorPickerRow(
                  selectedColor: _selectedColor,
                  onColorSelected: (c) => setState(() => _selectedColor = c),
                ),
                const SizedBox(height: 28),

                // Actions
                Row(
                  children: [
                    if (isEditing)
                      TextButton.icon(
                        onPressed: _isSubmitting
                            ? null
                            : () async {
                                final confirm = await showDialog<bool>(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    backgroundColor: AppColors.surface(context),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      side: BorderSide(
                                        color: AppColors.border(context),
                                      ),
                                    ),
                                    title: Text(
                                      context.l10n.deleteList,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.text(context),
                                      ),
                                    ),
                                    content: Text(
                                      context.l10n.deleteListConfirm(
                                        widget.existingList!.title,
                                      ),
                                      style: TextStyle(
                                        color: AppColors.textSecondary(context),
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(ctx).pop(false),
                                        child: Text(
                                          context.l10n.cancel,
                                          style: TextStyle(
                                            color: AppColors.textSecondary(
                                              context,
                                            ),
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppColors.priorityHigh,
                                        ),
                                        onPressed: () =>
                                            Navigator.of(ctx).pop(true),
                                        child: Text(
                                          context.l10n.delete,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );

                                if (confirm == true && mounted) {
                                  setState(() => _isSubmitting = true);
                                  await widget.listController.deleteList(
                                    widget.existingList!.id!,
                                  );
                                  if (context.mounted) {
                                    Navigator.of(context).pop();
                                  }
                                }
                              },
                        icon: const Icon(
                          Icons.delete_outline_rounded,
                          size: 16,
                          color: AppColors.priorityHigh,
                        ),
                        label: Text(
                          context.l10n.delete,
                          style: const TextStyle(
                            color: AppColors.priorityHigh,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    const Spacer(),
                    TextButton(
                      onPressed: _isSubmitting
                          ? null
                          : () => Navigator.of(context).pop(),
                      child: Text(
                        context.l10n.cancel,
                        style: TextStyle(
                          color: AppColors.textSecondary(context),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: _isSubmitting ? null : _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(_selectedColor),
                      ),
                      child: _isSubmitting
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              isEditing
                                  ? context.l10n.save
                                  : (context.isEn
                                      ? 'Create List'
                                      : 'Liste anlegen'),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
