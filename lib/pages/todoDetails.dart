import 'package:flutter/material.dart';

class Tododetails extends StatelessWidget {
  const Tododetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo Details"),
      ),
      body: const Center(
        child: Text("Todo Details"),
      ),
    );
  }
}
