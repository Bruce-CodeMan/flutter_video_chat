
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// check if the user has logged in
class RouteAuthMiddleware extends GetMiddleware {

  // priority smaller the better
  @override
  int? priority = 0;

  RouteAuthMiddleware({ required this.priority });

  @override
  RouteSettings? redirect(String? route) {
    
  }
}