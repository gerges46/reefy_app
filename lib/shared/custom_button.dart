import 'package:checkin/core/utils/constants/style_manager.dart';
import 'package:checkin/core/utils/constants/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';




class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    required this.color,
    this.onPressed,
    required this.textColor, this.padding,
  });
  final String title;
  final Color color;
  final Color textColor;
    final EdgeInsetsGeometry? padding;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:padding?? EdgeInsets.symmetric(horizontal: AppPadding.p20.h),
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
