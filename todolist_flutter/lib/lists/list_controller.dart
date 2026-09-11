import 'package:flutter/material.dart';
import '../core/client.dart';

class ListController extends ChangeNotifier {
  List<TodoList> _lists = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<TodoList> get lists => _lists;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  UuidValue? get currentUserId => client.auth.authInfo?.authUserId;

  Future<void> fetchLists() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _lists = await client.todoList.getLists();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<TodoList?> createList({
    required String title,
    String? description,
    required int color,
  }) async {
    try {
      final newList = await client.todoList.createList(
        title: title,
        description: description,
        color: color,
      );
      _lists.insert(0, newList);
      notifyListeners();
      return newList;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return null;
    }
  }

  Future<bool> updateList({
    required int listId,
    required String title,
    String? description,
    required int color,
  }) async {
    try {
      final updated = await client.todoList.updateList(
        listId: listId,
        title: title,
        description: description,
        color: color,
      );
      final index = _lists.indexWhere((l) => l.id == listId);
      if (index != -1) {
        _lists[index] = updated;
        notifyListeners();
      }
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteList(int listId) async {
    try {
      final success = await client.todoList.deleteList(listId);
      if (success) {
        _lists.removeWhere((l) => l.id == listId);
        notifyListeners();
      }
      return success;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<List<TodoListMember>> getMembers(int listId) async {
    try {
      return await client.todoList.getMembers(listId);
    } catch (e) {
      return [];
    }
  }

  Future<TodoListMember?> inviteMember({
    required int listId,
    required String email,
    required MemberRole role,
  }) async {
    try {
      return await client.todoList.inviteMember(
        listId: listId,
        email: email,
        role: role,
      );
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  Future<bool> removeMember({
    required int listId,
    UuidValue? memberUserId,
    int? memberId,
  }) async {
    try {
      return await client.todoList.removeMember(
        listId: listId,
        memberUserId: memberUserId,
        memberId: memberId,
      );
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<String?> getOrCreateInviteCode(int listId) async {
    try {
      return await client.todoList.getOrCreateInviteCode(listId);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return null;
    }
  }

  Future<TodoList?> joinListByInviteCode(String codeOrLink) async {
    try {
      _isLoading = true;
      notifyListeners();
      final joinedList = await client.todoList.joinListByInviteCode(codeOrLink);
      final index = _lists.indexWhere((l) => l.id == joinedList.id);
      if (index == -1) {
        _lists.insert(0, joinedList);
      } else {
        _lists[index] = joinedList;
      }
      return joinedList;
    } catch (e) {
      _errorMessage = e.toString();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
