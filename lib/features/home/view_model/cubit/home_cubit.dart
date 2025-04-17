// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../model/farm_info_model.dart';
// import 'home_state.dart';

// class HomeCubit extends Cubit<HomeState> {
//   HomeCubit() : super(HomeInitialState());
//   int currentIndex = 0;
//   TextEditingController farmController = TextEditingController();
//   GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   final Dio dio = Dio();
//    List<FarmModel> farms = []; 
//   changeHomeNavBar(int index) {
//     currentIndex = index;
//     emit(ChangeHomeNavBarState());
//   }

 

//  // Fetch farms from the API
//   Future<void> fetchFarms() async {
//     try {
//       emit(FetchFarmLoadingState());
//       Response response = await dio.get("https://your-api-url.com/farms");

//       if (response.statusCode == 200) {
//         farms = (response.data as List).map((farm) => FarmModel.fromJson(farm)).toList();
//         emit(FetchFarmSuccessState(farms)); // Emit state with the farm list
//       } else {
//         emit(FetchFarmFailureState(response.data['message']));
//       }
//     } catch (e) {
//       emit(FetchFarmFailureState(e.toString()));
//     }
//   }

//   // Add farmer
//   addFarmer(String farmerName) async {
//     try {
//       Response response = await dio.post("https://your-api-url.com/farmers", data: {"name": farmerName});
//       if (response.statusCode == 200) {
//         emit(FarmSuccessState());
//       } else {
//         emit(FarmFailureState(response.data['message']));
//       }
//     } catch (e) {
//       emit(FarmFailureState(e.toString()));
//     }
//   }
//   }

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../model/farm_info_model.dart';
// import 'home_state.dart';

// class HomeCubit extends Cubit<HomeState> {
//   HomeCubit() : super(HomeInitialState());
//   int currentIndex = 0;
//     TextEditingController farmController = TextEditingController();
//   GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   final Dio dio = Dio();
//   List<FarmModel> farms = [];

//   // تغيير الـ NavBar
//   changeHomeNavBar(int index) {
//     currentIndex = index;
//     emit(ChangeHomeNavBarState());
//   }

//   // جلب المزارع من الـ API
//   Future<void> fetchFarms() async {
//     try {
//       emit(FetchFarmLoadingState());
//       Response response = await dio.get("https://your-api-url.com/farms");

//       if (response.statusCode == 200) {
//         farms = (response.data as List).map((farm) => FarmModel.fromJson(farm)).toList();
//         emit(FetchFarmSuccessState(farms)); // Emit state with the farm list
//       } else {
//         emit(FetchFarmFailureState(response.data['message']));
//       }
//     } catch (e) {
//       emit(FetchFarmFailureState(e.toString()));
//     }
//   }

//   // إضافة مزارع جديدة
//   addFarmer(String farmerName) async {
//     try {
//       Response response = await dio.post("https://your-api-url.com/farmers", data: {"name": farmerName});
//       if (response.statusCode == 200) {
//         emit(FarmSuccessState());
//       } else {
//         emit(FarmFailureState(response.data['message']));
//       }
//     } catch (e) {
//       emit(FarmFailureState(e.toString()));
//     }
//   }
// }


import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/farm_info_model.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final Dio dio = Dio();
  int currentIndex = 0;
  TextEditingController farmController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<FarmModel> farms = [];

  HomeCubit() : super(HomeInitialState());

  void changeHomeNavBar(int index) {
    currentIndex = index;
    emit(ChangeHomeNavBarState());
  }

  Future<void> fetchFarms() async {
    try {
      emit(FetchFarmLoadingState());
      final response = await dio.get("https://your-api-url.com/farms");

      if (response.statusCode == 200) {
        farms = (response.data as List)
            .map((farm) => FarmModel.fromJson(farm))
            .toList();
        emit(FetchFarmSuccessState(farms));
      } else {
        farms = [];
        emit(FetchFarmSuccessState(farms)); // عرض UI فارغ بدلاً من الخطأ
      }
    } catch (e) {
      farms = [];
      emit(FetchFarmSuccessState(farms)); // منع ظهور الخطأ واستمرار UI طبيعي
    }
  }

  Future<void> addFarmer(String farmerName) async {
    try {
      emit(FarmLoadingState());
      final response = await dio.post(
        "https://your-api-url.com/farmers",
        data: {"name": farmerName},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        await fetchFarms(); // تحديث القائمة بعد الإضافة
        emit(FarmSuccessState());
      } else {
        emit(FarmFailureState(response.data['message'] ?? 'فشل إضافة المزرعة'));
      }
    } catch (e) {
      emit(FarmFailureState(e.toString()));
    }
  }
    String? barnType;

  void setBarnType(String type) {
    barnType = type;
    emit(RadioListUpdate()); // Use a meaningful state name
  }

}

