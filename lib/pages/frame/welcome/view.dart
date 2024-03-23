// Import the core library
import 'package:flutter/material.dart';

// Import the library from the external
import 'package:get/get.dart';

// Import the custom controller
import 'package:flutter_video_chat/pages/frame/welcome/controller.dart';
// Import the custom style
import 'package:flutter_video_chat/common/style/style.dart';

class WelcomePage extends GetView<WelcomeController> {
  const WelcomePage({super.key});

  Widget _buildPageHeadTitle(String title) {
    return Container(
      margin: const EdgeInsets.only(top: 350),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: AppColors.primaryElementText,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            fontSize: 45
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryElement,
      body: SizedBox(
        width: 360,
        height: 780,
        child: _buildPageHeadTitle(controller.title),
      ),
    );
  }
}
