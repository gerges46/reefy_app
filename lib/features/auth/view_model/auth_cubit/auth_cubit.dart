import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reefy/core/utils/constants/app_constant.dart';
import 'package:reefy/features/auth/view_model/auth_cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Dio dio = Dio();
  bool isLoading = false;
  void login({required String email, required String password}) async {
    emit(LoginLoadingState());
    try {
      Response response = await dio.post(
        "${AppConstants.endPoint}login",
        data: {"email": email, "password": password},
      );
      if (response.statusCode == 200) {
        var responseBody = response.data;
        if (responseBody["status"] == true) {
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
}
