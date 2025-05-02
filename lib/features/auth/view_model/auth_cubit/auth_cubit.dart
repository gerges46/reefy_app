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

// Future<void> login({
//   required String email,
//   required String password,
//   required BuildContext context,
// }) async {
//   emit(LoginLoadingState());
//   try {
//     final response = await dio.post(
//       "${AppConstants.baseUrl}Users/login",
//      // data: {"email": email, "password": password},
//        queryParameters: {
//     "email": email,
//     "password": password,
//   },
//       options: Options(
//         headers: {
//           "lang": "ar",
//           "Content-Type": "application/json",
//           "Accept": "application/json",
//         },
//       ),
//     );

//     print("Login Response: ${response.data}");

//     if (response.statusCode == 200 && response.data["success"] == true) {
//       String message = response.data["message"] ?? "";
//       String token = message.contains(" - ") 
//           ? message.split(" - ").first.trim() 
//           : message.trim();

//       print("🟢 Token extracted: $token");

//       if (token.isEmpty) {
//         emit(LoginFailureState("لا يوجد توكن في الاستجابة"));
//         return;
//       }

//       // حفظ التوكن أولاً
//       await CacheNetwork.insertToCache(key: AppConstants.token, value: token);

//       // التحقق من صحة التوكن
//       bool isValid = await validateToken(token);
//       if (!isValid) {
//         emit(LoginFailureState("التوكن غير صالح أو المستخدم غير معروف"));
//         return;
//       }

//       // جلب بيانات المستخدم مرة واحدة فقط
//       final userData = await _getUserData(token);
//       if (userData != null) {
//         // حفظ roleId من userData
//         await CacheNetwork.insertToCache(
//           key: AppConstants.roleIdKey,
//           value: userData['roleId'].toString(), // تأكد أنه 'roleId' مش 'role'
//         );
        
//          // أضف هذا السطر لطباعة القيمة المحفوظة
//   print('🟢🟢🟢 Saved roleId: ${userData['roleId'].toString()} 🟢🟢🟢');
  
//   print('🟢 User role saved: ${userData['roleId']}');
//         print('🟢 User role saved: ${userData['roleId']}');
//         emit(LoginSuccess());
//         // _navigateAfterAuth(context);
//         WidgetsBinding.instance.addPostFrameCallback((_) {
//   _navigateAfterAuth(context);
// });
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

//   Future<bool> validateToken(String token) async {
//     try {
//       final response = await dio.post(
//         "${AppConstants.baseUrl}Users/validate-token",
//         data: {"token": token},
//         options: Options(
//           headers: {
//             "lang": "ar",
//             "Content-Type": "application/json",
//             "Accept": "application/json",
//           },
//         ),
//       );

//       print(" Token validation response: ${response.data}");

//       if (response.statusCode == 200 && response.data["success"] == true) {
//         return true;
//       } else {
//         return false;
//       }
//     } catch (e) {
//       print(" Error in validateToken: $e");
//       return false;
//     }
//   }

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


// void _navigateAfterAuth(BuildContext context) async {
//   try {
//     final roleId = CacheNetwork.getStringFromCache(key: AppConstants.roleIdKey) ?? '5';
//     final token = CacheNetwork.getStringFromCache(key: AppConstants.token) ?? '';
//     final isFirstTime = CacheNetwork.getBoolFromCache(key: 'farmFirstTime') ?? true;

//     if (token.isEmpty) {
//       Navigator.pushReplacementNamed(context, Routes.loginRoute);
//       return;
//     }

//     switch (roleId) {
//       case '6': // مزارع
//         if (isFirstTime) {
//           Navigator.pushReplacementNamed(context, Routes.farmSetupRoute);
//         } else {
//           Navigator.pushReplacementNamed(context, Routes.farmerHomeRoute);
//         }
//         break;
//       case '7': // دكتور
//         Navigator.pushReplacementNamed(context, Routes.doctorHomeRoute);
//         break;
//       default: // هاوي
//         Navigator.pushReplacementNamed(context, Routes.userHomeRoute);
//     }
//   } catch (e) {
//     print('Navigation Error: $e');
//     Navigator.pushReplacementNamed(context, Routes.loginRoute);
//   }
// }
// }

}


// void _navigateAfterAuth(BuildContext context) async {
//   try {
//     final roleId = await CacheNetwork.getStringFromCache(key: AppConstants.roleIdKey) ?? '5';
//     final token = await CacheNetwork.getStringFromCache(key: AppConstants.token) ?? '';
    
//     print('🔴 RoleID from cache: $roleId');
//     print('🔴 Token from cache: $token');
//           print('🔴 RoleID from cache: $roleId');
//     print('🔴 Token from cache: $token');

//     if (token.isEmpty) {
//       Navigator.pushReplacementNamed(context, Routes.loginRoute);
//       return;
//     }
 

//     switch (roleId) {
//       case '6': // Farmer
//         final isFirstTime = await CacheNetwork.getBoolFromCache(key: 'farmFirstTime') ?? true;
//         print('🔴 Farmer - isFirstTime: $isFirstTime');
//         if (isFirstTime) {
//           Navigator.pushReplacementNamed(context, Routes.farmSetupRoute);
//         } else {
//           Navigator.pushReplacementNamed(context, Routes.farmerHomeRoute);
//         }
//         break;
//       case '7': // Doctor
//         print('🔴 Navigating to doctor home');
//         Navigator.pushReplacementNamed(context, Routes.doctorHomeRoute);
//         break;
//       default: // User (roleId = 5)
//         print('🔴 Navigating to user home');
//         Navigator.pushReplacementNamed(context, Routes.userHomeRoute);
//     }
//   } catch (e) {
//     print('🔴 Navigation Error: $e');
//     Navigator.pushReplacementNamed(context, Routes.loginRoute);
//   }
// }

Future<void> login({
  required String email,
  required String password,
  required BuildContext context,
}) async {
  emit(LoginLoadingState());
  try {
    final response = await dio.post(
      "${AppConstants.baseUrl}Users/login",
      queryParameters: {
        "email": email,
        "password": password,
      },
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
      
      await CacheNetwork.insertToCache(key: AppConstants.roleIdKey, value: roleId);
      
      // حفظ بيانات المستخدم الأخرى إذا لزم الأمر
      // await CacheNetwork.insertToCache(key: AppConstants.userNameKey, value: userData["userName"] ?? "");
      
      emit(LoginSuccess());
      
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
      errorMessage = e.response?.data["errorMessage"] ?? e.message ?? errorMessage;
      print("Dio Error Details: ${e.response?.data}");
    }
    emit(LoginFailureState(errorMessage));
  }
}

// // دالة جديدة للتوجيه بناءً على الـ roleId المستلم من الـ API
// void _navigateBasedOnRole(BuildContext context, String roleId) 
// {
//   print('🔴 Navigating based on API roleId: $roleId');
  
//   switch (roleId) {
//     case '6': // Farmer
//       _navigateToFarmerScreens(context);
//       break;
//     case '7': // Doctor
//       print('🔴 Navigating to doctor home');
//       Navigator.pushReplacementNamed(context, Routes.doctorHomeRoute);
//       break;
//     default: // User (roleId = 5)
//       print('🔴 Navigating to user home');
//       Navigator.pushReplacementNamed(context, Routes.userHomeRoute);
//   }
// }

// دالة للتحقق من إذا كان المزارع يستخدم التطبيق لأول مرة
Future<void> _navigateToFarmerScreens(BuildContext context) async {
  final isFirstTime = await CacheNetwork.getBoolFromCache(key: 'farmFirstTime') ?? true;
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
    final token = await CacheNetwork.getStringFromCache(key: AppConstants.token) ?? '';
    
    if (token.isEmpty) {
      Navigator.pushReplacementNamed(context, Routes.loginRoute);
      return;
    }

    // بغض النظر عن نوع المستخدم، توجيه الجميع إلى الهوم سكرين الموحدة
    Navigator.pushReplacementNamed(context, Routes.homeRoute);
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

