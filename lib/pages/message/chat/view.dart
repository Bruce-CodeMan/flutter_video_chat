import 'package:flutter/material.dart';
import 'package:flutter_video_chat/pages/message/chat/controller.dart';
import 'package:get/get.dart';

class ChatPage extends GetView<ChatController> {
  const ChatPage({super.key});

  AppBar _buildAppBar() {
    return AppBar(
      title: Obx((){
        return Container(
          child: Text(
            "${controller.state.toName}"
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
    );
  }
}
