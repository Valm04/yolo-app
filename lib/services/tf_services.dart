import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:logger/logger.dart';

import '../models/prediction.dart';
import '../utils/constant.dart';

class TFService {

  Interpreter? _interpreter;

  final logger = Logger();

  List<String> _labels = [];

  /// Cargar modelo y labels
  Future<void> loadModel() async {

    try {

      _interpreter = await Interpreter.fromAsset(
        AppConstants.modelPath,
      );

      logger.i("Model loaded");

      await _loadLabels();

      if (_interpreter != null) {

        var inputShape = _interpreter!.getInputTensor(0).shape;
        var outputShape = _interpreter!.getOutputTensor(0).shape;

        logger.i("Input shape: $inputShape");
        logger.i("Output shape: $outputShape");
      }

    } catch (e) {

      logger.e("Error loading model: $e");

    }
  }

  /// cargar labels
  Future<void> _loadLabels() async {

    final raw = await rootBundle.loadString(
      AppConstants.labelsPath,
    );

    _labels = raw.split('\n');
  }

  /// ejecutar modelo
  Future<List<Prediction>> runModel(File imageFile) async {

    if (_interpreter == null) {

      logger.e("Interpreter not initialized");

      return [];

    }

    final bytes = await imageFile.readAsBytes();

    img.Image? image = img.decodeImage(bytes);

    if (image == null) {

      logger.e("Image decode failed");

      return [];
    }

    image = img.bakeOrientation(image);

    img.Image resized = img.copyResize(
      image,
      width: AppConstants.inputSize,
      height: AppConstants.inputSize,
    );

    var input = List.generate(
      1 * AppConstants.inputSize * AppConstants.inputSize * 3,
      (index) => 0.0,
    ).reshape([
      1,
      AppConstants.inputSize,
      AppConstants.inputSize,
      3
    ]);

    for (int y = 0; y < AppConstants.inputSize; y++) {

      for (int x = 0; x < AppConstants.inputSize; x++) {

        var pixel = resized.getPixel(x, y);

        // Normalización correcta para MobileNet
        input[0][y][x][0] = (pixel.r - 127.5) / 127.5;
        input[0][y][x][1] = (pixel.g - 127.5) / 127.5;
        input[0][y][x][2] = (pixel.b - 127.5) / 127.5;
      }
    }

    var output = List.filled(
      1 * AppConstants.numClasses,
      0.0,
    ).reshape([1, AppConstants.numClasses]);

    try {

      _interpreter!.run(input, output);

      logger.i("Inference OK");

      List<double> scores = List<double>.from(output[0]);

      return _processResults(scores);

    } catch (e) {

      logger.e("Inference error: $e");

      return [];
    }
  }

  /// ordenar resultados
  List<Prediction> _processResults(List<double> scores) {

    List<int> sorted =
        List.generate(scores.length, (i) => i);

    sorted.sort((a, b) => scores[b].compareTo(scores[a]));

    List<Prediction> predictions = [];

    for (int i = 0; i < 5; i++) {

      int index = sorted[i];

      predictions.add(

        Prediction(
          label: _labels[index],
          confidence: scores[index],
        ),

      );
    }

    return predictions;
  }

  void close() {

    _interpreter?.close();

  }
}