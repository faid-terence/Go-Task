import 'package:flutter/material.dart';
import 'package:todo/components/myButton.dart';
import 'package:easy_localization/easy_localization.dart';

class Homepage extends StatelessWidget {
  final VoidCallback onGetStarted;
  const Homepage({super.key, required this.onGetStarted});

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
            Text(
              "welcome_title".tr(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),

            const SizedBox(height: 20),

            // subtitle
            Text(
              "welcome_subtitle".tr(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 80),

            // button
            Mybutton(
              text: "get_started".tr(),
              onPressed: onGetStarted,
            ),
          ],
        ),
      ),
    );
  }
}
