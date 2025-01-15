import 'package:test_task/features/todos/data/models/todo_model.dart';

class TodoState {
  final List<Todo> todos;
  final String? filterCompleted;
  final String? filterCategory;

  TodoState({
    required this.todos,
    this.filterCompleted,
    this.filterCategory,
  });

  TodoState copyWith({
    List<Todo>? todos,
    List<Todo>? filteredTodos,
    String? filterCompleted,
    String? filterCategory,
  }) {
    return TodoState(
      todos: todos ?? this.todos,
      filterCompleted: filterCompleted ?? this.filterCompleted,
      filterCategory: filterCategory ?? this.filterCategory,
    );
  }
}
