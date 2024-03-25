import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Global {
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    // Get.put<>
  }
}