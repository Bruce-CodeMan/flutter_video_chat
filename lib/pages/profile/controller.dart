// Import the core library
import 'package:flutter_video_chat/common/store/store.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Import the custom state
import 'package:flutter_video_chat/pages/profile/index.dart';

class ProfileController extends GetxController {
  ProfileController();

  final state = ProfileState();

  Future<void> goLogout() async {
    await GoogleSignIn().signOut();
    await UserStore.to.onLogout();
  }
}