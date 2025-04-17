
 import 'package:checkin/features/home/user/model/user_model.dart';

abstract class UserState {}

final class UserInitial extends UserState {}
class UserFarmLoadedState extends UserState{ 
  final List<UserFarmModel> allFarms;
  UserFarmLoadedState(this.allFarms);


}
class FetchFarmsFailureState extends UserState{
  final String errorMessage;

  FetchFarmsFailureState(this.errorMessage);
}
class FetchFarmsLoadingState extends UserState{}