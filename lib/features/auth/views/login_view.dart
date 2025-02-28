import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reefy/core/utils/constants/app_strings.dart';
import 'package:reefy/core/utils/constants/color_manager.dart';
import 'package:reefy/core/utils/constants/style_manager.dart';
import 'package:reefy/core/utils/constants/values_manager.dart';
import 'package:reefy/shared/custom_button.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SingleChildScrollView(
        child: Column(
          //   crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 110.h),
            Center(
              child: Text(
                AppStrings.welcomeText,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Center(
              child: Text(
                AppStrings.welcomeText2,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            SizedBox(height: 54.h),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPadding.p24),
                child: Text(
                  AppStrings.filedEmailText,
                  style: semiBold(color: ColorManager.textFillColor),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.p24,
                vertical: 17,
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: ColorManager.fillColor,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSize.s8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSize.s8),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPadding.p24),
                child: Text(
                  AppStrings.filedPasswordText,
                  style: semiBold(color: ColorManager.textFillColor),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.p24,
                vertical: 17,
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: ColorManager.fillColor,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSize.s8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSize.s8),
                  ),
                ),
              ),
            ),
             SizedBox(height: AppSize.s86.h,),
          
            CustomButton(
              title: AppStrings.login,
              color: ColorManager.primary,
              textColor: ColorManager.white,
              onPressed: () {
             
              },
            ),
          ],
        ),
      ),
    );
  }
}
