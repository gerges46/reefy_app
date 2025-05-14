

import 'package:checkin/core/utils/constants/app_constant.dart';
import 'package:checkin/shared/shared_preference_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  Future<void> loadProfileData() async {
    emit(ProfileLoading());
    try {
      final name = await CacheNetwork.getStringFromCache(key: AppConstants.userNameKey) ?? 'غير معروف';
      final email = await CacheNetwork.getStringFromCache(key: AppConstants.emailKey) ?? 'غير معروف';
      final phone = await CacheNetwork.getStringFromCache(key: AppConstants.phoneKey) ?? 'غير معروف';

      emit(ProfileLoaded(name: name, email: email, phone: phone));
    } catch (e) {
      emit(ProfileError('فشل في تحميل البيانات'));
    }
  }
}
