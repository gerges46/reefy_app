

import 'package:checkin/features/home/user/model/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/constants/app_constant.dart';
import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.dio) : super(UserInitial());

  int currentNavBarIndex = 0;
final TextEditingController searchController = TextEditingController();

  // void changeNavBar(int index) {
  //   currentNavBarIndex = index;
  //   print("Changing to index: $index");
  //   emit(ChangeDoctorLayoutState());
  // }

  // final List<Widget> pages = [
  //   DoctorHomeView(),
  //   PriceView(),
  //   ProfileView(),
  // ];

  List<UserFarmModel> allFarms = [];
   final Dio dio;
  void fetchAllFarms() async {
    emit(FetchFarmsLoadingState());
    try {
      Response response = await dio.get("${AppConstants.baseUrl}Farms/GetFarms");
      if (response.statusCode == 200) {
        List dataList = response.data['data'];
        for (var doctorJson in dataList) {
          print("🔍 Doctor JSON: $doctorJson");
        }
       allFarms = (response.data['data'] as List)
            .map((doctorJson) => UserFarmModel.fromJson(doctorJson))
            .toList();
        emit(UserFarmLoadedState(allFarms));
        print(response.data);
      } else {
        emit(FetchFarmsFailureState(response.data["errorMessage"]));
      }
    } catch (e) {
      emit(FetchFarmsFailureState(e.toString()));
    }
  }

  void searchFarms(String query) {
    if (query.isEmpty) {
      emit(UserFarmLoadedState(allFarms));
      return;
    }
    final filteredFarms = allFarms.where((farms) {

      final governmentLower = farms.farmGovernorate.toLowerCase();
      final queryLower = query.toLowerCase();
      return governmentLower.contains(queryLower);
    }).toList();
    emit(UserFarmLoadedState(filteredFarms));
  }


}
