import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {

  final Widget child;

  const GradientBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFF9FAFB),
            Color(0xFFF3F4F6),
            Color(0xFFEDE9FE),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: child,
    );
  }
}