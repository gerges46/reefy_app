import '../../model/doctor_model.dart';

abstract class DoctorState {}

final class DoctorInitial extends DoctorState {}
class DoctorLoadedState extends DoctorState{ 
  final List<Doctor> doctors;
  DoctorLoadedState(this.doctors);


}
class FetchDoctorFailureState extends DoctorState{
  final String errorMessage;

  FetchDoctorFailureState(this.errorMessage);
}
class FetchDoctorLoadingState extends DoctorState{}
class ChangeDoctorLayoutState extends DoctorState{}