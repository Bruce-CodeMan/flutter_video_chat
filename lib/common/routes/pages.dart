import 'package:get/get.dart';

import 'package:flutter_video_chat/common/routes/names.dart';
import 'package:flutter_video_chat/pages/frame/welcome/index.dart';

class AppPages {
  static const initial = AppRoutes.initial;

  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.initial,
      page: () => const WelcomePage(),
      binding: WelcomeBinding()
    )
  ];
}