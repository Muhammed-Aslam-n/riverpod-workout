import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app_riverpod/config/db/todo_adapter.dart';
import 'package:todo_app_riverpod/provider/home_screen/home_screen_provider.dart';
import 'package:todo_app_riverpod/services/db_services.dart';
import 'package:todo_app_riverpod/widget/add_edit_todo_form.dart';
import 'package:uuid/uuid.dart';

class AddEditTodoScreen extends ConsumerStatefulWidget {
  final TodoData? todo;

  const AddEditTodoScreen({super.key, this.todo});

  @override
  ConsumerState<AddEditTodoScreen> createState() => _AddEditTodoScreenState();
}

class _AddEditTodoScreenState extends ConsumerState<AddEditTodoScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late bool _isCompleted;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing todo data (if editing)
    _titleController = TextEditingController(text: widget.todo?.title ?? '');
    _descriptionController = TextEditingController(
      text: widget.todo?.description ?? '',
    );
    _isCompleted = widget.todo?.isCompleted ?? false;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _onSave() {
    final todo = widget.todo?.copyWith(
      title: _titleController.text,
      description: _descriptionController.text,
      isCompleted: _isCompleted,
    );

    final notifier = ref.read(todoProvider.notifier);
    if (widget.todo == null) {
      final res = notifier.addTodo(
        title: _titleController.text,
        description: _descriptionController.text,
        isCompleted: _isCompleted,
      );
      context.pop(res);
    } else {
      final res = notifier.updateTodo(todo: todo!);
      context.pop(res);
    }
  }

  void _onCancel() {
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.todo == null ? 'Add Todo' : 'Edit Todo'),
      ),
      body: AddEditTodoForm(
        titleController: _titleController,
        descriptionController: _descriptionController,
        isCompleted: _isCompleted,
        onCompletedChanged: (value) {
          setState(() {
            _isCompleted = value;
          });
        },
        onSave: _onSave,
        onCancel: _onCancel,
      ),
    );
  }
}
