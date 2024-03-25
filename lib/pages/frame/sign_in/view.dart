// Import the core library
import 'package:flutter/material.dart';

// Import the library from the external
import 'package:get/get_state_manager/src/simple/get_view.dart';

// Import the custom controller
import 'package:flutter_video_chat/pages/frame/sign_in/controller.dart';


class SignInPage extends GetView<SignInController> {
  const SignInPage({super.key});


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Sign In Page"),
      ),
    );
  }}