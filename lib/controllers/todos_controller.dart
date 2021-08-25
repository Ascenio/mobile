import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/todo.dart';

enum ControllerStatus { loading, loaded, error }

class TodosController extends ChangeNotifier {
  TodosController({
    ControllerStatus initialStatus = ControllerStatus.loading,
  }) : _status = initialStatus;

  SharedPreferences _preferences;
  List<Todo> _todos = [];
  UnmodifiableListView<Todo> get todos => UnmodifiableListView(_todos);

  ControllerStatus _status;
  ControllerStatus get status => _status;

  static const _storageKey = 'todos';

  void _readTodos() {
    final stringsList = _preferences.getStringList(_storageKey) ?? [];
    _todos = stringsList
        .map(jsonDecode)
        .cast<Map<String, dynamic>>()
        .map((json) => Todo.fromJson(json))
        .toList();
  }

  Future<void> _writeTodos() async {
    final stringsList =
        _todos.map((todo) => todo.toJson()).map(jsonEncode).toList();
    await _preferences.setStringList(_storageKey, stringsList);
  }

  Future<void> initialize() async {
    _loading();
    try {
      _preferences = await SharedPreferences.getInstance();
      _readTodos();
      _loaded();
    } on Exception {
      _error();
    }
  }

  void _loading() {
    _status = ControllerStatus.loading;
    notifyListeners();
  }

  void _loaded() {
    _status = ControllerStatus.loaded;
    notifyListeners();
  }

  void _error() {
    _status = ControllerStatus.error;
    notifyListeners();
  }

  Future<void> add(Todo todo) async {
    if (todo == null) {
      return;
    }
    _todos.add(todo);
    await _writeTodos();
    notifyListeners();
  }

  Future<void> remove(int index) async {
    _todos.removeAt(index);
    await _writeTodos();
    notifyListeners();
  }

  Future<void> toggle(int index) async {
    final todo = _todos[index];
    _todos[index] = todo.copyWith(done: !todo.done);
    await _writeTodos();
    notifyListeners();
  }

  Future<void> update(Todo todo, int index) async {
    _todos[index] = todo;
    await _writeTodos();
    notifyListeners();
  }
}
