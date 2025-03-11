import 'package:checkin/core/utils/constants/app_router.dart';
import 'package:checkin/core/utils/constants/app_strings.dart';
import 'package:checkin/core/utils/constants/color_manager.dart';
import 'package:checkin/core/utils/constants/onboarding_const.dart';
import 'package:checkin/core/utils/constants/values_manager.dart';
import 'package:checkin/features/onbarding/view_model/onboarding/onboarding_cubit.dart';
import 'package:checkin/features/onbarding/view_model/onboarding/onboarding_state.dart';
import 'package:checkin/features/onbarding/views/widgets/custom_dots.dart';
import 'package:checkin/features/onbarding/views/widgets/custom_skip_btn.dart';
import 'package:checkin/features/onbarding/views/widgets/onboarding_body.dart';
import 'package:checkin/shared/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => OnboardingCubit(),
        child: BlocBuilder<OnboardingCubit, OnboardingState>(
          builder: (context, state) {
            var cubit = BlocProvider.of<OnboardingCubit>(context);
            return SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.all(AppPadding.p16),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: CustomSkipBtn(
                        text: AppStrings.skip,
                        icon: Icons.arrow_forward_ios,
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context,
                            Routes.registerRoute,
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(child: OnboardingBody()),
                  CustomDots(),
                  SizedBox(height: AppSize.s20.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
                    child: CustomButton(
                      onPressed: () {
                        if (cubit.currentPage < onBoardingList.length - 1) {
                          cubit.controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        } else {
                      
                          Navigator.pushReplacementNamed(
                            context,
                            Routes.registerRoute,
                          );
                        }
                      },
                      title: AppStrings.next,
                      color: ColorManager.customButtonColor,
                      textColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: AppSize.s20.h),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
