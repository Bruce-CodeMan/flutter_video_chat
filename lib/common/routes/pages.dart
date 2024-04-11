// Import the core libraries
import 'package:get/get.dart';

// Import the custom routes
import 'package:flutter_video_chat/common/routes/names.dart';
// Import the custom middlewares
import 'package:flutter_video_chat/common/middlewares/middlewares.dart';
// Import the custom pages and bindings
import 'package:flutter_video_chat/pages/frame/welcome/index.dart';
import 'package:flutter_video_chat/pages/message/index.dart';
import 'package:flutter_video_chat/pages/frame/sign_in/index.dart';
import 'package:flutter_video_chat/pages/profile/index.dart';

class AppPages {
  static const initial = AppRoutes.initial;

  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.initial,
      page: () => const WelcomePage(),
      binding: WelcomeBinding()
    ),
    GetPage(
      name: AppRoutes.message,
      page: () => const MessagePage(),
      binding: MessageBinding(),
      middlewares: [RouteAuthMiddleware(priority: 1)]
    ),
    GetPage(
      name: AppRoutes.signIn,
      page: () => const SignInPage(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfilePage(),
      binding: ProfileBinding()
    )
  ];
}