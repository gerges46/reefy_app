import 'dart:async';
import 'package:flutter/material.dart';
import 'package:reefy/core/utils/constants/app_constant.dart';
import 'package:reefy/core/utils/constants/app_router.dart';
import 'package:reefy/core/utils/constants/app_strings.dart';
import 'package:reefy/core/utils/constants/assets_manager.dart';
import 'package:reefy/shared/shared_preference_helper.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  bool isShow = true;

  _startDelay() {
    _timer = Timer(const Duration(seconds: AppConstants.splashDelay), _goNext);
  }

  _goNext() {
    isShow = CacheNetwork.preferences.getBool(AppStrings.onBoardingKey) ?? true;

    if (isShow) {
      Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
    } else {
      Navigator.pushReplacementNamed(context, Routes.loginRoute);
    }
    CacheNetwork.insertBoolToCache(key: AppStrings.onBoardingKey, value: false);
  }

  @override
  void initState() {
    _startDelay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageAssets.splashLogoPng),
            fit: BoxFit.fill, // Ensures the image covers the full screen
          ),
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
