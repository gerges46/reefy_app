import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reefy/core/utils/constants/app_constant.dart';
import 'package:reefy/core/utils/constants/app_router.dart';
import 'package:reefy/core/utils/constants/app_strings.dart';
import 'package:reefy/core/utils/constants/assets_manager.dart';
import 'package:reefy/core/utils/constants/color_manager.dart';
import 'package:reefy/core/utils/constants/values_manager.dart';
import 'package:reefy/shared/shared_preference_helper.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
 bool isShow=false;

  _startDelay() {
    _timer = Timer(const Duration(seconds: AppConstants.splashDelay), _goNext);
  }


_goNext() async {
  isShow = CacheNetwork.isOnboardingCompleted(); // ✅ Use helper function

  if (mounted) { 
    if (isShow) {
      Navigator.pushReplacementNamed(context, Routes.registerRoute);
    } else {
      await CacheNetwork.insertBoolToCache(key: AppStrings.onBoardingKey, value: true); // ✅ Only set after showing onboarding
      if (mounted) {
        Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
      }
    }
  }
}




  @override
  void initState() {
    _startDelay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: AppSize.s140.h),
          Center(
            child: Image.asset(
              ImageAssets.splashLogoPng,
              width: 200.w,
              height: 200.h,
            ),
          ),
          SizedBox(height: AppSize.s20.h),
          Text(
            AppStrings.logoName,
            style: TextStyle(
              fontSize: AppSize.s40.sp,
              fontWeight: FontWeight.w800,
              color: ColorManager.logNameColor,
            
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}