import 'dart:io';
import 'package:flutter/material.dart';

import '../models/prediction.dart';
import '../widgets/result_card.dart';
import '../widgets/gradient_back.dart';

class ResultScreen extends StatelessWidget {

  final File image;
  final List<Prediction> results;

  const ResultScreen({
    super.key,
    required this.image,
    required this.results,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [

              /// APP BAR
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [

                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),

                    const SizedBox(width: 10),

                    

                  ],
                ),
              ),

              /// IMAGE
              Container(
                margin: const EdgeInsets.all(20),
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 10,
                    )
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.file(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              /// RESULTS
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),

                  child: ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (context,index){

                      final prediction = results[index];

                      return ResultCard(
                        label: prediction.label,
                        confidence: prediction.confidence,
                      );
                    },
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}