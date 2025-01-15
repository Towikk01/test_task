import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/core/utils/nav_cubit.dart';
import 'package:test_task/features/todos/presentation/screens/todo_screen.dart';
import 'package:test_task/features/weather/presentation/widgets/weather_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavigationCubit(),
      child: Scaffold(
        body: BlocBuilder<NavigationCubit, int>(
          builder: (context, currentIndex) {
            switch (currentIndex) {
              case 0:
                return const TodoScreen();
              case 1:
                return const WeatherWidget();
              default:
                return const TodoScreen();
            }
          },
        ),
        bottomNavigationBar: BlocBuilder<NavigationCubit, int>(
          builder: (context, currentIndex) {
            return BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: (index) =>
                  context.read<NavigationCubit>().updateIndex(index),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.list),
                  label: 'Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.cloud),
                  label: 'Weather',
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
