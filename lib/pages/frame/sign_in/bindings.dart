// Import the core library
import 'package:get/get.dart';

// Import the custom controller
import 'package:flutter_video_chat/pages/frame/sign_in/controller.dart';

class SignInBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignInController>(() => SignInController());
  }

}