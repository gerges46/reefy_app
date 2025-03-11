import 'package:checkin/core/utils/constants/app_constant.dart';
import 'package:checkin/features/auth/model/reset_password.dart';
import 'package:checkin/features/auth/view_model/auth_cubit/auth_state.dart';
import 'package:checkin/shared/shared_preference_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum UserRole { farmer, doctor, user }

// ✅ Extension for Arabic labels
extension UserRoleExtension on UserRole {
  String get displayName {
    switch (this) {
      case UserRole.farmer:
        return "مزارع";
      case UserRole.doctor:
        return "طبيب";
      case UserRole.user:
        return "هاوى";
    }
  }
}

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Dio dio = Dio();
  bool isLoading = false;
  bool isSecure = false;
  static AuthCubit getCubit(BuildContext context) =>
      BlocProvider.of<AuthCubit>(context);

      
  UserRole? selectedRole;

  void selectRole(UserRole role) {
    selectedRole = role;
    emit(AuthRoleSelectedState(role));
  }
  void isSecurePass() {
    isSecure = !isSecure;
    emit(RegisterSecurePassState());
  }

  void login({required String email, required String password}) async {
    emit(LoginLoadingState());
    try {
      Response response = await dio.post(
        "${AppConstants.endPoint}login",
        options: Options(headers: {"lang": "ar"}),
        data: {"email": email, "password": password},
      );
      if (response.statusCode == 200) {
        var responseBody = response.data;
        if (responseBody["status"] == true) {
          await CacheNetwork.insertToCache(
            key: "token",
            value: responseBody['data']['token'],
          );
          emit(LoginSuccess());
          debugPrint("user login success and his data is $responseBody");
        } else {
          emit(LoginFailureState(responseBody["message"]));
        }
      }
    } catch (e) {
      emit(LoginFailureState(e.toString()));
    }
  }

  Future<void> sendOTP(String email) async {
    emit(ResetPasswordLoading());
    try {
      final response = await dio.post(
        'https://api.example.com/send-otp',
        data: {"email": email},
      );
      final resetResponse = ResetPassword.fromJson(response.data);
      emit(OTPSentSuccess(resetResponse.message));
    } catch (e) {
      emit(ResetPasswordError('فشل إرسال الرمز'));
    }
  }

  Future<void> verifyOTP(String email, String otp) async {
    emit(ResetPasswordLoading());
    try {
      final response = await dio.post(
        'https://api.example.com/verify-otp',
        data: {"email": email, "otp": otp},
      );
      final resetResponse = ResetPassword.fromJson(response.data);
      if (resetResponse.message == "Success") {
        emit(OTPVerified());
      } else {
        emit(ResetPasswordError(response.data["message"]));
      }
    } catch (e) {
      emit(ResetPasswordError('خطأ أثناء التحقق من الرمز'));
    }
  }

  Future<void> updatePassword(String email, String newPassword) async {
    emit(ResetPasswordLoading());
    try {
      final response = await dio.post(
        'https://api.example.com/reset-password',
        data: {"email": email, "newPassword": newPassword},
      );
      final resetResponse = ResetPassword.fromJson(response.data);
      if (resetResponse.message == "Success") {
        emit(PasswordResetSuccess());
      } else {
        emit(ResetPasswordError(resetResponse.message));
      }
    } catch (e) {
      emit(ResetPasswordError('خطأ أثناء تحديث كلمة المرور'));
    }
  }
}
