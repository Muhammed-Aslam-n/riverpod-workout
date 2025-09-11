import 'package:flutter/material.dart';
import 'package:todo_app_riverpod/theme/theme.dart';

class FloatingAddButton extends StatelessWidget {
  final VoidCallback onPressed;

  const FloatingAddButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: AppTheme.buttonColor,
      child: const Icon(Icons.add),
    );
  }
}
