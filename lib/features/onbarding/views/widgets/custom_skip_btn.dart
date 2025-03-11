import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/constants/color_manager.dart';
import '../../../../core/utils/constants/values_manager.dart';


class CustomSkipBtn extends StatelessWidget {
  const CustomSkipBtn({super.key, required this.text, this.onPressed, required this.icon});
final String text;
final void Function()? onPressed;
final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      
      style: ButtonStyle(
        iconColor:WidgetStatePropertyAll<Color>(ColorManager.customButtonColor) ,
    
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text, style: TextStyle(fontSize: AppSize.s16.sp,color: ColorManager.customButtonColor)),
          SizedBox(width: AppSize.s4.w),
          Icon(icon, size: AppSize.s18.sp),
        ],
      ),
    );
  }
}
