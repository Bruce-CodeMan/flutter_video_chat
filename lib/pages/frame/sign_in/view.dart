// Import the core library
import 'package:flutter/material.dart';

// Import the library from the external
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Import the custom controller
import 'package:flutter_video_chat/pages/frame/sign_in/controller.dart';
// Import the custom style(e.g. , background color & text color)
import 'package:flutter_video_chat/common/style/style.dart';
// Import the custom values
import 'package:flutter_video_chat/common/values/values.dart';

class SignInPage extends GetView<SignInController> {
  const SignInPage({super.key});

  Widget _buildLogo() {
    return Container(
      margin: EdgeInsets.only(top: 100.h, bottom: 80.h),
      child: Text(
        "chatty .",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.primaryText,
          fontWeight: FontWeight.bold,
          fontSize: 34.sp
        ),
      ),
    );
  }

  Widget _buildThirdPartyLogin(String loginType, String logo) {
    return GestureDetector(
      onTap: (){
        // TODO operation of the login
        debugPrint("login: $loginType");
        controller.handleSignIn(logo);
      },
      child: Container(
        width: 295.w,
        height: 44.h,
        padding: EdgeInsets.all(10.h),
        margin: EdgeInsets.only(bottom: 15.h),
        decoration: BoxDecoration(
            color: AppColors.primaryBackground,
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
          mainAxisAlignment: logo == "" ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            logo == ""
                ? Container()
                : Container(
              padding: EdgeInsets.only(left: 40.w, right: 30.w),
              child: Image.asset(Asset.getIconPath(logo)),
            ),
            Text(
              'Sign in with $loginType',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.primaryText,
                  fontWeight: FontWeight.normal,
                  fontSize: 14.sp
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      margin: EdgeInsets.only(top: 20.h, bottom: 35.h),
      child: Row(
        children: [
          Expanded(
              child: Divider(
                height: 2.h,
                indent: 40,
                color: AppColors.primarySecondaryElementText,
              )),
          const Text("or"),
          Expanded(
            child: Divider(
              endIndent: 40,
              height: 2.h,
              color: AppColors.primarySecondaryElementText,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSignUp() {
    return Container(
      margin: EdgeInsets.only(top: 40.h),
      child: Column(
        children: [
          Text(
            "Already have an account",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColors.primaryText,
                fontSize: 12.sp,
                fontWeight: FontWeight.normal
            ),
          ),
          GestureDetector(
            onTap: (){
              // TODO the operation of sign up
              debugPrint("sign up");
            },
            child: Text(
              "Sign up here",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primaryElement,
                fontWeight: FontWeight.normal,
                fontSize: 12.sp
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primarySecondaryBackground,
      body: Center(
        child: Column(
          children: [
            _buildLogo(),
            _buildThirdPartyLogin("Google", "google"),
            _buildThirdPartyLogin("Facebook", "facebook"),
            _buildThirdPartyLogin("Apple", "apple"),
            _buildDivider(),
            _buildThirdPartyLogin("phone number", ""),
            _buildSignUp()
          ],
        )
      ),
    );
  }}