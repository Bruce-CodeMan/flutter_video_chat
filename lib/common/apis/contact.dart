import 'package:flutter_video_chat/common/utils/http.dart';

import '../entities/contact.dart';

class ContactAPI {
  static Future<ContactResponseEntity> getContact() async {
    var response = await HttpUtil().get(
      'user'
    );
    return ContactResponseEntity.fromJson(response);
  }
}