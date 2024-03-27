// Import the libraries from the external
import 'dart:convert';

import 'package:flutter_video_chat/common/routes/names.dart';
import 'package:flutter_video_chat/common/values/storage.dart';
import 'package:get/get.dart';

// Import the custom files
import 'package:flutter_video_chat/common/entities/entities.dart';
import 'package:flutter_video_chat/common/services/services.dart';

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
    token = StorageService.to.getString(STORAGE_USER_TOKEN_KEY);
    var profileOffline = StorageService.to.getString(STORAGE_USER_PROFILE_KEY);
    if(profileOffline.isNotEmpty) {
      _isLogin.value = true;
      _profile(UserItem.fromJson(jsonDecode(profileOffline)));
    }
  }

  // Save the token info
  Future<void> setToken(String value) async {
    await StorageService.to.setString(STORAGE_USER_TOKEN_KEY, value);
    token = value;
  }

  // Get the profile info
  Future<String> getProfile() async {
    if(token.isEmpty) return "";
    return StorageService.to.getString(STORAGE_USER_PROFILE_KEY);
  }

  // Save the profile info
  Future<void> saveProfile(UserItem profile) async {
    _isLogin.value = true;
    StorageService.to.setString(STORAGE_USER_PROFILE_KEY, jsonEncode(profile));
    _profile(profile);
    setToken(profile.accessToken!);
  }

  // Remove the info
  Future<void> onLogout() async {
    await StorageService.to.remove(STORAGE_USER_TOKEN_KEY);
    await StorageService.to.remove(STORAGE_USER_PROFILE_KEY);
    _isLogin.value = false;
    token = '';
    Get.offAllNamed(AppRoutes.signIn);
  }
}