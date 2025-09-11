import 'package:flutter/material.dart';

class TodoListItem extends StatelessWidget {
  final String title;
  final String description;
  final bool isCompleted;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final ValueChanged<bool?>? onChanged;

  const TodoListItem({
    super.key,
    required this.title,
    required this.description,
    this.isCompleted = false,
    this.onEdit,
    this.onDelete,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 1,
      child: ListTile(
        leading: Checkbox(
          value: isCompleted,
          onChanged: onChanged,
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            decoration:
            isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
          ),
        ),
        subtitle: Text(
          description,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: Theme.of(context).colorScheme.primary),
              onPressed: onEdit,
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.redAccent),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
