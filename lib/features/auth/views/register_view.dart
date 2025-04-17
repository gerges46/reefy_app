import 'package:checkin/core/utils/constants/app_strings.dart';
import 'package:checkin/core/utils/constants/color_manager.dart';
import 'package:checkin/features/auth/view_model/auth_cubit/auth_cubit.dart';
import 'package:checkin/features/auth/view_model/auth_cubit/auth_state.dart';
import 'package:checkin/features/auth/views/widgets/custom_back_btn.dart';
import 'package:checkin/features/auth/views/widgets/custom_snackbar.dart';
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
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
              child: BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is RegisterSuccessState) {
                    CustomSnackBar(message: "تم التسجيل بنجاح!");
                    Navigator.pushNamed(context, Routes.homeRoute);
                  } else if (state is RegisterFailureState) {
                    CustomSnackBar(
                      message: state.errorMessage.toString(),
                      isError: true,
                    );
                  }
                },
                builder: (context, state) {
                  AuthCubit.getCubit(context);

                  if (state is RegisterLoadingState) {
                    return Center(child: CircularProgressIndicator());
                  }

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
                              AuthCubit.getCubit(context).phoneController,
                          keyboardType: TextInputType.number,
                          hint: "رقم الهاتف",
                        ),
                        CustomTextFormField(
                          controller:
                              BlocProvider.of<AuthCubit>(
                                context,
                              ).governorateController,
                          hint: "المحافظة",
                        ),
                        CustomTextFormField(
                          controller:
                              BlocProvider.of<AuthCubit>(
                                context,
                              ).regionController,
                          hint: "المنطقة",
                        ),
                        CustomTextFormField(
                          controller:
                              BlocProvider.of<AuthCubit>(
                                context,
                              ).addressController,
                          hint: "العنوان",
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
                              AuthCubit.getCubit(
                                context,
                              ).confirmPasswordController,
                          hint: "تاكيد كلمة المرور",
                        ),
                        SizedBox(height: 30.h),

                        // Register Button
                        CustomButton(
                          title: "تسجيل الدخول",
                          color: ColorManager.customButtonColor,
                          textColor: Colors.white,
                          onPressed: () {
                            if (AuthCubit.getCubit(
                              context,
                            ).formKey.currentState!.validate()) {
                              AuthCubit.getCubit(context).register(
                                address:
                                    AuthCubit.getCubit(
                                      context,
                                    ).addressController.text,
                                governorate:
                                    AuthCubit.getCubit(
                                      context,
                                    ).governorateController.text,
                                region:
                                    AuthCubit.getCubit(
                                      context,
                                    ).regionController.text,
                                email:
                                    AuthCubit.getCubit(
                                      context,
                                    ).emailController.text,
                                password:
                                    AuthCubit.getCubit(
                                      context,
                                    ).passwordController.text,
                                confirmPassword:
                                    AuthCubit.getCubit(
                                      context,
                                    ).confirmPasswordController.text,
                                userName:
                                    AuthCubit.getCubit(
                                      context,
                                    ).nameController.text,
                                phone:
                                    AuthCubit.getCubit(
                                      context,
                                    ).phoneController.text,
                                autoLoginAfterRegister: false,
                                context: context,
                              );
                            }
                          },
                        ),

                        // Show error message in UI if registration fails
                        if (state is RegisterFailureState)
                          Padding(
                            padding: EdgeInsets.only(top: 20.h),
                            child: Text(
                              state.errorMessage.toString(),
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),

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
