abstract class ProfileState {
  const ProfileState();
}
class ProfileInitial extends ProfileState {
  const ProfileInitial();
}
class ProfileLoaded extends ProfileState {
  final String name;
  final String email;
  final String phone;

  const ProfileLoaded({required this.name, required this.email, required this.phone});
}
class ProfileLoading extends ProfileState {

}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);
}

