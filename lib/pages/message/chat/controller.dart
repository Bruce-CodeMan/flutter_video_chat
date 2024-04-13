// Import the library from the external
import 'package:get/get.dart';

// Import the custom files
import 'package:flutter_video_chat/pages/message/chat/state.dart';

class ChatController extends GetxController {
  ChatController();

  final state = ChatState();
  late String docsId;

  @override
  void onInit() {
    super.onInit();
    var data = Get.parameters;
    print("data: $data");
    docsId = data["docsId"]!;
    state.toToken.value = data["toToken"] ?? "";
    state.toName.value = data["toName"] ?? "";
    state.toAvatar.value = data["toAvatar"] ?? "";
    state.toOnline.value = data["toOnline"] ?? "";
  }
}