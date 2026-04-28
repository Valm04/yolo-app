import 'package:flutter/material.dart';

class ResultCard extends StatelessWidget {

  final String label;
  final double confidence;

  const ResultCard({
    super.key,
    required this.label,
    required this.confidence,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          )
        ],
      ),

      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Row(
          children: [

            /// Icono
            Container(
              padding: const EdgeInsets.all(10),

              decoration: BoxDecoration(
                color: const Color(0xFFEDE9FE),
                borderRadius: BorderRadius.circular(10),
              ),

              child: const Icon(
                Icons.visibility,
                color: Color(0xFF7C3AED),
              ),
            ),

            const SizedBox(width: 15),

            /// Texto y barra
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    label,
                    style: const TextStyle(
                      color: Color(0xFF1F2937),
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 8),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),

                    child: LinearProgressIndicator(
                      value: confidence,
                      minHeight: 8,
                      backgroundColor: const Color(0xFFE5E7EB),
                      color: const Color(0xFF7C3AED),
                    ),
                  ),

                ],
              ),
            ),

            const SizedBox(width: 10),

            /// porcentaje
            Text(
              "${(confidence * 100).toStringAsFixed(1)}%",
              style: const TextStyle(
                color: Color(0xFF4F46E5),
                fontWeight: FontWeight.bold,
              ),
            ),

          ],
        ),
      ),
    );
  }
}