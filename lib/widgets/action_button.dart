import 'dart:ui';
import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {

  final VoidCallback onCamera;
  final VoidCallback onGallery;
  final VoidCallback onDetect;

  const ActionButtons({
    super.key,
    required this.onCamera,
    required this.onGallery,
    required this.onDetect,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [

        /// Botones cámara y galería
        Row(
          children: [

            Expanded(
              child: _secondaryButton(
                icon: Icons.camera_alt_outlined,
                label: "Camera",
                onTap: onCamera,
              ),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: _secondaryButton(
                icon: Icons.photo_library_outlined,
                label: "Gallery",
                onTap: onGallery,
              ),
            ),

          ],
        ),

        const SizedBox(height: 24),

        /// Botón principal
        _detectButton(),

      ],
    );
  }

  Widget _secondaryButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,

        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),

          borderRadius: BorderRadius.circular(14),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Icon(
              icon,
              color: const Color.fromARGB(255, 28, 24, 94),
            ),

            const SizedBox(width: 8),

            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF1F2937),
                fontWeight: FontWeight.w600,
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _detectButton() {

    return GestureDetector(
      onTap: onDetect,

      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),

        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 6,
            sigmaY: 6,
          ),

          child: Container(
            width: double.infinity,
            height: 60,

            decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(16),

              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 79, 51, 143),
                  Color.fromARGB(255, 57, 58, 143),
                ],
              ),

              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF6366F1).withOpacity(0.25),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                )
              ],
            ),

            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Icon(
                  Icons.visibility,
                  color: Colors.white,
                ),

                SizedBox(width: 10),

                Text(
                  "Detect Objects",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                    letterSpacing: 0.3,
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}