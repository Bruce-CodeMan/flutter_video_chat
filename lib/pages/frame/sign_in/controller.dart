// Import the core library
import 'package:flutter/material.dart';
import 'package:flutter_video_chat/common/routes/names.dart';

// Import the libraries from the external
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';

// Import the custom state
import 'package:flutter_video_chat/pages/frame/sign_in/state.dart';
// Import the custom entities
import 'package:flutter_video_chat/common/entities/entities.dart';
// Import the custom store
import 'package:flutter_video_chat/common/store/store.dart';

class SignInController extends GetxController {
  SignInController();
  final state = SignInState();

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'openid'
    ]
  );

  void handleSignIn(String type) async{
    // 1.email 2. google  3.facebook  4.apple  5. phone
    try{
      if(type == "phone number") {
        debugPrint("You are logging in with phone number");
      }else if(type == "google"){
        var user = await _googleSignIn.signIn();
        if(user != null) {
          String? displayName = user.displayName;
          String email = user.email;
          String id = user.id;
          String photoUrl = user.photoUrl ?? "assets/icons/google.png";
          LoginRequestEntity loginRequestEntity = LoginRequestEntity();
          loginRequestEntity.avatar = photoUrl;
          loginRequestEntity.name = displayName;
          loginRequestEntity.email = email;
          loginRequestEntity.openId = id;
          loginRequestEntity.type = 2;
          asyncPostAllData();
        }
        debugPrint("You are logging in with google");
      }else {
        debugPrint("login type not sure");
      }
    }catch(e) {
      debugPrint("Error Login: $e");
    }
  }

  asyncPostAllData() {
    /*
      1. save in the database
      2. save in the localStorage
     */
    UserStore.to.setIsLogin = true;
    Get.offAllNamed(AppRoutes.message);
  }
}