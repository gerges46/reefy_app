
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/constants/values_manager.dart';

class OptionCard extends StatelessWidget {
  final String picture;
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const OptionCard({
    super.key,
    required this.picture,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.s160.h,
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
        elevation: isSelected ? 4 : 2, // Add a shadow effect when selected
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: isSelected ? Colors.green : Colors.grey,
            width: 2,
          ),
        ),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon(icon, size: 40, color: isSelected ? Colors.green : Colors.grey),
                Image.asset(
                  picture,
                  width: 40.w,
                  height: 40.h,
                  // color: isSelected ? Colors.green : Colors.grey,
                ),
                SizedBox(width: AppSize.s16.h),
                Center(
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.green : Colors.grey,
                    ),
                    //   textDirection: TextDirection.ltr,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
