import 'dart:io';
import 'package:flutter/material.dart';

class ImagePreview extends StatelessWidget {

  final File? image;

  const ImagePreview({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 260,
      width: double.infinity,

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 6),
          )
        ],
      ),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),

        child: image == null
            ? _emptyState()
            : Image.file(
                image!,
                fit: BoxFit.cover,
              ),
      ),
    );
  }

  Widget _emptyState() {

    return Container(
      color: const Color(0xFFF9FAFB),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [

          Icon(
            Icons.image_outlined,
            size: 60,
            color: Color(0xFF9CA3AF),
          ),

          SizedBox(height: 10),

          Text(
            "No image selected",
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF6B7280),
              fontWeight: FontWeight.w500,
            ),
          ),

          SizedBox(height: 4),

          Text(
            "Take a photo or upload one",
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF9CA3AF),
            ),
          )

        ],
      ),
    );
  }
}