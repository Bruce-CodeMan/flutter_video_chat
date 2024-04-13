import 'package:cloud_firestore/cloud_firestore.dart';

class Msg {
  final String? fromToken;
  final String? toToken;
  final String? fromName;
  final String? toName;
  final String? fromAvatar;
  final String? toAvatar;
  final int? fromOnline;
  final int? toOnline;
  final int? fromMsgNum;
  final int? toMsgNum;
  final String? lastMsg;
  final Timestamp? lastTime;
  final int? msgNum;

  Msg({
    this.fromToken,
    this.toToken,
    this.fromName,
    this.toName,
    this.fromAvatar,
    this.toAvatar,
    this.fromOnline,
    this.toOnline,
    this.fromMsgNum,
    this.toMsgNum,
    this.lastMsg,
    this.lastTime,
    this.msgNum
  });

  factory Msg.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ){
    final data = snapshot.data();
    return Msg(
      fromToken: data?["fromToken"],
      toToken: data?["toToken"],
      fromName: data?["fromName"],
      toName: data?["toName"],
      fromAvatar: data?["fromAvatar"],
      toAvatar: data?["toAvatar"],
      fromOnline: data?["fromOnline"],
      toOnline: data?["toOnline"],
      fromMsgNum: data?["fromMsgNum"],
      toMsgNum: data?["toMsgNum"],
      lastMsg: data?["lastMsg"],
      lastTime: data?["lastTime"],
      msgNum: data?["msgNum"]
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      if(fromToken != null) "fromToken": fromToken,
      if(toToken != null) "toToken": toToken,
      if(fromName != null) "fromName": fromName,
      if(toName != null) "toName": toName,
      if(fromAvatar != null) "fromAvatar": fromAvatar,
      if(toAvatar != null) "toAvatar": toAvatar,
      if(fromOnline != null) "fromOnline": fromOnline,
      if(toOnline != null) "toOnline": toOnline,
      if(fromMsgNum != null) "fromMsgNum": fromMsgNum,
      if(toMsgNum != null) "toMsgNum": toMsgNum,
      if(lastMsg != null) "lastMsg": lastMsg,
      if(lastTime != null) "lastTime": lastTime,
      if(msgNum != null) "msgNum": msgNum,
    };
  }
}

