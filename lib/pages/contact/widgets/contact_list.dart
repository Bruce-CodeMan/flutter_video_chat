import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_video_chat/pages/contact/controller.dart';
import 'package:get/get.dart';

class ContactList extends GetView<ContactController> {
  const ContactList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.symmetric(vertical: 0.w, horizontal: 0.w),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  var item = controller.state.contactList[index];
                  print("items: ${item.name}");
                },
                childCount: controller.state.contactList.length
            ),
          ),
        ),
      ],
    ));
  }
}
