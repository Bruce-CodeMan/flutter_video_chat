import 'package:flutter_video_chat/pages/message/voicecall/controller.dart';
import 'package:get/get.dart';

class VoiceCallBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VoiceCallController>(() => VoiceCallController());
  }
  
}