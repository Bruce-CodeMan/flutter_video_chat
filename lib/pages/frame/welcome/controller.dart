// Import the libraries from the external.
import 'package:get/get.dart';

// Import the custom state files.
import 'package:flutter_video_chat/pages/frame/welcome/state.dart';
import 'package:flutter_video_chat/common/routes/names.dart';

class WelcomeController extends GetxController {
  WelcomeController();

  final title = "Chatty .";
  final state = WelcomeState();

  @override
  void onReady(){
    super.onReady();
    Future.delayed(
      const Duration(seconds: 3), () => Get.offAllNamed(AppRoutes.signIn),
    );
  }
}