import 'package:checkin/core/utils/constants/app_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheNetwork {
  static late SharedPreferences preferences;

  static Future<void> cacheInitialization() async {
    preferences = await SharedPreferences.getInstance();
  }

  static Future<bool> insertToCache({required String key, required dynamic value}) async {
    if (value is String) {
      return await preferences.setString(key, value);
    } else if (value is int) {
      return await preferences.setInt(key, value);
    } else if (value is bool) {
      return await preferences.setBool(key, value);
    } else if (value is double) {
      return await preferences.setDouble(key, value);
    } else {
      throw Exception("Unsupported value type");
    }
  }

  static String? getStringFromCache({required String key}) {
    final value = preferences.get(key);
    if (value is String) {
      return value;
    }
    return null;
  }

  static bool? getBoolFromCache({required String key}) {
    final value = preferences.get(key);
    if (value is bool) {
      return value;
    }
    return null;
  }

  static Future<bool> insertBoolToCache({required String key, required bool value}) async {
    return await preferences.setBool(key, value);
  }

  static Future<bool> deleteCacheItem({required String key}) async {
    return await preferences.remove(key);
  }

  static bool isOnboardingCompleted() {
    return preferences.getBool(AppStrings.onBoardingKey) ?? false;
  }
}
