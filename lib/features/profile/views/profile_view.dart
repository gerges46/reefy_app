
import 'package:flutter/material.dart';

import '../../../core/utils/constants/app_constant.dart';
import '../../../core/utils/constants/app_router.dart';
import '../../../core/utils/constants/color_manager.dart';
import '../../../shared/shared_preference_helper.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: ColorManager.primary,
            child: const Icon(Icons.person, size: 80, color: Colors.white),
          ),
          const SizedBox(height: 20),
          Text(
            'الملف الشخصي',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () async {
                // عملية تسجيل الخروج
                await CacheNetwork.deleteCacheItem(key: AppConstants.token);
                await CacheNetwork.deleteCacheItem(key: AppConstants.roleIdKey);
                
                // التنقل إلى صفحة تسجيل الدخول
                Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
              },
              child: const Text('تسجيل الخروج'),
            ),
          ),
        ],
      ),
    );
  }
}