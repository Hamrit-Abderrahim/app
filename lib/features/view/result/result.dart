import 'package:flutter/material.dart';

class CancerDiagnosis extends StatelessWidget {
  final String result;

  const CancerDiagnosis({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Prediction Result: $result'),
          ],
        ),
      ),
    );
  }
}
