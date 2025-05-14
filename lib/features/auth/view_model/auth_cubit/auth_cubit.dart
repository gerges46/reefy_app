import 'package:checkin/core/utils/constants/app_constant.dart';
import 'package:checkin/core/utils/constants/app_router.dart';
import 'package:checkin/features/auth/view_model/auth_cubit/auth_state.dart';
import 'package:checkin/shared/shared_preference_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../home/view_model/cubit/home_cubit.dart';
import '../../../home/view_model/cubit/home_state.dart';
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


  Future<Map<String, dynamic>?> _getUserData(String token) async {
    try {
      print("🔵 Getting user data with token: $token");

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
      print(" Error in _getUserData: $e");
      if (e is DioException) {
        print("🔴 Dio error details: ${e.response?.data}");
      }
      return null;
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
        // تخزين التوكن
        final userId = response.data['data']['userId'].toString();
        await CacheNetwork.insertToCache(
          key: AppConstants.userIdKey,
          value: userId,
        );

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

  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    emit(LoginLoadingState());
    try {
      final response = await dio.post(
        "${AppConstants.baseUrl}Users/login",
        queryParameters: {"email": email, "password": password},
        options: Options(
          headers: {
            "lang": "ar",
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        ),
      );

      print("Login Response: ${response.data}");

      if (response.statusCode == 200 && response.data["success"] == true) {
        // تخزين البيانات المهمة من الاستجابة
        final userData = response.data["data"];
        if (userData == null) {
          emit(LoginFailureState("لا توجد بيانات مستخدم في الاستجابة"));
          return;
        }

        // احفظ التوكن
        final token = userData["token"] ?? "";
        if (token.isEmpty) {
          emit(LoginFailureState("لا يوجد توكن في الاستجابة"));
          return;
        }
        await CacheNetwork.insertToCache(key: AppConstants.token, value: token);

        // احفظ الـ roleId من بيانات المستخدم مباشرة
        final roleId = userData["roleId"].toString();
        final roleName = userData["roleName"] ?? "";

        print('🟢 User data from API: $userData');
        print('🟢 Role ID from API: $roleId');
        print('🟢 Role Name from API: $roleName');


        await CacheNetwork.insertToCache(
          key: AppConstants.roleIdKey,
          value: roleId,
        );
// cahed user name and other data
await CacheNetwork.insertToCache(key: AppConstants.userNameKey, value: userData["userName"] ?? "");
await CacheNetwork.insertToCache(key: AppConstants.emailKey, value: userData["email"] ?? "");
await CacheNetwork.insertToCache(key: AppConstants.phoneKey, value: userData["phone"] ?? "");

        // حفظ بيانات المستخدم الأخرى إذا لزم الأمر
        // await CacheNetwork.insertToCache(key: AppConstants.userNameKey, value: userData["userName"] ?? "");

        emit(LoginSuccess());
        final userId = response.data['data']['userId'].toString();
        await CacheNetwork.insertToCache(
          key: AppConstants.userIdKey,
          value: userId,
        );
        // ✅ أعد تحميل الدور من خلال HomeCubit
context.read<HomeCubit>().reloadUserRole();

        // توجيه المستخدم للصفحة المناسبة بناءً على الـ roleId من الاستجابة
        WidgetsBinding.instance.addPostFrameCallback((_) {
          //_navigateBasedOnRole(context, roleId);
          _navigateAfterAuth(context);
        });
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

  // // دالة جديدة للتوجيه بناءً على الـ roleId المستلم من الـ API

  // دالة للتحقق من إذا كان المزارع يستخدم التطبيق لأول مرة
  Future<void> _navigateToFarmerScreens(BuildContext context) async {
    final isFirstTime =
        await CacheNetwork.getBoolFromCache(key: 'farmFirstTime') ?? true;
    print('🔴 Farmer - isFirstTime: $isFirstTime');

    if (isFirstTime) {
      Navigator.pushReplacementNamed(context, Routes.farmSetupRoute);
    } else {
      Navigator.pushReplacementNamed(context, Routes.farmerHomeRoute);
    }
  }

  // تحديث دالة التنقل بعد تسجيل الدخول في AuthCubit
  void _navigateAfterAuth(BuildContext context) async {
    try {
      final token =
          await CacheNetwork.getStringFromCache(key: AppConstants.token) ?? '';

      if (token.isEmpty) {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, Routes.loginRoute);
        return;
      }

      // بغض النظر عن نوع المستخدم، توجيه الجميع إلى الهوم سكرين الموحدة
      // Navigator.pushReplacementNamed(context, Routes.homeRoute);

       context.read<HomeCubit>().getUserRole().then((_) {
      Navigator.pushReplacementNamed(context, Routes.homeRoute);
    });
    } catch (e) {
      print('🔴 Navigation Error: $e');
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
