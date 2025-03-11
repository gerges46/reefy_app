import 'package:checkin/core/utils/constants/app_strings.dart' show AppStrings;
import 'package:checkin/core/utils/constants/assets_manager.dart' show ImageAssets;


import '../../../features/onbarding/model/onboarding_model.dart';

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
