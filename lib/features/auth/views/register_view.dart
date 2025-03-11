import 'package:checkin/core/utils/constants/app_strings.dart';
import 'package:checkin/core/utils/constants/color_manager.dart';
import 'package:checkin/features/auth/view_model/auth_cubit/auth_cubit.dart';
import 'package:checkin/features/auth/view_model/auth_cubit/auth_state.dart';
import 'package:checkin/features/auth/views/widgets/custom_back_btn.dart';
import 'package:checkin/features/auth/views/widgets/social_media_login.dart';
import 'package:checkin/shared/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/constants/app_router.dart' show Routes;
import '../../../core/utils/constants/values_manager.dart';
import 'widgets/custom_textform_field.dart';
import 'widgets/text_rich.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
              child: BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {},
                builder: (context, state) {
                  AuthCubit.getCubit(context);
                  return Form(
                    key: BlocProvider.of<AuthCubit>(context).formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomBackBtn(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        SizedBox(height: 30.h),
                        CustomTextFormField(
                          verticalPadding: AppPadding.p8.h,
                          controller:
                              AuthCubit.getCubit(context).nameController,
                          hint: "اسم المستخدم",
                        ),
                        SizedBox(height: 8.h),
                        CustomTextFormField(
                          verticalPadding: AppPadding.p8.h,
                          controller:
                              AuthCubit.getCubit(context).nameController,
                          keyboardType: TextInputType.number,
                          hint: "رقم الهاتف",
                        ),
                        SizedBox(height: 8.h),
                        CustomTextFormField(
                          isEmail: true,
                          verticalPadding: AppPadding.p8,
                          controller:
                              AuthCubit.getCubit(context).emailController,
                          hint: "الايميل",
                        ),
                        SizedBox(height: 8.h),
                        CustomTextFormField(
                          verticalPadding: AppPadding.p8,
                          controller:
                              AuthCubit.getCubit(context).passwordController,
                          hint: "كلمة المرور",
                        ),
                        SizedBox(height: 8.h),
                        CustomTextFormField(
                          verticalPadding: AppPadding.p8,
                          controller:
                              AuthCubit.getCubit(context).passwordController,
                          hint: "تاكيد كلمة المرور",
                        ),
                        SizedBox(height: 30.h),

                        /// Register Button
                        CustomButton(
                          title: "تسجيل الدخول",
                          color: ColorManager.customButtonColor,
                          textColor: Colors.white,
                          onPressed: () {
                            BlocProvider.of<AuthCubit>(
                              context,
                            ).formKey.currentState!.validate();
                          },
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
                          onTap: () {
                            Navigator.pushNamed(context, Routes.loginRoute);
                          },
                          text1: AppStrings.signUpCheckTextp1,
                          text2: AppStrings.signUpCheckTextp2,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
