import 'package:flutter_video_chat/common/utils/http.dart';

import '../entities/user.dart';

class UserAPI {
  static Future<LoginResponseEntity> login({
    LoginRequestEntity? params
  }) async {
    var response = await HttpUtil().post(
      '/auth/google',
      data: params?.toJson()
    );
    return LoginResponseEntity.fromJson(response);
  }
}