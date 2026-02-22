import 'package:flutter/material.dart';

/// Wraps [child] with a subtle press-scale feedback (1.0 → 0.96 → 1.0).
/// Use in place of a plain GestureDetector on tappable cards.
class Pressable extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const Pressable({super.key, required this.child, required this.onTap});

  @override
  State<Pressable> createState() => _PressableState();
}

class _PressableState extends State<Pressable>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 80),
    reverseDuration: const Duration(milliseconds: 120),
    lowerBound: 0.96,
    upperBound: 1.0,
    value: 1.0,
  );

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails _) => _ctrl.reverse();

  void _onTapUp(TapUpDetails _) {
    _ctrl.forward();
    widget.onTap();
  }

  void _onTapCancel() => _ctrl.forward();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (context, child) =>
            Transform.scale(scale: _ctrl.value, child: child),
        child: widget.child,
      ),
    );
  }
}
