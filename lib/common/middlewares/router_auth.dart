
import 'package:flutter/material.dart';
import 'package:flutter_video_chat/common/store/store.dart';
import 'package:get/get.dart';

import '../routes/routes.dart';

/// check if the user has logged in
class RouteAuthMiddleware extends GetMiddleware {

  final int _priority;

  RouteAuthMiddleware({required int priority}) : _priority = priority;

  @override
  int get priority => _priority;

  @override
  RouteSettings? redirect(String? route) {
    if(UserStore.to.isLogin || route == AppRoutes.signIn || route == AppRoutes.initial) {
      return null;
    }else {
      Future.delayed(
        const Duration(seconds: 2), () => Get.snackbar("Tips", "Login expired, please login again!")
      );
      return const RouteSettings(name: AppRoutes.signIn);
    }
  }
}