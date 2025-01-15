import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/features/todos/data/models/todo_model.dart';
import 'package:test_task/features/todos/logic/todo_cubit.dart';
import 'package:test_task/features/todos/logic/todo_state.dart';
import 'package:test_task/features/todos/presentation/widgets/todo_item.dart';

class TodoList extends StatelessWidget {
  final List<Todo> todos;
  final Function(String id) onToggle;
  final Function(String id) onDelete;

  const TodoList({
    super.key,
    required this.todos,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoCubit, TodoState>(
      builder: (context, state) {
        final todos = context.watch<TodoCubit>().getFiltersTodos();
        if (todos.isEmpty) {
          return Center(child: Text('No todos available.'));
        }

        return ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            final todo = todos[index];

            return TodoItem(
              key: ValueKey(todo.id),
              todo: todo,
              onToggle: () => context.read<TodoCubit>().toggleTodo(todo.id),
              onDelete: () => context.read<TodoCubit>().removeTodo(todo.id),
            );
          },
        );
      },
    );
  }
}
