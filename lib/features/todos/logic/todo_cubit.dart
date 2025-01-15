import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_task/features/todos/data/models/todo_model.dart';
import 'package:test_task/features/todos/logic/todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoState(todos: []));

  Future<void> loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final todosJson = prefs.getStringList('Todos') ?? [];
    final todos = todosJson
        .map((todo) => Todo.fromJson(jsonDecode(todo)))
        .toList(); // Fixed fromJson call
    emit(state.copyWith(todos: todos));
  }

  Future<void> addTodo(Todo todo) async {
    final updatedTodos = List<Todo>.from(state.todos)..add(todo);
    await _saveTodos(updatedTodos);
    emit(state.copyWith(todos: updatedTodos));
  }

  Future<void> removeTodo(String id) async {
    final updatedTodos = state.todos.where((Todo) => Todo.id != id).toList();
    await _saveTodos(updatedTodos);
    emit(state.copyWith(todos: updatedTodos));
  }

  Future<void> toggleTodo(String id) async {
    final updatedTodos = state.todos.map((todo) {
      if (todo.id == id) {
        return todo.copyWith(isCompleted: !todo.isCompleted);
      }
      return todo;
    }).toList();
    await _saveTodos(updatedTodos);
    emit(state.copyWith(todos: updatedTodos));
  }

  Future<void> filterTodos({bool? isCompleted, String? category}) async {
    var filteredTodos = state.todos;
    if (isCompleted != null) {
      filteredTodos = filteredTodos
          .where((todo) => todo.isCompleted == isCompleted)
          .toList();
    }
    if (category != null) {
      filteredTodos =
          filteredTodos.where((todo) => todo.category == category).toList();
    }
    emit(TodoState(todos: filteredTodos));
  }

  Future<void> _saveTodos(List<Todo> todos) async {
    final prefs = await SharedPreferences.getInstance();
    final todosJson = todos.map((todo) => jsonEncode(todo.toJson())).toList();
    await prefs.setStringList('Todos', todosJson);
  }
}
