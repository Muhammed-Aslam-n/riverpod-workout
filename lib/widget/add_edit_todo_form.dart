import 'package:flutter/material.dart';
import 'package:todo_app_riverpod/theme/theme.dart';

class AddEditTodoForm extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final bool isCompleted;
  final ValueChanged<bool> onCompletedChanged;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const AddEditTodoForm({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.isCompleted,
    required this.onCompletedChanged,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: AppTheme.inputDecoration("Task Title"),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: descriptionController,
            decoration: AppTheme.inputDecoration("Task Description"),
            maxLines: 3,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text("Mark as Completed"),
              Switch(
                value: isCompleted,
                onChanged: onCompletedChanged,
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: onCancel,
                  style: TextButton.styleFrom(
                    backgroundColor: AppTheme.cancelButtonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text("Cancel", style: AppTheme.cancelButtonText),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: onSave,
                  child: Text("Save", style: AppTheme.buttonText),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
