import 'package:checkin/core/utils/constants/app_constant.dart';
import 'package:checkin/features/profile/views/profile_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../prices/price_view.dart';
import '../../model/doctor_model.dart';
import '../../views/doctor_home_view.dart';
import 'doctor_state.dart';

class DoctorCubit extends Cubit<DoctorState> {
  DoctorCubit(this.dio) : super(DoctorInitial());

  final Dio dio;

  int currentNavBarIndex = 0;
final TextEditingController searchController = TextEditingController();

  void changeNavBar(int index) {
    currentNavBarIndex = index;
    print("Changing to index: $index");
    emit(ChangeDoctorLayoutState());
  }

  final List<Widget> pages = [
    DoctorHomeView(),
    PriceView(),
    ProfileView(),
  ];

  List<Doctor> _allDoctors = [];

  void fetchAllDoctors() async {
    emit(FetchDoctorLoadingState());
    try {
      Response response = await dio.get("${AppConstants.baseUrl}Users/doctors");
      if (response.statusCode == 200) {
        List dataList = response.data['data'];
        for (var doctorJson in dataList) {
          print("🔍 Doctor JSON: $doctorJson");
        }
        _allDoctors = (response.data['data'] as List)
            .map((doctorJson) => Doctor.fromJson(doctorJson))
            .toList();
        emit(DoctorLoadedState(_allDoctors));
        print(response.data);
      } else {
        emit(FetchDoctorFailureState(response.data["errorMessage"]));
      }
    } catch (e) {
      emit(FetchDoctorFailureState(e.toString()));
    }
  }

  void searchDoctors(String query) {
    if (query.isEmpty) {
      emit(DoctorLoadedState(_allDoctors));
      return;
    }
    final filteredDoctors = _allDoctors.where((doctor) {
      final userNameLower = doctor.userName.toLowerCase();
      final addressLower = doctor.address?.toLowerCase() ?? '';
      final queryLower = query.toLowerCase();
      return userNameLower.contains(queryLower) || addressLower.contains(queryLower);
    }).toList();
    emit(DoctorLoadedState(filteredDoctors));
  }
}
