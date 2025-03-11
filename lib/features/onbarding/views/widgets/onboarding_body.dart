import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../../../core/utils/constants/onboarding_const.dart';
import '../../../../core/utils/constants/values_manager.dart' show AppPadding, AppSize;
import '../../view_model/onboarding/onboarding_cubit.dart';

class OnboardingBody extends StatelessWidget {
  const OnboardingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
                      onPageChanged: BlocProvider.of<OnboardingCubit>(context).next,
                      controller: BlocProvider.of<OnboardingCubit>(context).controller,
                      itemCount: onBoardingList.length,
                      itemBuilder:
                          (context, index) => Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                onBoardingList[index].image,
                                fit: BoxFit.contain,
                                width: double.infinity,
                                height: AppSize.s270.h,
                              ),
                              SizedBox(height: AppSize.s40.h),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: AppPadding.p16.h,
                                ),
                                child: Text(
                                  onBoardingList[index].title,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                    );
  }
}