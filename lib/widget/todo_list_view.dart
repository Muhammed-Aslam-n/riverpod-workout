import 'package:flutter/material.dart';
import 'package:todo_app_riverpod/common/app_log.dart';
import 'package:todo_app_riverpod/config/db/todo_adapter.dart';
import 'package:todo_app_riverpod/widget/todo_item.dart';

class TodoListView extends StatelessWidget {
  final List<TodoData> todos;
  final Function(TodoData data) onEdit;
  final Function(int index) onDelete;
  final Function(int index, bool?) onToggle;

  const TodoListView({
    super.key,
    required this.todos,
    required this.onEdit,
    required this.onDelete,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    if (todos.isEmpty) {
      return Center(child: Text('No tasks found'));
    }
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        AppLog.info('todoId ${todo.id}');
        return TodoListItem(
          title: todo.title,
          description: todo.description ?? '',
          isCompleted: todo.isCompleted,
          onEdit: () => onEdit(todo),
          onDelete: () => onDelete(index),
          onChanged: (value) => onToggle(index, value),
        );
      },
    );
  }
}
