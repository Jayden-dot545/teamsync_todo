import 'package:flutter/material.dart';
import '../constants.dart';

class SkeletonCard extends StatefulWidget {
  final double height;
  final double width;
  final double borderRadius;

  const SkeletonCard({
    super.key,
    this.height = 100,
    this.width = double.infinity,
    this.borderRadius = 16,
  });

  @override
  State<SkeletonCard> createState() => _SkeletonCardState();
}

class _SkeletonCardState extends State<SkeletonCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.3, end: 0.7).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLight = AppColors.isLight(context);

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
            color: isLight
                ? const Color(0xFFE2E8F0).withValues(alpha: _animation.value)
                : AppColors.surfaceDark.withValues(alpha: _animation.value),
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: Border.all(
              color: AppColors.border(context).withValues(alpha: 0.5),
            ),
          ),
        );
      },
    );
  }
}
