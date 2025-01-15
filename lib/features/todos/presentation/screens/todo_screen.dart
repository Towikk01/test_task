import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/features/todos/data/models/todo_model.dart';
import 'package:test_task/features/todos/logic/todo_cubit.dart';
import 'package:test_task/features/todos/logic/todo_state.dart';
import 'package:test_task/features/todos/presentation/widgets/add_todo_modal.dart';
import 'package:test_task/features/todos/presentation/widgets/filter_bar.dart';
import 'package:test_task/features/todos/presentation/widgets/todo_list.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Todo List'),
        ),
        body: BlocBuilder<TodoCubit, TodoState>(
          builder: (context, state) {
            if (state.todos.isEmpty) {
              return Center(
                child: Text(
                  'Need to add something...',
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              return Column(
                children: [
                  const FilterBar(),
                  Expanded(
                    child: TodoList(
                      todos: state.todos,
                      onToggle: (id) {
                        context.read<TodoCubit>().toggleTodo(id);
                      },
                      onDelete: (id) {
                        context.read<TodoCubit>().removeTodo(id);
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => const AddTodoModal(),
            );
          },
          child: const Icon(Icons.add),
        ));
  }
}
