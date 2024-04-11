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
  final _profile = TokenEntity().obs;

  bool get isLogin => _isLogin.value;
  TokenEntity get profile => _profile.value;
  bool get hasToken => token.isNotEmpty;
  set setIsLogin(login) => _isLogin.value = login;

  @override
  void onInit() {
    super.onInit();
    token = StorageService.to.getString(storageUserAccessKey);
    var profileOffline = StorageService.to.getString(storageUserProfileKey);
    if(profileOffline.isNotEmpty) {
      _isLogin.value = true;
      _profile(TokenEntity.fromJson(jsonDecode(profileOffline)));
    }
  }

  // Save the token info
  Future<void> setToken(String value) async {
    await StorageService.to.setString(storageUserAccessKey, value);
    token = value;
  }

  // Get the profile info
  Future<String> getProfile() async {
    if(token.isEmpty) return "";
    return StorageService.to.getString(storageUserProfileKey);
  }

  // Save the profile info
  Future<void> saveProfile(TokenEntity profile) async {
    _isLogin.value = true;
    StorageService.to.setString(storageUserProfileKey, jsonEncode(profile));
    _profile(profile);
    setToken(profile.accessToken!);
  }

  // Remove the info
  Future<void> onLogout() async {
    await StorageService.to.remove(storageUserAccessKey);
    await StorageService.to.remove(storageUserProfileKey);
    _isLogin.value = false;
    token = '';
    Get.offAllNamed(AppRoutes.signIn);
  }
}