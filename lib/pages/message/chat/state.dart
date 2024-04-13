// Import the library from the external
import 'package:get/get.dart';

// Import the custom entity
import 'package:flutter_video_chat/common/entities/entities.dart';

class ChatState {
  RxList<MsgContent> msgContentList = <MsgContent>[].obs;

  var toToken = "".obs;
  var toName = "".obs;
  var toAvatar = "".obs;
  var toOnline = "".obs;
  RxBool moreStatus = false.obs;
}