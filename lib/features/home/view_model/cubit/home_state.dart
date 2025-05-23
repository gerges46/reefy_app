//  import 'package:checkin/features/home/model/farm_info_model.dart';

// class HomeState {}

// final class HomeInitialState extends HomeState {}
// class ChangeHomeNavBarState extends HomeState{}
// class FarmLoadingState extends HomeState{}
// class FarmSuccessState extends HomeState{}
// class FarmFailureState extends HomeState{
//   final String errorMessage;

//   FarmFailureState(this.errorMessage);

// }
// class FetchFarmSuccessState extends HomeState{
//   final List<FarmModel> farms;

//   FetchFarmSuccessState(this.farms);
// }
// class FetchFarmLoadingState extends HomeState{}
// class FetchFarmFailureState extends HomeState{
//   final String errorMessage;

//   FetchFarmFailureState(this.errorMessage);
// }

import '../../farm/model/farm_info_model.dart';


abstract class HomeState {}


class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final String userRole;
  
  HomeLoadedState(this.userRole);
  

  @override
  String toString() => 'HomeLoadedState(userRole: $userRole)';
}

class HomeErrorState extends HomeState {
  final String error;
  
  HomeErrorState(this.error);
}



class ChangeHomeNavBarState extends HomeState {}

class FarmLoadingState extends HomeState {}

class FarmSuccessState extends HomeState {}

class FarmFailureState extends HomeState {
  final String errorMessage;

  FarmFailureState(this.errorMessage);
}

class FetchFarmLoadingState extends HomeState {}

class FetchFarmSuccessState extends HomeState {
  final List<FarmModel> farms;

  FetchFarmSuccessState(this.farms);
}

class FetchFarmFailureState extends HomeState {
  final String errorMessage;

  FetchFarmFailureState(this.errorMessage);
}
class RadioListUpdate extends HomeState{}

