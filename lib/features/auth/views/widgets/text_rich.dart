
import 'package:checkin/core/utils/constants/color_manager.dart';
import 'package:checkin/core/utils/constants/values_manager.dart';
import 'package:flutter/material.dart';


class TextRich extends StatelessWidget {
  const TextRich({
    super.key, this.onTap, required this.text1, required this.text2,
  });
final void Function()? onTap;
final String text1;
final String text2;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: AppPadding.p28,
        top: AppPadding.p20,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: RichText(
          text: TextSpan(
            text:text1,
            style: TextStyle(color: Colors.black, fontSize: 16.0),
            children: [
              TextSpan(
                text: text2,
                style: TextStyle(
                  color: ColorManager.primary,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
