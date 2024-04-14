import 'package:flutter_video_chat/pages/message/voicecall/state.dart';
import 'package:get/get.dart';

class VoiceCallController extends GetxController {
  VoiceCallController();

  final VoiceCallState state = VoiceCallState();

  @override
  void onInit() {
    super.onInit();
    var data = Get.parameters;
    state.toName.value = data["toName"] ?? "";
    state.toToken.value = data["toToken"] ?? "";
    state.toAvatar.value = data["toAvatar"] ?? "";
  }
}