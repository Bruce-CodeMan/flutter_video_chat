// Import the core library
import 'package:flutter/cupertino.dart';

// Import the library from the external
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_video_chat/firebase_options.dart';

// Import the custom controllers
import 'package:flutter_video_chat/common/services/services.dart';
import 'package:flutter_video_chat/common/store/store.dart';

class Global {
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await Get.putAsync<StorageService>(() => StorageService().init());
    Get.put<UserStore>(UserStore());
  }
}