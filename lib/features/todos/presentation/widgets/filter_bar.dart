import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/features/todos/logic/todo_cubit.dart';

class FilterBar extends StatefulWidget {
  const FilterBar({super.key});

  @override
  FilterBarState createState() => FilterBarState();
}

class FilterBarState extends State<FilterBar> {
  String? filterCompleted;
  String? filterCategory;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        DropdownButton<String?>(
          value: filterCompleted,
          hint: const Text('Status'),
          items: [
            const DropdownMenuItem(value: 'All', child: Text('All')),
            const DropdownMenuItem(
                value: 'Completed', child: Text('Completed')),
            const DropdownMenuItem(
                value: 'Uncompleted', child: Text('Not Completed')),
          ],
          onChanged: (value) {
            setState(() {
              filterCompleted = value;
            });
            context.read<TodoCubit>().filterTodos(
                  isCompleted: filterCompleted,
                  category: filterCategory,
                );
          },
        ),
        DropdownButton<String?>(
          value: filterCategory,
          hint: const Text('Category'),
          items: [
            DropdownMenuItem(value: 'All', child: Text('All')),
            DropdownMenuItem(value: 'General', child: Text('General')),
            DropdownMenuItem(value: 'Personal', child: Text('Personal')),
            DropdownMenuItem(value: 'Work', child: Text('Work')),
            DropdownMenuItem(value: 'Home', child: Text('Home')),
            DropdownMenuItem(value: 'Other', child: Text('Other')),
          ],
          onChanged: (value) {
            setState(() {
              filterCategory = value;
            });

            context.read<TodoCubit>().filterTodos(
                  isCompleted: filterCompleted,
                  category: filterCategory,
                );
          },
        ),
      ],
    );
  }
}
