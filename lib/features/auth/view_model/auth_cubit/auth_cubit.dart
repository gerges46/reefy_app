import 'package:checkin/core/utils/constants/app_constant.dart';
import 'package:checkin/core/utils/constants/app_router.dart';
import 'package:checkin/features/auth/view_model/auth_cubit/auth_state.dart';

import 'package:checkin/shared/shared_preference_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/reset_password.dart';

enum UserRole { farmer, doctor, user }

// ✅ تسميات اللغة العربية للأدوار
extension UserRoleExtension on UserRole {
  String get displayName {
    switch (this) {
      case UserRole.farmer:
        return "مزارع";
      case UserRole.doctor:
        return "طبيب";
      case UserRole.user:
        return "هاوي";
    }
  }
}

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController regionController = TextEditingController();
  final TextEditingController governorateController = TextEditingController();

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

  // clear role if error from cach
  void clearSelectedRole() {
    selectedRole = null;
    emit(AuthInitialState());
  }

  // Future<void> login({
  //   required String email,
  //   required String password,
  //   required BuildContext context,
  // }) async {
  //   emit(LoginLoadingState());
  //   try {
  //     final response = await dio.post(
  //       "${AppConstants.baseUrl}Users/login",
  //       data: {"email": email, "password": password},
  //       options: Options(headers: {
  //         "lang": "ar",
  //         "Content-Type": "application/json",
  //         "Accept": "application/json",
  //       }),
  //     );

  //     print("Login Response: ${response.data}");
  // print("🟢 Response status code: ${response.statusCode}");
  //     print("🟢 Full response data: ${response.data}");
  //     print("🟢 Response headers: ${response.headers}");
  //     if (response.statusCode == 200 && response.data["success"] == true) {
  //       // استخراج التوكن من الرسالة
  //       String message = response.data["message"] ?? "";
  //       String token = message.split(" - ").first;
  //       print("🟢 User data received: ${response.data}");
  //       if (token.isEmpty) {
  //         emit(LoginFailureState("لا يوجد توكن في الاستجابة"));
  //         return;
  //       }

  //       // حفظ التوكن
  //       await CacheNetwork.insertToCache(key: 'token', value: token);

  //       // جلب بيانات المستخدم باستخدام التوكن كـ parameter
  //      final userData = await _getUserData(token);

  //       if (userData != null) {
  //         // حفظ بيانات المستخدم
  //         await CacheNetwork.insertToCache(
  //           key: AppConstants.roleIdKey,
  //           value: userData['role'] ?? 'user',
  //         );

  //         emit(LoginSuccess());
  //         _navigateAfterAuth(context);
  //       } else {
  //         emit(LoginFailureState("فشل في جلب بيانات المستخدم"));
  //       }
  //     } else {
  //       clearSelectedRole();
  //       await CacheNetwork.deleteCacheItem(key: AppConstants.roleIdKey);
  //       String errorMsg = response.data["errorMessage"] ?? "فشل تسجيل الدخول";
  //       emit(LoginFailureState(errorMsg));
  //     }
  //   } catch (e) {
  //     clearSelectedRole();
  //     await CacheNetwork.deleteCacheItem(key: AppConstants.roleIdKey);
  //     String errorMessage = "حدث خطأ في الاتصال بالسيرفر";
  //     if (e is DioException) {
  //       errorMessage = e.response?.data["errorMessage"] ?? e.message ?? errorMessage;
  //       print("Dio Error Details: ${e.response?.data}");
  //     }
  //     emit(LoginFailureState(errorMessage));
  //   }
  // }

  Future<Map<String, dynamic>?> _getUserData(String token) async {
    try {
      print("🔵 Getting user data with token: $token");

      // الطريقة الصحيحة: إرسال التوكن كـ query parameter زي Postman
      final response = await dio.get(
        "${AppConstants.baseUrl}Users/getuser-bytoken?token=$token",
        options: Options(headers: {"lang": "ar", "Accept": "application/json"}),
      );

      print("🟢 Response status: ${response.statusCode}");
      print("🟢 Full response: ${response.data}");

      // التعامل مع الـ response الغريب (200 مع success = false)
      if (response.statusCode == 200) {
        if (response.data["data"] != null) {
          print("🟢 User data received successfully");
          return response.data["data"]; // بنرجع محتوى data فقط
        } else {
          print("🔴 No data field in response");
          return null;
        }
      } else {
        print("🔴 Invalid status code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("🔴 Error in _getUserData: $e");
      if (e is DioException) {
        print("🔴 Dio error details: ${e.response?.data}");
      }
      return null;
    }
  }

  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    emit(LoginLoadingState());
    try {
      final response = await dio.post(
        "${AppConstants.baseUrl}Users/login",
        data: {"email": email, "password": password},
        options: Options(
          headers: {
            "lang": "ar",
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        ),
      );

      print("Login Response: ${response.data}");
      print("🟢 Response status code: ${response.statusCode}");
      print("🟢 Full response data: ${response.data}");
      print("🟢 Response headers: ${response.headers}");

      if (response.statusCode == 200 && response.data["success"] == true) {
        // String message = response.data["message"] ?? "";
        // String token = message.split(" - ").first;
        String message = response.data["message"] ?? "";
        String token =
            message.contains(" - ")
                ? message.split(" - ").first.trim()
                : message.trim();

        print("🟢 Token extracted: $token");

        if (token.isEmpty) {
          emit(LoginFailureState("لا يوجد توكن في الاستجابة"));
          return;
        }

        // حفظ التوكن
        await CacheNetwork.insertToCache(key: AppConstants.token, value: token);

        // ✅ التحقق من صلاحية التوكن بإرساله في Body
        bool isValid = await validateToken(token);
        if (!isValid) {
          emit(LoginFailureState("التوكن غير صالح أو المستخدم غير معروف"));
          return;
        }

        // ✅ التوكن صالح، نجيب بيانات المستخدم
        final userData = await _getUserData(token);
        if (userData != null) {
          await CacheNetwork.insertToCache(
            key: AppConstants.roleIdKey,
            value: userData['role'] ?? 'user',
          );
          emit(LoginSuccess());
          _navigateAfterAuth(context);
        } else {
          emit(LoginFailureState("فشل في جلب بيانات المستخدم"));
        }
      } else {
        clearSelectedRole();
        await CacheNetwork.deleteCacheItem(key: AppConstants.roleIdKey);
        String errorMsg = response.data["errorMessage"] ?? "فشل تسجيل الدخول";
        emit(LoginFailureState(errorMsg));
      }
    } catch (e) {
      clearSelectedRole();
      await CacheNetwork.deleteCacheItem(key: AppConstants.roleIdKey);
      String errorMessage = "حدث خطأ في الاتصال بالسيرفر";
      if (e is DioException) {
        errorMessage =
            e.response?.data["errorMessage"] ?? e.message ?? errorMessage;
        print("Dio Error Details: ${e.response?.data}");
      }
      emit(LoginFailureState(errorMessage));
    }
  }

  Future<bool> validateToken(String token) async {
    try {
      final response = await dio.post(
        "${AppConstants.baseUrl}Users/validate-token",
        data: {"token": token},
        options: Options(
          headers: {
            "lang": "ar",
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        ),
      );

      print("🔍 Token validation response: ${response.data}");

      if (response.statusCode == 200 && response.data["success"] == true) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("🔴 Error in validateToken: $e");
      return false;
    }
  }

  Future<void> register({
    required String email,
    required String password,
    required String confirmPassword,
    required String userName,
    required String phone,
    required String address,
    required String region,
    required String governorate,
    required bool autoLoginAfterRegister,
    required BuildContext context,
  }) async {
    emit(RegisterLoadingState());
    try {
      print("User Data: ");
      print("Email: $email");
      print("Password: $password");
      print("User Name: $userName");
      print("Phone: $phone");
      print("Address: $address");

      Response response = await dio.post(
        "${AppConstants.baseUrl}Users/AddUser",
        data: {
          "userName": userName,
          "email": email,
          "phone": phone,
          "address": address,
          "region": region,
          "governorate": governorate,
          "Password": password,
          "roleId":
              selectedRole == UserRole.farmer
                  ? 6
                  : selectedRole == UserRole.doctor
                  ? 7
                  : 5,
        },
        options: Options(headers: {"lang": "ar"}),
      );

      print("API Response: ${response.data}");

      if (response.statusCode == 200 && response.data["success"] == true) {
        emit(RegisterSuccessState());

        if (autoLoginAfterRegister) {
          // ignore: use_build_context_synchronously
          await login(email: email, password: password, context: context);
        } else {
          Navigator.pushReplacementNamed(context, Routes.loginRoute);
        }
      } else {
        emit(RegisterFailureState(response.data["message"] ?? "فشل التسجيل"));
      }
    } catch (e) {
      emit(RegisterFailureState(e.toString()));
      print("Error during registration: $e");
    }
  }

  void _navigateAfterAuth(BuildContext context) async {
    try {
      print("Starting navigation..."); // طباعة بداية التنقل

      // استرجاع البيانات المخزنة مع fallback
      // final role = await CacheNetwork.getCacheData(key: AppConstants.roleIdKey) ?? 'user';
      // final token = await CacheNetwork.getCacheData(key: 'token') ?? '';
      final role =
          CacheNetwork.getStringFromCache(key: AppConstants.roleIdKey) ??
          'user';
      final token = CacheNetwork.getStringFromCache(key: AppConstants.token) ?? '';
      // ignore: unused_local_variable
      final isFirstTime =
          CacheNetwork.getBoolFromCache(key: 'farmFirstTime') ?? true;

      print(
        "Navigation Data - Role: $role, Token: ${token.isNotEmpty ? 'exists' : 'missing'}",
      ); // طباعة البيانات

      if (token.isEmpty) {
        print("No token found, redirecting to login");
        Navigator.pushReplacementNamed(context, Routes.loginRoute);
        return;
      }

      print("Navigating based on role: $role"); // طباعة التنقل بناءً على الدور

      switch (role) {
        case 'farmer':
          final isFirstTime =
              CacheNetwork.getBoolFromCache(key: 'farmFirstTime') ?? true;
          print(
            "Farmer - isFirstTime: $isFirstTime",
          ); // طباعة إذا كان أول استخدام
          if (isFirstTime) {
            Navigator.pushReplacementNamed(context, Routes.farmSetupRoute);
          } else {
            // Navigator.pushReplacementNamed(context, Routes.farmerHomeRoute);
            Navigator.pushReplacementNamed(context, Routes.layoutRoute);
          }
          break;

        case 'doctor':
          print("Navigating to doctor home"); // طباعة التنقل إلى صفحة الطبيب
          // Navigator.pushReplacementNamed(context, Routes.doctorHomeRoute);
          Navigator.pushReplacementNamed(context, Routes.doctorLayoutRoute);
          break;

        default:
          print("Navigating to user home"); // طباعة التنقل إلى صفحة المستخدم
          // Navigator.pushReplacementNamed(context, Routes.userHomeRoute);
          Navigator.pushReplacementNamed(context, Routes.layoutRoute);
      }
    } catch (e) {
      print("Navigation error: $e"); // طباعة الخطأ أثناء التنقل
      Navigator.pushReplacementNamed(context, Routes.loginRoute);
    }
  }



  // إرسال OTP
  Future<void> sendOTP(String email) async {
    emit(ResetPasswordLoading());
    try {
      final response = await dio.post(
        '${AppConstants.baseUrl}verify-code',
        data: {"email": email},
        options: Options(headers: {"lang": "ar"}),
      );
      final resetResponse = ResetPassword.fromJson(response.data);
      print("Email being sent: $email");
      emit(OTPSentSuccess(resetResponse.message));
      print("API Response: ${response.data}");
    } catch (e) {
      emit(ResetPasswordError('فشل إرسال الرمز'));
    }
  }

  // التحقق من OTP
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

  // تحديث كلمة المرور
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
