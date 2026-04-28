import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/glass.dart';
import 'package:yolo/screens/result_screen.dart';

import '../services/tf_services.dart';
import '../models/prediction.dart';
import '../widgets/image_preview.dart';
import '../widgets/action_button.dart';
import '../widgets/result_card.dart';

class HomeScreen extends StatefulWidget {
  final TFService tfService;

  const HomeScreen({super.key, required this.tfService});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  File? image;
  List<Prediction> results = [];

  final picker = ImagePicker();

  /// Tomar foto
  Future<void> takePhoto() async {

    final picked = await picker.pickImage(
      source: ImageSource.camera,
    );

    if (picked != null) {
      setState(() {
        image = File(picked.path);
        results = [];
      });
    }
  }

  /// Elegir imagen de galería
  Future<void> pickFromGallery() async {

    final picked = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (picked != null) {
      setState(() {
        image = File(picked.path);
        results = [];
      });
    }
  }

  /// Ejecutar modelo
  Future<void> detect() async {

    if (image == null) return;

    final result = await widget.tfService.runModel(image!);

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ResultScreen(
          image: image!,
          results: result,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(


      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xFFFFFFFF),
      ),

      body: Container(

        decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFFFFFFF),
                Color(0xFFF5F5F7),
                Color(0xFFEFF1F4),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),

        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            children: [

              const SizedBox(height: 10),

              /// Título
              const Text(
                
                "Detect Objects",
                style: TextStyle(
                  color: Color.fromARGB(255, 19, 25, 34),
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),

              const SizedBox(height: 30),

              GlassCard(
                child: ImagePreview(image: image),
              ),

              const SizedBox(height: 50),

              /// Botones
              GlassCard(
                child: ActionButtons(
                    onCamera: takePhoto,
                    onGallery: pickFromGallery,
                    onDetect: detect,
                  ),
              ),
              const SizedBox(height: 30),

              /// Resultados (si decides mostrarlos aquí)
              Expanded(
                child: ListView.builder(
                  itemCount: results.length,
                  itemBuilder: (context, index) {

                    final prediction = results[index];

                    return ResultCard(
                      label: prediction.label,
                      confidence: prediction.confidence,
                    );
                  },
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}