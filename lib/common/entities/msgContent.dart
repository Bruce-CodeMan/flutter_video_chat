import 'package:cloud_firestore/cloud_firestore.dart';

class MsgContent {
  final String? token;
  final String? content;
  final String? type;
  final Timestamp? addTime;

  MsgContent({
    this.token,
    this.content,
    this.type,
    this.addTime
  });

  factory MsgContent.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options
  ) {
    final data = snapshot.data();
    return MsgContent(
      token: data?["token"],
      content: data?["content"],
      type: data?["type"],
      addTime: data?["addTime"]
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if(token != null) "token": token,
      if(content != null) "content": content,
      if(type != null) "type": type,
      if(addTime != null) "addTime": addTime
    };
  }
}