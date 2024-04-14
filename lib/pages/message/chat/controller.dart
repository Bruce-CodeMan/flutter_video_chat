// Import the library from the external
import 'package:flutter_video_chat/common/routes/names.dart';
import 'package:get/get.dart';

// Import the custom files
import 'package:flutter_video_chat/pages/message/chat/state.dart';

class ChatController extends GetxController {
  ChatController();

  final state = ChatState();
  late String docsId;

  void goMore() {
    state.moreStatus.value = state.moreStatus.value ? false : true;
  }

  void callAudio() {
    state.moreStatus.value = false;
    Get.toNamed(AppRoutes.voiceCall,
      parameters: {
        "docsId": docsId,
        "toToken": state.toToken.value,
        "toName": state.toName.value,
        "toAvatar": state.toAvatar.value
      }
    );
  }

  @override
  void onInit() {
    super.onInit();
    var data = Get.parameters;
    docsId = data["docsId"]!;
    state.toToken.value = data["toToken"] ?? "";
    state.toName.value = data["toName"] ?? "";
    state.toAvatar.value = data["toAvatar"] ?? "";
    state.toOnline.value = data["toOnline"] ?? "";
  }
}