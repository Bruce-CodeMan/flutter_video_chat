import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_video_chat/common/style/color.dart';
import 'package:flutter_video_chat/common/values/asset.dart';

class IconAction extends StatelessWidget {
  final String iconName;
  final VoidCallback onPressed;

  const IconAction({
    super.key,
    required this.onPressed,
    required this.iconName
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 40.w,
        height: 40.w,
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40.w),
          color: AppColors.primaryBackground,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(1, 1)
            )
          ]
        ),
        child: Image.asset(Asset.getIconPath(iconName)),
      ),
    );
  }
}
