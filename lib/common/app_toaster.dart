import 'package:flutter/material.dart';
import 'package:todo_app_riverpod/constants/app_colors.dart';

final GlobalKey<ScaffoldMessengerState> snackBarKey =
    GlobalKey<ScaffoldMessengerState>();

enum ToastType { success, warning, error }

enum ToastLong { short, medium, long }

Duration getDuration(ToastLong duration) {
  switch (duration) {
    case ToastLong.short:
      return const Duration(seconds: 3);
    case ToastLong.medium:
      return const Duration(seconds: 4);
    case ToastLong.long:
      return const Duration(seconds: 5);
  }
}

class AppToaster {
  AppToaster.success(
    this.context, {
    required this.message,
    this.duration,
    this.widget,
  }) : type = ToastType.success {
    _show();
  }

  AppToaster.warning(
    this.context, {
    required this.message,
    this.duration,
    this.widget,
  }) : type = ToastType.warning {
    _show();
  }

  AppToaster.error(
    this.context, {
    required this.message,
    this.duration,
    this.widget,
  }) : type = ToastType.error {
    _show();
  }

  final String message;
  final ToastType type;
  final BuildContext context;
  final ToastLong? duration;
  final Widget? widget;

  static OverlayEntry? _currentEntry;

  void _show() {
    final overlay = Overlay.of(context);

    _currentEntry?.remove(); // Remove any existing toast

    late final OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) => SafeArea(
        bottom: true,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 80, left: 16, right: 16),
            child: _ToasterWidget(message: message, type: type, child: widget),
          ),
        ),
      ),
    );

    _currentEntry = overlayEntry;
    overlay.insert(overlayEntry);

    Future.delayed(getDuration(duration ?? ToastLong.short), () {
      if (_currentEntry == overlayEntry) {
        overlayEntry.remove();
        _currentEntry = null;
      }
    });
  }

  /// Manually close the current toast
  static void close() {
    _currentEntry?.remove();
    _currentEntry = null;
  }
}

/// Fade-In Widget
class _ToasterWidget extends StatefulWidget {
  const _ToasterWidget({required this.message, required this.type, this.child});

  final String message;
  final ToastType type;
  final Widget? child;

  @override
  State<_ToasterWidget> createState() => _ToasterWidgetState();
}

class _ToasterWidgetState extends State<_ToasterWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: _setColor(widget.type),
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(_setIcon(widget.type), color: Colors.white),
              const SizedBox(width: 8),
              Expanded(
                child:
                    widget.child ??
                    Text(
                      widget.message,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _setColor(ToastType type) {
    switch (type) {
      case ToastType.success:
        return AppColors.green00B368;
      case ToastType.warning:
        return AppColors.orangeEC663A;
      case ToastType.error:
        return AppColors.redE53535;
    }
  }

  IconData _setIcon(ToastType type) {
    switch (type) {
      case ToastType.success:
        return Icons.check;
      case ToastType.warning:
        return Icons.warning_amber;
      case ToastType.error:
        return Icons.error_outline;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
