import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reefy/core/utils/constants/app_strings.dart';
import 'package:reefy/core/utils/constants/color_manager.dart';
import 'package:reefy/core/utils/constants/onboarding_const.dart';
import 'package:reefy/core/utils/constants/values_manager.dart';
import 'package:reefy/features/onbarding/view_model/onboarding/onboarding_cubit.dart';
import 'package:reefy/features/onbarding/view_model/onboarding/onboarding_state.dart';

class CustomDots extends StatelessWidget {
  const CustomDots({super.key, });
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(
              onBoardingList.length,
              (index) => AnimatedContainer(
                margin: const EdgeInsets.only(right: 5),

                duration: Duration(microseconds: 900),
                width: AppSize.s12,
                height: AppSize.s12,
                decoration: BoxDecoration(
                  color:
                    BlocProvider.of<OnboardingCubit>(context).currentPage == index
                          ? ColorManager.activeDotsColor
                          : ColorManager.notActiveDotsColor,
                  borderRadius: BorderRadius.circular(AppSize.s50),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
