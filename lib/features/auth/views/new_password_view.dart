import 'package:checkin/core/utils/constants/values_manager.dart';
import 'package:checkin/features/auth/views/widgets/custom_textform_field.dart';
import 'package:checkin/shared/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../../core/utils/constants/app_strings.dart';
import '../../../core/utils/constants/color_manager.dart';

class NewPasswordView extends StatelessWidget {
  const NewPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSize.s24.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: AppSize.s100.h),
              Text(AppStrings.createNewPassword),
              SizedBox(height: AppSize.s36.h),
              CustomTextFormField(
                controller: controller,
                hint: "كلمة المرور الحاليه",
              ),
              SizedBox(height: AppSize.s6.h),
              CustomTextFormField(
                controller: controller,
                hint: "كلمة المرور الجديده",
              ),
              SizedBox(height: AppSize.s6.h),
              CustomTextFormField(
                controller: controller,
                hint: "تاكيد كلمة المرور",
              ),
              SizedBox(height: AppSize.s46.h),
              CustomButton(
                title: "انشاء",
                color: ColorManager.customButtonColor,
                textColor: Colors.white,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
