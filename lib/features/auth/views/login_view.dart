import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reefy/core/utils/constants/app_router.dart';
import 'package:reefy/core/utils/constants/app_strings.dart';
import 'package:reefy/core/utils/constants/color_manager.dart';
import 'package:reefy/core/utils/constants/style_manager.dart';
import 'package:reefy/core/utils/constants/values_manager.dart';
import 'package:reefy/features/auth/view_model/auth_cubit/auth_cubit.dart';
import 'package:reefy/features/auth/view_model/auth_cubit/auth_state.dart';
import 'package:reefy/features/auth/views/widgets/custom_textform_field.dart';
import 'package:reefy/features/auth/views/widgets/social_media_login.dart';
import 'package:reefy/features/auth/views/widgets/text_rich.dart';
import 'package:reefy/shared/custom_button.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: ColorManager.white,
        body: SafeArea(
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                Navigator.pushReplacementNamed(context, Routes.homeRoute);
              } else if (state is LoginFailureState) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(state.errorMessage.toString()),
                      content: const Text(AppStrings.dailogText),
                      actions: <Widget>[
                        TextButton(
                          child: const Text(AppStrings.ok),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              } else {
                CircularProgressIndicator();
              }
            },

            builder: (context, state) {
              return SingleChildScrollView(
                child: Form(
                  key: BlocProvider.of<AuthCubit>(context).formKey,
                  child: Column(
                    children: [
                      SizedBox(height: AppSize.s70.h),
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
                          padding: EdgeInsets.symmetric(
                            horizontal: AppPadding.p24,
                          ),
                          child: Text(
                            AppStrings.filedEmailText,
                            style: semiBold(color: ColorManager.textFillColor),
                          ),
                        ),
                      ),
                      CustomTextFormField(
                        hint: "البريد الإلكتروني",
                        controller:
                            BlocProvider.of<AuthCubit>(context).emailController,
                        isEmail: true,
                      ),

                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppPadding.p24,
                          ),
                          child: Text(
                            AppStrings.filedPasswordText,
                            style: semiBold(color: ColorManager.textFillColor),
                          ),
                        ),
                      ),
                      CustomTextFormField(
                        hint: "كلمة المرور",
                        controller:
                            BlocProvider.of<AuthCubit>(
                              context,
                            ).passwordController,
                      ),
                      SizedBox(height: AppSize.s16),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: AppPadding.p24),
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              AppStrings.forgetPassword,

                              style: TextStyle(
                                fontSize: AppSize.s16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: AppSize.s26.h),

                      CustomButton(
                        title:
                            state is LoginLoadingState
                                ? "Loading..."
                                : AppStrings.login,
                        color: ColorManager.primary,
                        textColor: ColorManager.white,
                        onPressed: () {
                          if (BlocProvider.of<AuthCubit>(
                            context,
                          ).formKey.currentState!.validate()) {
                            BlocProvider.of<AuthCubit>(context).login(
                              email:
                                  BlocProvider.of<AuthCubit>(
                                    context,
                                  ).emailController.text,
                              password:
                                  BlocProvider.of<AuthCubit>(
                                    context,
                                  ).passwordController.text,
                            );
                          }
                        },
                      ),
                      SizedBox(height: AppSize.s46.h),
                      Text(
                        AppStrings.optionTextLogin,
                        style: regularStyle(color: ColorManager.textFillColor2),
                      ),
                      SizedBox(height: AppSize.s18.h),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppPadding.p22.h,
                        ),
                        child: SocialMediaLogin(),
                      ),

                      TextRich(
                        text1:  AppStrings.dontHaveAccount,
                        text2: AppStrings.signUp,
                        onTap: () {
                          Navigator.pushNamed(context, Routes.registerRoute);
                        },
                      ),
                      SizedBox(height: AppSize.s26.h),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
