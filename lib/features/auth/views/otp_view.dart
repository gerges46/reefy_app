import 'package:checkin/core/utils/constants/app_router.dart';
import 'package:checkin/core/utils/constants/app_strings.dart';
import 'package:checkin/core/utils/constants/color_manager.dart';
import 'package:checkin/core/utils/constants/values_manager.dart';
import 'package:checkin/features/auth/view_model/auth_cubit/auth_cubit.dart';
import 'package:checkin/features/auth/view_model/auth_cubit/auth_state.dart';
import 'package:checkin/features/auth/views/widgets/custom_pin_code.dart';
import 'package:checkin/features/auth/views/widgets/text_rich.dart';
import 'package:checkin/shared/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtpView extends StatelessWidget {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit,AuthState>(
        listener: (context, state) {
         
        },
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPadding.p24.w),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: AppSize.s14.h),
                      Align(
                        alignment: Alignment.topRight,
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
                            icon: Icon(Icons.arrow_back_ios, size: 18.sp),
                          ),
                        ),
                      ),
                      SizedBox(height: AppSize.s30.h),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          AppStrings.check,
                          style: TextStyle(
                            fontSize: AppSize.s32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: AppSize.s14.h),
                      Text(
                        AppStrings.enterOtpCode,
                        style: TextStyle(
                          fontSize: AppSize.s16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: AppSize.s36.h),
                      CustomPinCodeField(),
                      SizedBox(height: AppSize.s60.h),
                      CustomButton(
                        padding: EdgeInsets.zero,
                        title: "تحقق",
                        color: ColorManager.customButtonColor,
                        textColor: Colors.white,
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.newPasswordRoute);
                        },
                      ),
                      SizedBox(height: AppSize.s195.h),
                      TextRich(
                        text1: "لم تتلق رمزا ؟",
                        text2: "ارسال",
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
