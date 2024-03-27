// Import the core library
import 'package:flutter/material.dart';

// Import the libraries from the external
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

// Import the custom files
import 'package:flutter_video_chat/common/style/color.dart';
import 'package:flutter_video_chat/pages/message/controller.dart';

class MessagePage extends GetView<MessageController> {
  const MessagePage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  title: _headBar(),
                ),

              ],
            )
          ],
        )
      )
    );
  }

  Widget _headBar() {
    return Center(
      child: Container(
        width: 320.w,
        height: 44.w,
        margin: EdgeInsets.only(top: 20.h, bottom: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                GestureDetector(
                  onTap: (){
                    // TODO Need to implement to jumpTo profile page
                  },
                  child: Container(
                    width: 44.h,
                    height: 44.h,
                    decoration: BoxDecoration(
                      color: AppColors.primarySecondaryBackground,
                      borderRadius: BorderRadius.all(Radius.circular(22.h)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 1)
                        )
                      ]
                    ),
                    child: controller.state.headDetail.value.avatar == null
                              ? const Image(image: AssetImage('assets/images/account_header.png'))
                              : CachedNetworkImage(
                                  imageUrl: controller.state.headDetail.value.avatar!,
                                  height: 44.w,
                                  width: 44.w,
                                  imageBuilder: (context, imageProvider) =>
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(22.w)),
                                        image: DecorationImage(
                                          image: imageProvider, fit: BoxFit.fill
                                        ),
                                      ),
                                    ),
                                  errorWidget: (context, url, error) => const Image(
                                    image: AssetImage('assets/images/account_header.png'),
                                  ),
                    )
                  ),
                ),
                Positioned(
                  bottom: 5.w,
                  right: 0.w,
                  height: 14.w,
                  child: Container(
                    width: 14.w,
                    height: 14.w,
                    decoration: BoxDecoration(
                      border: Border.all(width: 2.w, color: AppColors.primaryElementText),
                      color: controller.state.headDetail.value.online == 1
                        ? AppColors.primaryElementStatus
                        : AppColors.primarySecondaryElementText,
                      borderRadius: BorderRadius.all(Radius.circular(12.w))
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
