abstract class AuthState {}

final class AuthInitialState extends AuthState {}
class LoginLoadingState extends AuthState{}
class LoginSuccess extends AuthState{}
class LoginFailureState extends AuthState{
  final String errorMessage;

  LoginFailureState(this.errorMessage);
  
}