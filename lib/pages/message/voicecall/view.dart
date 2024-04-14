import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_video_chat/common/values/values.dart';
import 'package:flutter_video_chat/pages/message/voicecall/controller.dart';
import 'package:get/get.dart';

import 'package:flutter_video_chat/common/style/style.dart';

class VoiceCallPage extends GetView<VoiceCallController> {
  const VoiceCallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("voiceCall")),
      backgroundColor: AppColors.primaryThirdBackground,
      body: Obx(() => _buildBody())
    );
  }
  // 聊天时长
  Widget _buildChatTime() {
    return Text(
            controller.state.callTime.value,
            style: TextStyle(
              color: AppColors.primaryElementText,
              fontSize: 14.sp,
              fontWeight: FontWeight.normal
            ),
          );
  }

  // 头像
  Widget _buildAvatar() {
    return Container(
            width: 70.h,
            height: 70.h,
            margin: EdgeInsets.only(top: 150.h),
            child: Image.network(controller.state.toAvatar.value),
          );
  }

  Widget _buildName() {
    return Container(
            margin: EdgeInsets.only(top: 20.h, left: 30.w, right: 30.w),
            child: Text(
              controller.state.toName.value,
              style: TextStyle(
                color: AppColors.primaryElementText,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          );
}

  // 下方的三个按钮
  Widget _buildMicrophoneSection() {
    return Column(
              children: [
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.all(15.w),
                    width: 60.w,
                    height: 60.w,
                    decoration: BoxDecoration(
                      color: controller.state.openMicrophone.value
                        ? AppColors.primaryElementText
                        : AppColors.primaryText,
                      borderRadius: BorderRadius.all(Radius.circular(30.w))
                    ),
                    child: controller.state.openMicrophone.value
                      ? Image.asset(Asset.getIconPath("b_microphone"))
                      : Image.asset(Asset.getIconPath("a_microphone")),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.h),
                  child: Text(
                    "Microphone",
                    style: TextStyle(
                      color: AppColors.primaryElementText,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal
                    ),
                  ),
                )
              ],
            );
  }

  Widget _buildphoneSection() {
    return Column(
            children: [
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.all(15.w),
                  width: 60.w,
                  height: 60.w,
                  decoration: BoxDecoration(
                    color: controller.state.isJoined.value
                      ? AppColors.primaryElementBg
                      : AppColors.primaryElementStatus,
                    borderRadius: BorderRadius.all(Radius.circular(30.w))
                  ),
                  child: controller.state.isJoined.value
                    ? Image.asset(Asset.getIconPath("a_phone"))
                    : Image.asset(Asset.getIconPath("a_telephone")),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.h),
                child: Text(
                  controller.state.isJoined.value ? "Disconnect": "Connect",
                  style: TextStyle(
                    color: AppColors.primaryElementText,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.normal
                  ),
                ),
              )
            ],
          );
  }

  Widget _buildSpeakerSection() {
    return Column(
            children: [
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.all(15.w),
                  width: 60.w,
                  height: 60.w,
                  decoration: BoxDecoration(
                    color: controller.state.enableSpeaker.value
                      ? AppColors.primaryElementText
                      : AppColors.primaryText,
                    borderRadius: BorderRadius.all(Radius.circular(30.w))
                  ),
                  child: controller.state.enableSpeaker.value
                    ? Image.asset(Asset.getIconPath("b_trumpet"))
                    : Image.asset(Asset.getIconPath("a_trumpet")),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.h),
                child: Text(
                  "Speaker",
                  style: TextStyle(
                    color: AppColors.primaryElementText,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.normal
                  ),
                ),
              )
            ],
          );
  }

  Widget _buildBody() {
    return Stack(
          children: [
            Positioned(
              top: 10.h,
              left: 30.w,
              right: 30.w,
              child: Column(
                children: [
                  _buildChatTime(),
                  _buildAvatar(),
                  _buildName()
                ],
              )
            ),
            Positioned(
              bottom: 80.h,
              left: 30.w,
              right: 30.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // microPhone section
                  _buildMicrophoneSection(),
                  _buildphoneSection(),
                  _buildSpeakerSection()
                ],
              )
            ) 
          ],
        );
  }
}