import 'package:flutter/material.dart';
import 'package:todo_app_riverpod/theme/theme.dart';

class CancelButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CancelButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: AppTheme.cancelButtonColor,
        minimumSize: const Size.fromHeight(50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(text, style: AppTheme.cancelButtonText),
    );
  }
}
