// Import the library from the external
import 'package:get/get.dart';

// Import the custom files
import 'package:flutter_video_chat/pages/message/chat/controller.dart';

class ChatBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatController>(() => ChatController());
  }

}