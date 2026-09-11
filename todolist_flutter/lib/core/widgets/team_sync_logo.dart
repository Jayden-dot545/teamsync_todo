import 'package:flutter/material.dart';
import '../constants.dart';

class TeamSyncLogo extends StatelessWidget {
  final double size;
  final bool showGlow;

  const TeamSyncLogo({
    super.key,
    this.size = 56,
    this.showGlow = true,
  });

  @override
  Widget build(BuildContext context) {
    final iconSize = size * 0.58;
    final padding = size * 0.22;

    return Container(
      width: size + (padding * 2),
      height: size + (padding * 2),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const RadialGradient(
          center: Alignment(-0.2, -0.3),
          radius: 1.1,
          colors: [
            Color(0xFF245084),
            Color(0xFF0F2B48),
          ],
        ),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.45),
          width: 2,
        ),
        boxShadow: showGlow
            ? [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  blurRadius: size * 0.65,
                  spreadRadius: 2,
                ),
                BoxShadow(
                  color: AppColors.secondary.withValues(alpha: 0.2),
                  blurRadius: size * 0.9,
                  spreadRadius: 4,
                ),
              ]
            : [],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background nexus pulse ring
          Container(
            width: size * 0.85,
            height: size * 0.85,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.secondary.withValues(alpha: 0.25),
                width: 1.5,
              ),
            ),
          ),

          // Central Nexus Hub Icon
          ShaderMask(
            shaderCallback: (bounds) {
              return const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primary,
                  AppColors.secondary,
                  Color(0xFFA855F7),
                ],
              ).createShader(bounds);
            },
            child: Icon(
              Icons.hub_rounded,
              size: iconSize,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
