import 'package:flutter/material.dart';
import '../constants.dart';

class AppBackground extends StatelessWidget {
  final Widget child;

  const AppBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final isLight = AppColors.isLight(context);

    return Stack(
      children: [
        // 1. Base Gradient Canvas (Pleasant soft off-white in Light Mode, deep sky navy in Dark Mode)
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isLight
                    ? const [
                        Color(0xFFF8FAFC), // Soft pleasant off-white
                        Color(0xFFF1F5F9), // Light clean slate
                        Color(0xFFE2E8F0), // Subtle soft border tone
                      ]
                    : const [
                        Color(0xFF0F2B48),
                        Color(0xFF0A1F35),
                        Color(0xFF071728),
                      ],
              ),
            ),
          ),
        ),

        // 2. Ambient Light Orbs (Soft Sky Blue & Indigo)
        Positioned(
          top: -120,
          left: -80,
          child: Container(
            width: 380,
            height: 380,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.primary.withValues(alpha: isLight ? 0.09 : 0.18),
                  AppColors.primary.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -100,
          right: -80,
          child: Container(
            width: 420,
            height: 420,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.secondary.withValues(alpha: isLight ? 0.07 : 0.15),
                  AppColors.secondary.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 280,
          right: -140,
          child: Container(
            width: 320,
            height: 320,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.viewerColor.withValues(
                    alpha: isLight ? 0.04 : 0.08,
                  ),
                  AppColors.viewerColor.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
        ),

        // 3. Subtle Geometric Grid & Orbit Wave Mesh (Custom Painter)
        Positioned.fill(
          child: RepaintBoundary(
            child: CustomPaint(
              painter: _BackgroundPatternPainter(isLight: isLight),
            ),
          ),
        ),

        // 4. Foreground Content
        child,
      ],
    );
  }
}

class _BackgroundPatternPainter extends CustomPainter {
  final bool isLight;

  const _BackgroundPatternPainter({required this.isLight});

  @override
  void paint(Canvas canvas, Size size) {
    if (!size.width.isFinite || !size.height.isFinite || size.width <= 0 || size.height <= 0) {
      return;
    }

    final baseColor = isLight ? const Color(0xFF0F172A) : Colors.white;

    final gridPaint = Paint()
      ..color = baseColor.withValues(alpha: isLight ? 0.025 : 0.018)
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke;

    final dotPaint = Paint()
      ..color = baseColor.withValues(alpha: isLight ? 0.05 : 0.07)
      ..style = PaintingStyle.fill;

    const spacing = 64.0;
    final maxCols = (size.width / spacing).ceil().clamp(0, 30);
    final maxRows = (size.height / spacing).ceil().clamp(0, 50);

    // Draw subtle grid lines
    for (int i = 0; i <= maxCols; i++) {
      final x = i * spacing;
      if (x <= size.width) {
        canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
      }
    }
    for (int j = 0; j <= maxRows; j++) {
      final y = j * spacing;
      if (y <= size.height) {
        canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
      }
    }

    // Draw subtle grid intersection dots
    for (int i = 0; i <= maxCols; i++) {
      final x = i * spacing;
      if (x > size.width) continue;
      for (int j = 0; j <= maxRows; j++) {
        final y = j * spacing;
        if (y > size.height) continue;
        canvas.drawCircle(Offset(x, y), 1.2, dotPaint);
      }
    }

    // Draw subtle curved orbital wave lines in the background
    final curvePaint = Paint()
      ..color = AppColors.primary.withValues(alpha: isLight ? 0.05 : 0.035)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final path1 = Path();
    path1.moveTo(0, size.height * 0.2);
    path1.cubicTo(
      size.width * 0.35,
      size.height * 0.1,
      size.width * 0.65,
      size.height * 0.4,
      size.width,
      size.height * 0.25,
    );
    canvas.drawPath(path1, curvePaint);

    final path2 = Path();
    path2.moveTo(0, size.height * 0.65);
    path2.cubicTo(
      size.width * 0.4,
      size.height * 0.8,
      size.width * 0.7,
      size.height * 0.55,
      size.width,
      size.height * 0.75,
    );
    canvas.drawPath(path2, curvePaint);
  }

  @override
  bool shouldRepaint(covariant _BackgroundPatternPainter oldDelegate) =>
      oldDelegate.isLight != isLight;
}
