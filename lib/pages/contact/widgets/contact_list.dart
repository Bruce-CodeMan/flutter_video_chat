import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_video_chat/common/entities/contact.dart';
import 'package:flutter_video_chat/common/style/color.dart';
import 'package:flutter_video_chat/pages/contact/controller.dart';
import 'package:get/get.dart';

import 'package:flutter_video_chat/common/values/asset.dart';


class ContactList extends GetView<ContactController>{
  const ContactList({super.key});

  Widget _buildListItem(ContactItem item) {
    return Container(
      padding: EdgeInsets.only(top: 12.h, bottom: 5.h),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: AppColors.primarySecondaryBackground
          )
        )
      ),
      child: InkWell(
        onTap: (){
          controller.goChat(item);
        },
        child: Row(
          children: [
            CircleAvatar(
              radius: 22.w,
              backgroundImage: CachedNetworkImageProvider(item.avatar!),
            ),
            SizedBox(width: 10.w,),
            Expanded(
              child: Text(
                "${item.name}",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'Avenir',
                  fontWeight: FontWeight.bold,
                  color: AppColors.thirdElement,
                  fontSize: 16.sp
                ),
              )),
            Image.asset(Asset.getIconPath("ang"), width: 12.w, height: 12.w,)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.symmetric(vertical: 0.w, horizontal: 20.w),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                var item = controller.state.contactList[index];
                return _buildListItem(item);
              },

              childCount: controller.state.contactList.length
            ),
          ),
        ),
      ],
    ));
  }
}
