// import 'package:checkin/core/utils/constants/app_router.dart';
// import 'package:checkin/core/utils/constants/app_strings.dart';
// import 'package:checkin/core/utils/constants/color_manager.dart';
// import 'package:checkin/core/utils/constants/values_manager.dart';
// import 'package:checkin/features/auth/view_model/auth_cubit/auth_cubit.dart';
// import 'package:checkin/features/auth/view_model/auth_cubit/auth_state.dart';
// import 'package:checkin/features/auth/views/widgets/custom_snackbar.dart';
// import 'package:checkin/features/auth/views/widgets/custom_textform_field.dart';
// import 'package:checkin/shared/custom_button.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class ForgetPasswordView extends StatelessWidget {
//   const ForgetPasswordView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocProvider(
//         create: (context) => AuthCubit(),
//         child: SingleChildScrollView(
//           child: BlocConsumer<AuthCubit, AuthState>(
//             listener: (context, state) {
//               if (state is ResetPasswordLoading) {
//                 CircularProgressIndicator();
//               } else if (state is ResetPasswordError) {
//                 CustomSnackBar(message: state.message.toString());
//               }

//             },
//             builder: (context, state) {
//               return Column(
//                 children: [
//                   SizedBox(height: AppSize.s160.h),
//                   Text(AppStrings.forgetPassword),
//                   SizedBox(height: AppSize.s16.h),
//                   Text(AppStrings.enterYourEmail),
//                   SizedBox(height: AppSize.s16.h),
//                   CustomTextFormField(
//                     controller:
//                         BlocProvider.of<AuthCubit>(context).emailController,
//                     hint: "الايميل",
//                   ),
//                   SizedBox(height: AppSize.s40.h),
//                   CustomButton(
//                     title: AppStrings.sendOtp,
//                     color: ColorManager.customButtonColor,
//                     textColor: Colors.white,
//                     onPressed: () {
//                       BlocProvider.of<AuthCubit>(context).sendOTP(
//                         BlocProvider.of<AuthCubit>(
//                           context,
//                         ).emailController.text,
//                       );
//                       Navigator.pushNamed(context, Routes.otpRoute);
//                     },
//                   ),
//                 ],
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:checkin/core/utils/constants/app_router.dart';
import 'package:checkin/core/utils/constants/app_strings.dart';
import 'package:checkin/core/utils/constants/color_manager.dart';
import 'package:checkin/core/utils/constants/values_manager.dart';
import 'package:checkin/features/auth/view_model/auth_cubit/auth_cubit.dart';
import 'package:checkin/features/auth/view_model/auth_cubit/auth_state.dart';
import 'package:checkin/features/auth/views/widgets/custom_snackbar.dart';
import 'package:checkin/features/auth/views/widgets/custom_textform_field.dart';
import 'package:checkin/shared/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => AuthCubit(),
        child: SingleChildScrollView(
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is ResetPasswordLoading) {
                CircularProgressIndicator();
              } else if (state is OTPSentSuccess) {
                CustomSnackBar(
                  message: 'تم إرسال رمز التحقق بنجاح',
                ).show(context);
                Navigator.pushNamed(context, Routes.otpRoute);
              } else if (state is ResetPasswordError) {
                CustomSnackBar(
                  message: state.message.toString(),
                  isError: true,
                ).show(context);
              }
            },
            builder: (context, state) {
              return Form(
                key: AuthCubit.getCubit(context).formKey,
                child: Column(
                  children: [
                    SizedBox(height: AppSize.s160.h),
                    Text(AppStrings.forgetPassword),
                    SizedBox(height: AppSize.s16.h),
                    Text(AppStrings.enterYourEmail),
                    SizedBox(height: AppSize.s16.h),
                    CustomTextFormField(
                      controller:
                          BlocProvider.of<AuthCubit>(context).emailController,
                      hint: "الايميل",
                    ),
                    SizedBox(height: AppSize.s40.h),
                    CustomButton(
                      title: AppStrings.sendOtp,
                      color: ColorManager.customButtonColor,
                      textColor: Colors.white,
                      onPressed: () {
                        if (AuthCubit.getCubit(
                          context,
                        ).formKey.currentState!.validate()) {
                          BlocProvider.of<AuthCubit>(context).sendOTP(
                            BlocProvider.of<AuthCubit>(
                              context,
                            ).emailController.text,
                          );
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
