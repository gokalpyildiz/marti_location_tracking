import 'package:flutter/material.dart';
import 'package:marti_location_tracking/product/utils/extensions/context_extension.dart';

class RefreshButton extends StatefulWidget {
  const RefreshButton({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  State<RefreshButton> createState() => _RefreshButtonState();
}

class _RefreshButtonState extends State<RefreshButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onRefreshPressed() async {
    if (!_controller.isAnimating) {
      _controller.repeat();

      await Future.delayed(const Duration(seconds: 2), () {
        if (context.mounted) {
          _controller.reset();
        }
      });
      widget.onPressed();
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _onRefreshPressed,
      icon: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.rotate(
            angle: _controller.value * 2.0 * 3.1416,
            child: child,
          );
        },
        child: Icon(Icons.refresh, size: 80, color: context.colorScheme.tertiary),
      ),
    );
  }
}
