import 'package:flutter_video_chat/common/utils/http.dart';

import '../entities/contact.dart';

class ContactAPI {
  static Future<ContactResponseEntity> postContact() async {
    var response = await HttpUtil().get(
      'user'
    );
    print("response: $response");
    return ContactResponseEntity.fromJson(response);
  }
}