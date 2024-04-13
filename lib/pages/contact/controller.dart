// Import the core library

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

// Import the custom files
import 'package:flutter_video_chat/common/apis/apis.dart';
import 'package:flutter_video_chat/common/entities/entities.dart';
import 'package:flutter_video_chat/common/store/store.dart';
import 'package:flutter_video_chat/pages/contact/state.dart';

class ContactController extends GetxController {
  ContactController();

  final state = ContactState();
  final id = UserStore.to.profile.id;
  final db = FirebaseFirestore.instance;

  @override
  void onReady(){
    super.onReady();
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

  Future<void> goChat(ContactItem item) async {
    var fromMessages = await db.collection("message").withConverter(
      fromFirestore: Msg.fromFirestore,
      toFirestore: (Msg msg, options) => msg.toFirestore()
    ).where("fromToken", isEqualTo: id).where("toToken", isEqualTo: item.id).get();

    print("---fromMessage: ${fromMessages.docs.isEmpty}");

    var toMessages = await db.collection("message").withConverter(
        fromFirestore: Msg.fromFirestore,
        toFirestore: (Msg msg, options) => msg.toFirestore()
    ).where("fromToken", isEqualTo: item.id).where("toToken", isEqualTo: id).get();

    print("---toMessages: ${toMessages.docs.isEmpty}");

    if(fromMessages.docs.isEmpty && toMessages.docs.isEmpty) {
      var profile = UserStore.to.profile;
      var msgData = Msg(
          fromToken: profile.id,
          toToken: item.id,
          fromName: profile.name,
          toName: item.name,
          fromAvatar: profile.avatar,
          toAvatar: item.avatar,
          fromOnline: profile.online,
          toOnline: item.online,
          lastMsg: "",
          lastTime: Timestamp.now(),
          msgNum: 0
      );
      var docsId = await db.collection("message").withConverter(
          fromFirestore: Msg.fromFirestore,
          toFirestore: (Msg msg, options) => msg.toFirestore()
      ).add(msgData);
      Get.toNamed("/chat",
          parameters: {
            "docsId": docsId.id,
            "toToken": item.id ?? "",
            "toName": item.name ?? "",
            "toAvatar": item.avatar ?? "",
            "toOnline": item.online.toString()
          }
      );
      print("----adding user in the document done----");
    }else {
        if(fromMessages.docs.isNotEmpty) {
          Get.toNamed("/chat",
            parameters: {
              "docsId": fromMessages.docs.first.id,
              "toToken": item.id ?? "",
              "toName": item.name ?? "",
              "toAvatar": item.avatar ?? "",
              "toOnline": item.online.toString()
            }
          );
        }
        if(toMessages.docs.isNotEmpty) {
          Get.toNamed("/chat",
            parameters: {
              "docsId": toMessages.docs.first.id,
              "toToken": item.id ?? "",
              "toName": item.name ?? "",
              "toAvatar": item.avatar ?? "",
              "toOnline": item.online.toString()
            }
          );
        }
      print("----users are older----");
    }
  }
}