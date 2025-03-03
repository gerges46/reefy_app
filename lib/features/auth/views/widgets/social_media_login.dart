
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:reefy/core/utils/constants/assets_manager.dart';

import '../../../../core/utils/constants/color_manager.dart';
import '../../../../core/utils/constants/values_manager.dart';

class SocialMediaLogin extends StatelessWidget {
  const SocialMediaLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: (){},
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppSize.s8.r),
              border: Border.all(
                color: Colors.grey, // Border color
                width: 1.0, // Border width
              ),
            ),
            width: AppSize.s86.w,
            height: AppSize.s40.h,
            child: SvgPicture.asset(
              ImageAssets.google,
              width: AppSize.s14.w,
              height: AppSize.s14.h,
            ),
          ),
        ),
        SizedBox(width: AppSize.s16,),
        InkWell(
          onTap: (){},
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppSize.s8),
              border: Border.all(
                color: ColorManager.sideFillColor, // Border color
                width: 1.0, // Border width
              ),
            ),
              
            width: AppSize.s86.w,
            height: AppSize.s40.h,
            child: SvgPicture.asset(
              ImageAssets.faceBook,
              width: AppSize.s14.w,
              height: AppSize.s14.h,
            ),
          ),
        ),
      ],
    );
  }
}
