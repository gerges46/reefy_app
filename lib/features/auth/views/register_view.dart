// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:reefy/core/utils/constants/app_strings.dart';
// import 'package:reefy/core/utils/constants/color_manager.dart';
// import 'package:reefy/core/utils/constants/values_manager.dart';
// import 'package:reefy/features/auth/views/widgets/custom_textform_field.dart';
// import 'package:reefy/features/auth/views/widgets/social_media_login.dart';
// import 'package:reefy/features/auth/views/widgets/text_rich.dart';
// import 'package:reefy/shared/custom_button.dart';

// class RegisterView extends StatelessWidget {
//   const RegisterView({super.key});
//   @override
//   Widget build(BuildContext context) {
//     final TextEditingController controller = TextEditingController();
//     return Scaffold(
//       body: Column(
//         children: [
//           Row(
//             children: [
//               Align(
//                 alignment: Alignment.topRight,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: ColorManager.sideFillColor,
//                       width: 1,
//                     ),
//                     borderRadius: BorderRadius.circular(AppSize.s6),
//                   ),
//                   child: IconButton(
//                     onPressed: () {},
//                     icon: Icon(Icons.arrow_forward_ios),
//                   ),
//                 ),
//               ),
//               Center(child: Text(AppStrings.welcomeRegister)),
//             ],
//           ),
//           SizedBox(height: AppSize.s30.h),
//           CustomTextFormField(controller: controller, hint: "اسم المستخدم"),
//           SizedBox(height: AppSize.s10.h),
//           CustomTextFormField(controller: controller, hint: "رقم الهاتف"),
//           SizedBox(height: AppSize.s10.h),
//           CustomTextFormField(controller: controller, hint: "الايميل"),
//           SizedBox(height: AppSize.s10.h),
//           CustomTextFormField(controller: controller, hint: "كلمة المرور"),
//           SizedBox(height: AppSize.s10.h),
//           CustomTextFormField(
//             controller: controller,
//             hint: "تاكيد كلمة المرور",
//           ),
//           SizedBox(height: AppSize.s30),
//           CustomButton(
//             title: "تسجيل الدخول",
//             color: ColorManager.customButtonColor,
//             textColor: Colors.white,
//             onPressed: () {},
//           ),
//           SizedBox(height: AppSize.s30.h),
//           Text(AppStrings.optionTextLogin),

//           SizedBox(height: AppSize.s20.h),
//           SocialMediaLogin(),
//           SizedBox(height: AppSize.s20.h),
//           TextRich(
//             text1: AppStrings.signUpCheckTextp1,
//             text2: AppStrings.signUpCheckTextp2,
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reefy/core/utils/constants/app_strings.dart';
import 'package:reefy/core/utils/constants/color_manager.dart';
import 'package:reefy/core/utils/constants/values_manager.dart';
import 'package:reefy/features/auth/views/widgets/custom_textform_field.dart';
import 'package:reefy/features/auth/views/widgets/social_media_login.dart';
import 'package:reefy/features/auth/views/widgets/text_rich.dart';
import 'package:reefy/shared/custom_button.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// Header Row (Back Button + Title)
                Row(
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
                          onPressed: () {
                            Navigator.pop(context);
                          },
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
                ),
                SizedBox(height: 30.h),

                /// Form Fields
                CustomTextFormField(
                  controller: controller,
                  hint: "اسم المستخدم",
                ),
                SizedBox(height: 8.h),
                CustomTextFormField(controller: controller, hint: "رقم الهاتف"),
                SizedBox(height: 8.h),
                CustomTextFormField(controller: controller, hint: "الايميل"),
                SizedBox(height: 8.h),
                CustomTextFormField(
                  controller: controller,
                  hint: "كلمة المرور",
                ),
                SizedBox(height: 8.h),
                CustomTextFormField(
                  controller: controller,
                  hint: "تاكيد كلمة المرور",
                ),
                SizedBox(height: 30.h),

                /// Register Button
                CustomButton(
                  title: "تسجيل الدخول",
                  color: ColorManager.customButtonColor,
                  textColor: Colors.white,
                  onPressed: () {},
                ),
                SizedBox(height: 30.h),

                /// Other Login Options
                Text(
                  AppStrings.optionTextLogin,
                  style: TextStyle(fontSize: 16.sp),
                ),
                SizedBox(height: 20.h),
                SocialMediaLogin(),
                SizedBox(height: 20.h),
                TextRich(
                  text1: AppStrings.signUpCheckTextp1,
                  text2: AppStrings.signUpCheckTextp2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
