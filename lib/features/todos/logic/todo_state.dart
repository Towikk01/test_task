import 'package:test_task/features/todos/data/models/todo_model.dart';

class TodoState {
  final List<Todo> todos;

  TodoState({required this.todos});

  TodoState copyWith({List<Todo>? todos}) {
    return TodoState(todos: todos ?? this.todos);
  }
}
