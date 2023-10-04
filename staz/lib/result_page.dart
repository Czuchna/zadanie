import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final int outlier;
  const ResultPage({Key? key, required this.outlier}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Result'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          '$outlier',
          style: const TextStyle(fontSize: 200, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
