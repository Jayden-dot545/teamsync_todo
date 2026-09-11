import 'dart:math';
import 'package:flutter/material.dart';

enum _ParticleShape { rect, circle, star }

class ConfettiOverlay extends StatefulWidget {
  final Widget child;
  final bool trigger;
  final VoidCallback? onFinished;

  const ConfettiOverlay({
    super.key,
    required this.child,
    required this.trigger,
    this.onFinished,
  });

  @override
  State<ConfettiOverlay> createState() => _ConfettiOverlayState();
}

class _ConfettiOverlayState extends State<ConfettiOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final List<_Particle> _particles = [];
  final Random _random = Random();
  bool _showBanner = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          if (mounted) setState(() => _showBanner = false);
          widget.onFinished?.call();
        }
      });

    if (widget.trigger) {
      _startConfetti();
    }
  }

  @override
  void didUpdateWidget(covariant ConfettiOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.trigger && widget.trigger) {
      _startConfetti();
    }
  }

  void _startConfetti() {
    _particles.clear();
    final colors = [
      const Color(0xFF6366F1),
      const Color(0xFF0284C7),
      const Color(0xFF10B981),
      const Color(0xFFF59E0B),
      const Color(0xFFEC4899),
      const Color(0xFF8B5CF6),
      const Color(0xFFFFD700),
    ];

    for (int i = 0; i < 85; i++) {
      final shapeIdx = _random.nextInt(3);
      _particles.add(
        _Particle(
          x: 0.15 + _random.nextDouble() * 0.7,
          y: -0.1,
          vx: (_random.nextDouble() - 0.5) * 2.2,
          vy: 0.7 + _random.nextDouble() * 1.8,
          size: 6 + _random.nextDouble() * 7,
          color: colors[_random.nextInt(colors.length)],
          rotation: _random.nextDouble() * 2 * pi,
          rotationSpeed: (_random.nextDouble() - 0.5) * 10,
          shape: _ParticleShape.values[shapeIdx],
        ),
      );
    }

    setState(() => _showBanner = true);
    _controller.forward(from: 0.0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (_controller.isAnimating)
          Positioned.fill(
            child: IgnorePointer(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, _) {
                  return CustomPaint(
                    painter: _ConfettiPainter(
                      particles: _particles,
                      progress: _controller.value,
                    ),
                  );
                },
              ),
            ),
          ),
        if (_showBanner)
          Positioned(
            top: 20,
            left: 0,
            right: 0,
            child: Center(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  final val = _controller.value;
                  final scale = val < 0.2
                      ? (val / 0.2)
                      : (val > 0.8 ? (1.0 - (val - 0.8) / 0.2) : 1.0);
                  final opacity = scale.clamp(0.0, 1.0);

                  return Opacity(
                    opacity: opacity,
                    child: Transform.scale(
                      scale: 0.8 + 0.2 * scale,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF10B981), Color(0xFF059669)],
                          ),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(
                                0xFF10B981,
                              ).withValues(alpha: 0.4),
                              blurRadius: 16,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('🎉', style: TextStyle(fontSize: 18)),
                            SizedBox(width: 8),
                            Text(
                              'Alle Aufgaben erledigt! Stark gemacht!',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}

class _Particle {
  double x;
  double y;
  final double vx;
  final double vy;
  final double size;
  final Color color;
  double rotation;
  final double rotationSpeed;
  final _ParticleShape shape;

  _Particle({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.size,
    required this.color,
    required this.rotation,
    required this.rotationSpeed,
    required this.shape,
  });
}

class _ConfettiPainter extends CustomPainter {
  final List<_Particle> particles;
  final double progress;

  _ConfettiPainter({required this.particles, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final opacity = (1.0 - progress).clamp(0.0, 1.0);

    for (final p in particles) {
      final currentX =
          (p.x * size.width) + (p.vx * size.width * progress * 0.4);
      final currentY = (p.y * size.height) + (p.vy * size.height * progress);
      final currentRot = p.rotation + p.rotationSpeed * progress;

      canvas.save();
      canvas.translate(currentX, currentY);
      canvas.rotate(currentRot);

      final paint = Paint()
        ..color = p.color.withValues(alpha: opacity)
        ..style = PaintingStyle.fill;

      switch (p.shape) {
        case _ParticleShape.circle:
          canvas.drawCircle(Offset.zero, p.size * 0.4, paint);
          break;
        case _ParticleShape.rect:
          canvas.drawRRect(
            RRect.fromRectAndRadius(
              Rect.fromCenter(
                center: Offset.zero,
                width: p.size,
                height: p.size * 0.55,
              ),
              const Radius.circular(2),
            ),
            paint,
          );
          break;
        case _ParticleShape.star:
          _drawStar(canvas, Offset.zero, 5, p.size * 0.6, p.size * 0.3, paint);
          break;
      }

      canvas.restore();
    }
  }

  void _drawStar(
    Canvas canvas,
    Offset center,
    int numPoints,
    double outerRadius,
    double innerRadius,
    Paint paint,
  ) {
    final path = Path();
    final angle = pi / numPoints;

    for (int i = 0; i < numPoints * 2; i++) {
      final r = (i % 2 == 0) ? outerRadius : innerRadius;
      final x = center.dx + r * sin(i * angle);
      final y = center.dy - r * cos(i * angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _ConfettiPainter oldDelegate) => true;
}
