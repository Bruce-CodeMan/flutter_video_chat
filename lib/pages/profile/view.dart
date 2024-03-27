// Import the core library
import 'package:flutter/material.dart';

// Import the library from the external
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// Import the custom style
import 'package:flutter_video_chat/common/style/style.dart';
import 'package:flutter_video_chat/common/values/values.dart';
import 'package:flutter_video_chat/pages/profile/controller.dart';


class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  AppBar _buildAppBar() {
    return AppBar(
        title: Text(
          "Profile",
          style: TextStyle(
              color: AppColors.primaryText,
              fontSize: 16.sp,
              fontWeight: FontWeight.normal
          ),
        )
    );
  }

  Widget _buildProfilePhoto() {
    return Stack(
      children: [
        Container(
          width: 120.w,
          height: 120.w,
          margin: EdgeInsets.only(top: 0.h, bottom: 50.h),
          decoration: BoxDecoration(
            color: AppColors.primarySecondaryBackground,
            borderRadius: BorderRadius.all(Radius.circular(60.w)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 1)
              )
            ]
          ),
          child: Image(
            width: 120.w,
            height: 120.w,
            fit: BoxFit.fill,
            image: const AssetImage(Asset.accountHeaderPath),
          ),
        ),
        Positioned(
          bottom: 50.w,
          right: 0.w,
          height: 35.w,
          child: GestureDetector(
            onTap: (){
              // TODO Need to edit the picture
            },
            child: Container(
              height: 35.w,
              width: 35.w,
              padding: EdgeInsets.all(7.w),
              decoration: BoxDecoration(
                color: AppColors.primaryElement,
                borderRadius: BorderRadius.all(Radius.circular(40.w))
              ),
              child: Image.asset(Asset.getIconPath("edit")),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildCompleteBtn() {
    return GestureDetector(
      onTap: (){
        // TODO Need to operate complete
      },
      child: Container(
        width: 295.w,
        height: 44.h,
        margin: EdgeInsets.only(top: 60.h, bottom: 30.h),
        padding: EdgeInsets.all(0.h),
        decoration: BoxDecoration(
          color: AppColors.primaryElement,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1)
            )
          ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Complete",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primaryElementText,
                fontWeight: FontWeight.normal,
                fontSize: 14.sp
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutBtn() {
    return GestureDetector(
      onTap: () {
        Get.defaultDialog(
          title: "Are you sure to log out?",
          content: Container(),
          onConfirm: () {
            controller.goLogout();
          },
          backgroundColor: Colors.white,
          onCancel: () {},
          textConfirm: "Confirm",
          textCancel: "Cancel",
          confirmTextColor: Colors.white,
        );
      },
      child: Container(
        width: 295.w,
        height: 44.h,
        margin: EdgeInsets.only(top:0.h, bottom: 30.h),
        padding: EdgeInsets.all(0.h),
        decoration: BoxDecoration(
          color: AppColors.primarySecondaryElementText,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1)
            )
          ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Logout",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primaryElementText,
                fontWeight: FontWeight.normal,
                fontSize: 14.sp
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  child: Column(
                    children: [
                      _buildProfilePhoto(),
                      _buildCompleteBtn(),
                      _buildLogoutBtn()
                    ],
                  ),
                ),
              )
            ],
          )
      )
    );
  }
}
