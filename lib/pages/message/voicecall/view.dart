import 'package:flutter/material.dart';
import 'package:flutter_video_chat/pages/message/voicecall/controller.dart';
import 'package:get/get.dart';

class VoiceCallPage extends GetView<VoiceCallController> {
  const VoiceCallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("VoiceCallPage"),
      ),
    );
  }

  
}