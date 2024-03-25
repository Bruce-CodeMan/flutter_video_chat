// Import the core library
import 'package:flutter/cupertino.dart';

// Import the library from the external
import 'package:get/get.dart';

// Import the custom controllers
import 'package:flutter_video_chat/common/services/services.dart';
import 'package:flutter_video_chat/common/store/store.dart';

class Global {
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Get.putAsync<StorageService>(() => StorageService().init());
    Get.put<UserStore>(UserStore());
  }
}