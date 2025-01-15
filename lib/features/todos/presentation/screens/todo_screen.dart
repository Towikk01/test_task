import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/features/todos/data/models/todo_model.dart';
import 'package:test_task/features/todos/logic/todo_cubit.dart';
import 'package:test_task/features/todos/logic/todo_state.dart';
import 'package:test_task/features/todos/presentation/widgets/todo_list.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: BlocProvider(
        create: (context) => TodoCubit()
          ..loadTodos()
          ..addInitialTodos(),
        child: BlocBuilder<TodoCubit, TodoState>(
          builder: (context, state) {
            return TodoList(
              todos: state.todos,
              onToggle: (id) {
                context.read<TodoCubit>().toggleTodo(id);
              },
              onDelete: (id) {
                context.read<TodoCubit>().removeTodo(id);
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final cubit = context.read<TodoCubit>();
          cubit.addTodo(Todo(
            id: DateTime.now().toString(),
            title: 'New Todo',
            description: 'Description here',
            category: 'General',
          ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

extension on TodoCubit {
  void addInitialTodos() {
    addTodo(Todo(
      id: '1',
      title: 'Brush teeth',
      description: 'Morning routine',
      category: 'Personal',
    ));
    addTodo(Todo(
      id: '2',
      title: 'Wash face',
      description: 'Morning routine',
      category: 'Personal',
    ));
    addTodo(Todo(
      id: '3',
      title: 'Take a shower',
      description: 'Morning routine',
      category: 'Personal',
    ));
  }
}
