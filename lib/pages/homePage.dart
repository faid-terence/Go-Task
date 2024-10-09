import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:todo/components/myButton.dart';

class Homepage extends StatelessWidget {
  final VoidCallback onGetStarted;
  Homepage({super.key, required this.onGetStarted});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // image
          const Image(
            image: AssetImage(
              "images/welcome.png",
            ),
          ),

          const SizedBox(height: 20),

          // title
          const Text(
            "Welcome to Go Task",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),

          const SizedBox(height: 20),

          // subtitle
          const Text("Organize your life with Todo App, \nand get stuff done",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              )),

          const SizedBox(height: 80),

          // button
          Mybutton(
              text: "Get Started",
              onPressed: () {
                onGetStarted();
              }),
        ],
      ),
    ));
  }
}
