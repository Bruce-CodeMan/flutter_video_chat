// Import the core libraries
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_video_chat/common/style/color.dart';
import 'package:flutter_video_chat/common/values/asset.dart';


// Import the library from the external
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Import the custom files
import 'package:flutter_video_chat/pages/message/chat/widgets/icon_action.dart';
import 'package:flutter_video_chat/pages/message/chat/controller.dart';

class ChatPage extends GetView<ChatController> {
  const ChatPage({super.key});

  AppBar _buildAppBar() {
    return AppBar(
      title: Obx(() => Text(controller.state.toName.value)),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 20.w),
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 44.w,
                height: 44.w,
                child: controller.state.toAvatar.value.isEmpty
                    ? const Image(image: AssetImage(Asset.accountHeaderPath))
                    : CachedNetworkImage(
                  imageUrl: controller.state.toAvatar.value,
                  height: 44.w,
                  width: 44.w,
                  imageBuilder: (context, imageProvider) =>
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(22.w)),
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.fill
                            )
                        ),
                      ),
                  errorWidget: (context, url, error) =>
                  const Image(image: AssetImage(Asset.accountHeaderPath)),
                )
              ),
              Positioned(
                right: 0.w,
                bottom: 5.w,
                height: 14.w,
                child: Container(
                  width: 14.w,
                  height: 14.w,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2.w, color: AppColors.primaryElementText),
                    borderRadius: BorderRadius.all(Radius.circular(22.w)),
                    color: controller.state.toOnline.value == "1"
                        ? AppColors.primaryElementStatus
                        : AppColors.primarySecondaryElementText
                  ),
                )
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildBody () {
      return Obx(() => SafeArea(
          child: Stack(
            children: [
              Positioned(
                  bottom: 0.h,
                  child: Container(
                    width: 360.w,
                    padding: EdgeInsets.only(left: 20.w, bottom: 10.h, right: 20.w, top: 10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 270.w,
                          padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                          decoration: BoxDecoration(
                              color: AppColors.primaryBackground,
                              borderRadius: BorderRadius.circular(5.w),
                              border: Border.all(color: AppColors.primarySecondaryElementText)
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 220.w,
                                child: TextField(
                                  keyboardType: TextInputType.multiline,
                                  autofocus: false,
                                  decoration: InputDecoration(
                                      hintText: "Message...",
                                      contentPadding: EdgeInsets.only(left: 15.w, top: 0, bottom: 0),
                                      border: const OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.transparent)
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.transparent)
                                      ),
                                      disabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.transparent)
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.transparent)
                                      ),
                                      hintStyle: const TextStyle(
                                          color: AppColors.primarySecondaryElementText
                                      )
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){},
                                child: SizedBox(
                                  width: 40.w,
                                  height: 40.h,
                                  child: Image.asset(Asset.getIconPath("send")),
                                ),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            controller.goMore();
                          },
                          child: Container(
                            height: 40.w,
                            width: 40.w,
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                                color: AppColors.primaryElement,
                                borderRadius: BorderRadius.all(Radius.circular(40.w))
                            ),
                            child: Image.asset(Asset.getIconPath("add")),
                          ),
                        ),

                      ],
                    ),
                  )),
              controller.state.moreStatus.value
                  ? Positioned(
                  bottom: 70.h,
                  right: 20.w,
                  height: 200.h,
                  width: 40.w,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconAction(iconName: "file"),
                      IconAction(iconName: "photo"),
                      IconAction(iconName: "call"),
                      IconAction(iconName: "video"),
                    ],
                  )
              )
                  : Container()
            ],
          )
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }
}
