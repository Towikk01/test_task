import 'package:flutter/material.dart';
import 'package:test_task/features/todos/data/models/todo_model.dart';
import 'package:test_task/features/todos/presentation/widgets/todo_item.dart';

class TodoList extends StatelessWidget {
  final List<Todo> todos;
  final Function(String id) onToggle;
  final Function(String id) onDelete;

  const TodoList({
    Key? key,
    required this.todos,
    required this.onToggle,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return TodoItem(
          todo: todo,
          onToggle: () => onToggle(todo.id),
          onDelete: () => onDelete(todo.id),
        );
      },
    );
  }
}
