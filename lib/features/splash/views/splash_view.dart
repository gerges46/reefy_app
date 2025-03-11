import 'dart:async';
import 'package:checkin/core/utils/constants/app_constant.dart';
import 'package:checkin/core/utils/constants/app_router.dart';
import 'package:checkin/core/utils/constants/app_strings.dart';
import 'package:checkin/core/utils/constants/assets_manager.dart';
import 'package:checkin/core/utils/constants/color_manager.dart';
import 'package:checkin/core/utils/constants/values_manager.dart';
import 'package:checkin/shared/shared_preference_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



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


// _goNext() async {
//   isShow = CacheNetwork.isOnboardingCompleted(); 
//  String? token = CacheNetwork.getCacheData(key: 'token');
//   if (mounted) { 
//     if (isShow) {
//       Navigator.pushReplacementNamed(context, Routes.loginRoute);
//     } else {
//       await CacheNetwork.insertBoolToCache(key: AppStrings.onBoardingKey, value: true); 
//       if (mounted) {
//         Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
//       }
//     }
//             if (token != null && token.isNotEmpty) {
//           print("User is logged in, navigating to Home Layout");
//           Navigator.pushReplacementNamed(context, Routes.homeRoute); // Replace with your home screen route
//         } else {
//           print("User is NOT logged in, navigating to Register");
//           Navigator.pushReplacementNamed(context, Routes.registerRoute); // Replace with your register/login screen route
//         }
    
//   }
// }


_goNext() async {
  bool isOnboardingCompleted = CacheNetwork.isOnboardingCompleted(); 
  String? token = CacheNetwork.getCacheData(key: 'token');

  if (mounted) {
    if (!isOnboardingCompleted) {
      // First-time user -> Show onboarding
      await CacheNetwork.insertBoolToCache(key: AppStrings.onBoardingKey, value: true);
      if (mounted) {
        Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
      }
    } else if (token != null && token.isNotEmpty) {
      // User is logged in -> Go to Home
      Navigator.pushReplacementNamed(context, Routes.homeRoute);
    } else {
      // User is not logged in -> Go to Register/Login
      Navigator.pushReplacementNamed(context, Routes.roleRoute);
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