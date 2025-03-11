import 'package:checkin/features/auth/view_model/auth_cubit/auth_cubit.dart';

abstract class AuthState {}

final class AuthInitialState extends AuthState {}
class LoginLoadingState extends AuthState{}
class LoginSuccess extends AuthState{}
 class RegisterSecurePassState extends AuthState{}
class LoginFailureState extends AuthState{
  final String errorMessage;

  LoginFailureState(this.errorMessage);
  
}
class ResetPasswordLoading extends AuthState {}

class OTPSentSuccess extends AuthState {
  final String message;
  OTPSentSuccess(this.message);
}

class OTPVerified extends AuthState {}

class PasswordResetSuccess extends AuthState{}

class ResetPasswordError extends AuthState {
  final String message;
  ResetPasswordError(this.message);
}
class AuthRoleSelectedState extends AuthState{
  final UserRole role;

  AuthRoleSelectedState(this.role);

}
