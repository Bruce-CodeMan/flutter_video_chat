import 'package:get/get.dart';

class VoiceCallState {
  RxBool isJoined = false.obs;
  RxBool openMicrophone = true.obs;
  RxBool enableSpeaker = true.obs;
  RxString callTime = "00.00".obs;
  RxString callStatus = "not connected".obs;

  var toToken = "".obs;
  var toName = "".obs;
  var toAvatar = "".obs;
  var docsId = "".obs;
  var callRole = "audience".obs;
  
}