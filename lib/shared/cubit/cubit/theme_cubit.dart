import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:checkin/core/utils/constants/app_constant.dart';
import 'package:checkin/shared/shared_preference_helper.dart';
import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial());

  void loadTheme() {
    final isDark = CacheNetwork.getBoolFromCache(key: AppConstants.themeModeKey) ?? false;
    emit(ThemeChanged(isDark ? ThemeMode.dark : ThemeMode.light));
  }

  void toggleTheme() async {
    final isDark = state is ThemeChanged && (state as ThemeChanged).themeMode == ThemeMode.dark;
    final newMode = isDark ? ThemeMode.light : ThemeMode.dark;
    emit(ThemeChanged(newMode));
    await CacheNetwork.insertBoolToCache(key: AppConstants.themeModeKey, value: !isDark);
  }
}
