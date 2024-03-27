// Import the core library
import 'package:get/get.dart';

// Import the custom controller
import 'package:flutter_video_chat/pages/profile/controller.dart';

class ProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController());
  }

}