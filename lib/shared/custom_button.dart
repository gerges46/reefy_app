import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reefy/core/utils/constants/style_manager.dart';
import 'package:reefy/core/utils/constants/values_manager.dart';


class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    required this.color,
    this.onPressed,
    required this.textColor,
  });
  final String title;
  final Color color;
  final Color textColor;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.p20.h),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s10), // Rounded edges
        ),
        minWidth: double.infinity, // Set button width
        height: 54.h,
        color: color,
        onPressed: onPressed,
        child: Text(title, style: semiBold(color: textColor)),
      ),
    );
  }
}
