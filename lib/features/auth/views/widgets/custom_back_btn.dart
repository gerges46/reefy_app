
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../../../core/utils/constants/app_strings.dart';
import '../../../../core/utils/constants/color_manager.dart';
import '../../../../core/utils/constants/values_manager.dart';

class CustomBackBtn extends StatelessWidget {
  const CustomBackBtn({
    super.key, this.onPressed,
  });
final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSize.s24.w),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: ColorManager.sideFillColor,
                width: 1.w,
              ),
              borderRadius: BorderRadius.circular(AppSize.s6.r),
            ),
            child: IconButton(
              onPressed: onPressed,
              icon: Icon(Icons.arrow_forward_ios, size: 18.sp),
            ),
          ),
        ),
        Text(
          AppStrings.welcomeRegister,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
