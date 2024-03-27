// Import the libraries from the external
import 'package:get/get.dart';

// Import the custom state
import 'package:flutter_video_chat/pages/message/state.dart';
// Import the custom routes
import 'package:flutter_video_chat/common/routes/routes.dart';

class MessageController extends GetxController {
  MessageController();
  final state = MessageState();

  void goProfile() async{
    await Get.toNamed(AppRoutes.PROFILE);
  }
}