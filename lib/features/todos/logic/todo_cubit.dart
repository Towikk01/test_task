import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_task/features/todos/data/models/todo_model.dart';
import 'package:test_task/features/todos/logic/todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit()
      : super(TodoState(
          todos: [],
          filterCompleted: 'All',
          filterCategory: 'All',
        ));

  Future<void> loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final todosJson = prefs.getStringList('Todos') ?? [];
    final todos =
        todosJson.map((todo) => Todo.fromJson(jsonDecode(todo))).toList();
    emit(state.copyWith(
      todos: todos,
      filteredTodos: todos,
    ));
  }

  Future<void> addTodo(Todo todo) async {
    final updatedTodos = List<Todo>.from(state.todos)..add(todo);
    await _saveTodos(updatedTodos);
    emit(state.copyWith(todos: updatedTodos));
    _saveTodos(updatedTodos);
  }

  Future<void> removeTodo(String id) async {
    final updatedTodos = state.todos.where((todo) => todo.id != id).toList();
    await _saveTodos(updatedTodos);
    emit(state.copyWith(todos: updatedTodos));
    _saveTodos(updatedTodos);
  }

  Future<void> toggleTodo(String id) async {
    final updatedTodos = state.todos.map((todo) {
      if (todo.id == id) {
        return todo.copyWith(
            isCompleted: (todo.isCompleted == 'Uncompleted')
                ? 'Completed'
                : 'Uncompleted');
      }
      return todo;
    }).toList();
    await _saveTodos(updatedTodos);
    emit(state.copyWith(todos: updatedTodos));
  }

  void filterTodos({String? isCompleted, String? category}) {
    emit(state.copyWith(
      filterCompleted: isCompleted,
      filterCategory: category,
    ));
  }

  List<Todo> getFiltersTodos() {
    final todos = state.todos;
    final filterCompleted = state.filterCompleted;
    final filterCategory = state.filterCategory;

    return todos.where((todo) {
      final isCompleted =
          filterCompleted == 'All' || todo.isCompleted == filterCompleted;
      final isCategory =
          filterCategory == "All" || todo.category == filterCategory;

      return isCompleted && isCategory;
    }).toList();
  }

  Future<void> _saveTodos(List<Todo> todos) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final todosJson = todos.map((todo) => jsonEncode(todo.toJson())).toList();
      await prefs.setStringList('Todos', todosJson);
    } catch (e) {
      print('Error saving todos: $e');
    }
  }
}
