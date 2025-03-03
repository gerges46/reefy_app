import 'package:reefy/core/utils/constants/app_strings.dart';
import 'package:reefy/core/utils/constants/assets_manager.dart';
import 'package:reefy/features/onbarding/model/onboarding_model.dart';

List<OnboardingModel> onBoardingList = [
  OnboardingModel(
    image: ImageAssets.onboarding1Png,
    title: AppStrings.onBoardingText1,
  ),
  OnboardingModel(
    image: ImageAssets.onboarding2Png,
    title: AppStrings.onBoardingText2,
  ),
  OnboardingModel(
    image: ImageAssets.onboarding3Png,
    title: AppStrings.onBoardingText3,
  ),
];
