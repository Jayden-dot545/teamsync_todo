import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/client.dart';

class NoteController extends ChangeNotifier {
  final int listId;
  List<TodoNote> _notes = [];
  bool _isLoading = false;
  String? _errorMessage;
  String _searchQuery = '';
  StreamSubscription<TodoListEvent>? _streamSubscription;

  NoteController({required this.listId}) {
    fetchNotes();
    _startListening();
  }

  List<TodoNote> get notes {
    if (_searchQuery.isEmpty) return _notes;
    final q = _searchQuery.toLowerCase();
    return _notes
        .where(
          (n) =>
              n.title.toLowerCase().contains(q) ||
              n.content.toLowerCase().contains(q),
        )
        .toList();
  }

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String get searchQuery => _searchQuery;

  void setSearchQuery(String query) {
    _searchQuery = query.trim();
    notifyListeners();
  }

  void _startListening() {
    try {
      final stream = client.todoList.watchList(listId);
      _streamSubscription = stream.listen((event) {
        if (event.todoListId != listId) return;
        if (event.eventType == TodoEventType.noteCreated && event.note != null) {
          final exists = _notes.any((n) => n.id == event.note!.id);
          if (!exists) {
            _notes.insert(0, event.note!);
            _sortNotes();
            notifyListeners();
          }
        } else if (event.eventType == TodoEventType.noteUpdated &&
            event.note != null) {
          final idx = _notes.indexWhere((n) => n.id == event.note!.id);
          if (idx != -1) {
            _notes[idx] = event.note!;
          } else {
            _notes.add(event.note!);
          }
          _sortNotes();
          notifyListeners();
        } else if (event.eventType == TodoEventType.noteDeleted &&
            event.noteId != null) {
          _notes.removeWhere((n) => n.id == event.noteId);
          notifyListeners();
        }
      }, onError: (_) {});
    } catch (_) {}
  }

  void _sortNotes() {
    _notes.sort((a, b) {
      if (a.isPinned != b.isPinned) {
        return a.isPinned ? -1 : 1;
      }
      final aDate = a.updatedAt ?? a.createdAt;
      final bDate = b.updatedAt ?? b.createdAt;
      return bDate.compareTo(aDate);
    });
  }

  /// Fetches fresh persistent notes from the PostgreSQL database.
  Future<void> fetchNotes() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _notes = await client.todoNote.getNotes(listId: listId);
      _sortNotes();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Creates and persists a new note to the database.
  Future<TodoNote?> createNote({
    required String title,
    required String content,
    int? color,
    bool isPinned = false,
  }) async {
    try {
      final note = await client.todoNote.createNote(
        listId: listId,
        title: title,
        content: content,
        color: color,
        isPinned: isPinned,
      );

      final exists = _notes.any((n) => n.id == note.id);
      if (!exists) {
        _notes.insert(0, note);
        _sortNotes();
        notifyListeners();
      }
      return note;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return null;
    }
  }

  /// Updates and persists changes to an existing note.
  Future<bool> updateNote({
    required int noteId,
    required String title,
    required String content,
    int? color,
    bool? isPinned,
  }) async {
    try {
      final updated = await client.todoNote.updateNote(
        noteId: noteId,
        title: title,
        content: content,
        color: color,
        isPinned: isPinned,
      );

      final idx = _notes.indexWhere((n) => n.id == noteId);
      if (idx != -1) {
        _notes[idx] = updated;
        _sortNotes();
        notifyListeners();
      }
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  /// Toggles the pin status of a note.
  Future<void> togglePin(int noteId) async {
    final idx = _notes.indexWhere((n) => n.id == noteId);
    if (idx == -1) return;

    final prev = _notes[idx];
    // Optimistic update
    prev.isPinned = !prev.isPinned;
    _sortNotes();
    notifyListeners();

    try {
      final updated = await client.todoNote.togglePin(noteId: noteId);
      final currentIdx = _notes.indexWhere((n) => n.id == noteId);
      if (currentIdx != -1) {
        _notes[currentIdx] = updated;
        _sortNotes();
        notifyListeners();
      }
    } catch (e) {
      // Rollback
      prev.isPinned = !prev.isPinned;
      _sortNotes();
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  /// Deletes a note permanently from PostgreSQL.
  Future<bool> deleteNote(int noteId) async {
    final idx = _notes.indexWhere((n) => n.id == noteId);
    if (idx == -1) return false;

    final removed = _notes.removeAt(idx);
    notifyListeners();

    try {
      final success = await client.todoNote.deleteNote(noteId: noteId);
      if (!success) {
        _notes.insert(idx, removed);
        _sortNotes();
        notifyListeners();
      }
      return success;
    } catch (e) {
      _notes.insert(idx, removed);
      _sortNotes();
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }
}
