// Import the core library
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_video_chat/common/apis/apis.dart';
import 'package:get/get.dart';

// Import the custom files
import 'package:flutter_video_chat/pages/contact/state.dart';

class ContactController extends GetxController {
  ContactController();

  final state = ContactState();

  @override
  void onReady(){
    super.onReady();
    print(".....");
    asyncLoadAllData();
  }

  asyncLoadAllData() async {
    EasyLoading.show(
        indicator: const CircularProgressIndicator(),
        maskType: EasyLoadingMaskType.clear,
        dismissOnTap: true
    );
    state.contactList.clear();

    var result = await ContactAPI.getContact();
    if(result.code == 200) {
      state.contactList.addAll(result.data!);
    }
    EasyLoading.dismiss();
  }
}