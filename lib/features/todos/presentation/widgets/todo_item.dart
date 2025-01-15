import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:test_task/features/todos/data/models/todo_model.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const TodoItem({
    super.key,
    required this.todo,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(todo.id),
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) => onDelete(),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      startActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) => onToggle(),
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            icon: Icons.check,
            label: todo.isCompletedBool() ? 'Undo' : 'Complete',
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey[300]!,
              width: 1,
            ),
          ),
        ),
        child: ListTile(
          title: Text(
            todo.title,
            style: TextStyle(
              fontSize: 20,
              decoration: todo.isCompletedBool()
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
          ),
          subtitle: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('${todo.description} for ', style: TextStyle(fontSize: 16)),
              Text('${todo.category}',
                  style: TextStyle(color: Colors.grey, fontSize: 16)),
            ],
          ),
          trailing: Icon(
            todo.isCompletedBool() ? Icons.check_circle : Icons.circle_outlined,
            color: todo.isCompletedBool() ? Colors.green : Colors.grey,
          ),
        ),
      ),
    );
  }
}
