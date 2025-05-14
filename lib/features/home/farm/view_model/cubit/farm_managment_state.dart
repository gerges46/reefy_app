// 

import 'package:checkin/features/home/farm/model/checken_type_model.dart';
import 'package:equatable/equatable.dart';

import '../../model/farm_info_model.dart';


abstract class FarmManagmentState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FarmManagmentInitial extends FarmManagmentState {}

// class FarmChickenTypesLoaded extends FarmManagmentState {
//   final List<ChickenTypeModel> chickenTypes;

//   FarmChickenTypesLoaded(this.chickenTypes);

//   @override
//   List<Object?> get props => [chickenTypes];
// }
class ChickenTypeLoading extends FarmManagmentState {}

class ChickenTypeLoaded extends FarmManagmentState {
  final List<String> types;
  ChickenTypeLoaded(this.types);
}

class ChickenTypeError extends FarmManagmentState {
  final String message;
  ChickenTypeError(this.message);
}

class FarmManagmentError extends FarmManagmentState {
  final String message;

  FarmManagmentError(this.message);

  @override
  List<Object?> get props => [message];
}
class FarmLoading extends FarmManagmentState {}

class FarmSuccess extends FarmManagmentState {
  final List<FarmModel> farms;
  FarmSuccess(this.farms);
}

class FarmFailure extends FarmManagmentState {
  final String error;
  FarmFailure(this.error);
}

class FarmAdded extends FarmManagmentState {}