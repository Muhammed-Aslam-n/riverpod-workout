import 'package:flutter/material.dart';

/// The reusable dialog function with animation
Future<void> showCustomDialog({
  required BuildContext context,
  required Widget child,
  double radius = 20,
  Color backgroundColor = Colors.white,
  Curve curve = Curves.easeInOut,
  Duration duration = const Duration(milliseconds: 300),
}) => showGeneralDialog(
  context: context,
  barrierDismissible: true,
  barrierLabel: 'Close',
  barrierColor: Colors.black54,
  transitionDuration: duration,
  
  pageBuilder: (context, animation, secondaryAnimation) => Center(
    child: Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: child,
      ),
    ),
  ),
  transitionBuilder: (context, animation, secondaryAnimation, childWidget) {
    final curved = CurvedAnimation(parent: animation, curve: curve);
    return FadeTransition(
      opacity: curved,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.1),
          end: Offset.zero,
        ).animate(curved),
        child: childWidget,
      ),
    );
  },
);
