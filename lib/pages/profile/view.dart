// Import the core library
import 'package:flutter/material.dart';

// Import the library from the external
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Import the custom style
import 'package:flutter_video_chat/common/style/style.dart';

class ProfilePage extends StatelessWidget {
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
            image: const AssetImage(
              "assets/images/account_header.png",
            ),
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

            ),
          ),
        )
      ],
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
                      _buildProfilePhoto()
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
