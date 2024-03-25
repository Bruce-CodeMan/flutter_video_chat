// Import the libraries from the external
import 'package:get/get.dart';

// Import the custom files
import 'package:flutter_video_chat/common/entities/entities.dart';

class UserStore extends GetxController {
  static UserStore get to => Get.find();

  // Whether the user logged
  final _isLogin = false.obs;
  // the user token
  String token = "";
  final _profile = UserItem().obs;

  bool get isLogin => _isLogin.value;
  UserItem get profile => _profile.value;
  bool get hasToken => token.isNotEmpty;

  @override
  void onInit() {
    super.onInit();
    
  }
}