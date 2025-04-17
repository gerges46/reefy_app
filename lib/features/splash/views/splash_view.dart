// import 'dart:async';
// import 'package:checkin/core/utils/constants/app_constant.dart';
// import 'package:checkin/core/utils/constants/app_router.dart';
// import 'package:checkin/core/utils/constants/app_strings.dart';
// import 'package:checkin/core/utils/constants/assets_manager.dart';
// import 'package:checkin/core/utils/constants/color_manager.dart';
// import 'package:checkin/core/utils/constants/values_manager.dart';
// import 'package:checkin/shared/shared_preference_helper.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class SplashView extends StatefulWidget {
//   const SplashView({super.key});

//   @override
//   State<SplashView> createState() => _SplashViewState();
// }

// class _SplashViewState extends State<SplashView> {
//   Timer? _timer;
//   bool isShow = false;

//   _startDelay() {
//     _timer = Timer(const Duration(seconds: AppConstants.splashDelay), _goNext);
//   }

// _goNext() async {
//   bool isOnboardingCompleted = CacheNetwork.isOnboardingCompleted();
//   String? token = CacheNetwork.getCacheData(key: 'token');
//   String? role = CacheNetwork.getCacheData(key: AppConstants.roleIdKey);

//   if (mounted) {
//     if (!isOnboardingCompleted) {
//       // أول مرة - نعرض Onboarding
//       await CacheNetwork.insertBoolToCache(
//         key: AppStrings.onBoardingKey,
//         value: true,
//       );
//       Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
//     } else if (role == null) {
//       // المستخدم ما اختارش دور لسه - نعرض شاشة اختيار الدور
//       Navigator.pushReplacementNamed(context, Routes.roleRoute);
//     } else if (token != null && token.isNotEmpty) {
//       // المستخدم مسجل دخول - نوديه للصفحة حسب الدور
//       if (role == 'farmer') {
//         Navigator.pushReplacementNamed(context, Routes.farmerHomeRoute);
//       } else if (role == 'doctor') {
//         Navigator.pushReplacementNamed(context, Routes.doctorHomeRoute);
//       } else {
//         Navigator.pushReplacementNamed(context, Routes.userHomeRoute);
//       }
//     } else {
//       // عنده دور بس مش مسجل دخول - نوديه على تسجيل الدخول
//       Navigator.pushReplacementNamed(context, Routes.registerRoute);
//     }
//   }
// }


//   @override
//   void initState() {
//     _startDelay();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(height: AppSize.s140.h),
//             Center(
//               child: Image.asset(
//                 ImageAssets.splashLogoPng,
//                 width: 200.w,
//                 height: 200.h,
//               ),
//             ),
//             SizedBox(height: AppSize.s20.h),
//             Text(
//               AppStrings.logoName,
//               style: TextStyle(
//                 fontSize: AppSize.s40.sp,
//                 fontWeight: FontWeight.w800,
//                 color: ColorManager.logNameColor,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }
// }
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

  _startDelay() {
    _timer = Timer(const Duration(seconds: AppConstants.splashDelay), _goNext);
  }

  _goNext() async {
    bool isOnboardingCompleted = CacheNetwork.isOnboardingCompleted();
    String? token = CacheNetwork.getStringFromCache(key: AppConstants.token);
    String? role = CacheNetwork.getStringFromCache(key: AppConstants.roleIdKey);

    if (mounted) {
      if (!isOnboardingCompleted) {
        await CacheNetwork.insertBoolToCache(
          key: AppStrings.onBoardingKey,
          value: true,
        );
        Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
      } else if (role == null || role.isEmpty) {
        Navigator.pushReplacementNamed(context, Routes.roleRoute);
      } else if (token != null && token.isNotEmpty) {
        if (role == 'farmer') {
          Navigator.pushReplacementNamed(context, Routes.farmerHomeRoute);
        } else if (role == 'doctor') {
          Navigator.pushReplacementNamed(context, Routes.doctorHomeRoute);
        } else {
          Navigator.pushReplacementNamed(context, Routes.userHomeRoute);
        }
      } else {
        Navigator.pushReplacementNamed(context, Routes.registerRoute);
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
      body: SingleChildScrollView(
        child: Column(
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
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

