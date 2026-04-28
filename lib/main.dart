/* import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:logger/logger.dart';
import 'service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final tfService = TFService();
  await tfService.loadModel();

  runApp(MyApp(tfService: tfService));
}

class MyApp extends StatelessWidget {
  final TFService tfService;

  const MyApp({super.key, required this.tfService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TF Lite Demo',
      debugShowCheckedModeBanner: false,
      home: ModelScreen(tfService: tfService),
    );
  }
}

class ModelScreen extends StatefulWidget {
  final TFService tfService;

  const ModelScreen({super.key, required this.tfService});

  @override
  State<ModelScreen> createState() => ModelScreenState();
}

class ModelScreenState extends State<ModelScreen> {
  File? _image;
  String _output = "Selecciona una imagen";

  List<String> _labels = [];

  bool _isRunning = false;

  final customLogger = Logger();

  @override
  void initState() {
    super.initState();
    _loadLabels();
  }

  Future<void> _loadLabels() async {
    final rawLabels = await rootBundle.loadString('assets/models/labels.txt');

    setState(() {
      _labels = rawLabels.split('\n');
    });
  }

  Future<void> _takePhoto() async {
    final picker = ImagePicker();

    final picked = await picker.pickImage(source: ImageSource.camera);

    if (picked != null) {
      setState(() {
        _image = File(picked.path);
      });
    }
  }

  Future<void> _runModel() async {
    if (_image == null) return;

    if (_isRunning) return;

    _isRunning = true;

    List<double> result = await widget.tfService.runModel(_image!);

    if (result.isEmpty) {
      setState(() {
        _output = "Error ejecutando modelo";
      });
      _isRunning = false;
      return;
    }

    var sorted = List.generate(result.length, (i) => i);

    sorted.sort((a, b) => result[b].compareTo(result[a]));

    String text = "";

    for (int i = 0; i < 5; i++) {
      int index = sorted[i];

      if (index == 0) continue;

      text +=
          "${_labels[index - 1]} ${(result[index] * 100).toStringAsFixed(2)}%\n";
    }

    setState(() {
      _output = text;
    });

    _isRunning = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TF Lite Image Classification"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image == null
                ? const Text("No image selected")
                : Image.file(_image!, height: 200),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: _takePhoto,
              child: const Text("Tomar Foto"),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: _runModel,
              child: const Text("Detectar"),
            ),

            const SizedBox(height: 20),

            Text(
              _output,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}  */

import 'package:flutter/material.dart';
import 'services/tf_services.dart';
import 'screens/home_screen.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  final tfService = TFService();

  await tfService.loadModel();

  runApp(MyApp(tfService: tfService));
}

class MyApp extends StatelessWidget {

  final TFService tfService;

  const MyApp({super.key, required this.tfService});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Vision App",
      home: HomeScreen(tfService: tfService),
    );
  }
}