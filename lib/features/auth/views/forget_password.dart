import 'package:checkin/core/utils/constants/app_router.dart';
import 'package:checkin/core/utils/constants/app_strings.dart';
import 'package:checkin/core/utils/constants/color_manager.dart';
import 'package:checkin/core/utils/constants/values_manager.dart';
import 'package:checkin/features/auth/views/widgets/custom_textform_field.dart';
import 'package:checkin/shared/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: AppSize.s160.h),
          Text(AppStrings.forgetPassword),
          SizedBox(height: AppSize.s16.h),
          Text(AppStrings.enterYourEmail),
            SizedBox(height: AppSize.s16.h),
          CustomTextFormField(controller: emailController, hint: "الايميل"),
           SizedBox(height: AppSize.s40.h),
          CustomButton(
            title: AppStrings.sendOtp,
            color: ColorManager.customButtonColor,
            textColor: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context, Routes.otpRoute);
            },
          ),
        ],
      ),
    );
  }
}
