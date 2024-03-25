// Import the libraries from the external
import 'package:get/get.dart';

// Import the custom controller
import 'package:flutter_video_chat/pages/message/controller.dart';

class MessageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MessageController>(() => MessageController());
  }

}