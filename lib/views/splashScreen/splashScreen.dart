import 'package:healthtick/controller/splashScreenController/splashScreenController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class splashScreen extends StatelessWidget {
  const splashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(splashScreenController());
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          width: 200,
          height: 200,
          color: Colors.black,
          child: Image.asset(
            "assets/healthTick logo.png",
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
