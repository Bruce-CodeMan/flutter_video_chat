// Import the core libraries.
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

// Import the custom state files.
import 'package:flutter_video_chat/pages/frame/welcome/state.dart';

class WelcomeController extends GetxController {
  WelcomeController();

  final title = "Chatty .";
  final state = WelcomeState();

  @override
  void onReady(){
    super.onReady();
    debugPrint("WelcomeController");
  }
}