
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../core/utils/constants/app_constant.dart';
// import '../../../../shared/shared_preference_helper.dart';
// import '../../model/farm_info_model.dart';
// import 'home_state.dart';

// class HomeCubit extends Cubit<HomeState> {
//   final Dio dio = Dio();
//   int currentIndex = 0;
//   TextEditingController farmController = TextEditingController();
//   GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   List<FarmModel> farms = [];

//   HomeCubit() : super(HomeInitialState());



//   String userRole = '5'; // القيمة الافتراضية

//   // الحصول على نوع المستخدم من الكاش
//   Future<void> getUserRole() async {
//     emit(HomeLoadingState());
//     try {
//       final roleId = await CacheNetwork.getStringFromCache(key: AppConstants.roleIdKey) ?? '5';
//       userRole = roleId;
//       print('👤 Current user role: $userRole');
//       emit(HomeLoadedState(userRole));
//     } catch (e) {
//       print('❌ Error loading user role: $e');
//       emit(HomeErrorState('حدث خطأ أثناء تحميل بيانات المستخدم'));
//     }
//   }

//   // تغيير التاب المحدد
//   void changeTab(int index) {
//     // لا نسمح بالوصول إلى تاب المزارع إلا للمزارعين
//     if (index == 2 && userRole != '6') {
//       return; // سنتعامل مع هذا في الواجهة
//     }
    
//     currentIndex = index;
//     emit(HomeLoadedState(userRole));
//   }

//   // تسجيل الخروج
//   Future<void> logout() async {
//     await CacheNetwork.deleteCacheItem(key: AppConstants.token);
//     await CacheNetwork.deleteCacheItem(key: AppConstants.roleIdKey);
//   }

//   void changeHomeNavBar(int index) {
//     currentIndex = index;
//     emit(ChangeHomeNavBarState());
//   }

//   Future<void> fetchFarms() async {
//     try {
//       emit(FetchFarmLoadingState());
//       final response = await dio.get("https://your-api-url.com/farms");

//       if (response.statusCode == 200) {
//         farms = (response.data as List)
//             .map((farm) => FarmModel.fromJson(farm))
//             .toList();
//         emit(FetchFarmSuccessState(farms));
//       } else {
//         farms = [];
//         emit(FetchFarmSuccessState(farms)); // عرض UI فارغ بدلاً من الخطأ
//       }
//     } catch (e) {
//       farms = [];
//       emit(FetchFarmSuccessState(farms)); // منع ظهور الخطأ واستمرار UI طبيعي
//     }
//   }

//   Future<void> addFarmer(String farmerName) async {
//     try {
//       emit(FarmLoadingState());
//       final response = await dio.post(
//         "https://your-api-url.com/farmers",
//         data: {"name": farmerName},
//       );

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         await fetchFarms(); // تحديث القائمة بعد الإضافة
//         emit(FarmSuccessState());
//       } else {
//         emit(FarmFailureState(response.data['message'] ?? 'فشل إضافة المزرعة'));
//       }
//     } catch (e) {
//       emit(FarmFailureState(e.toString()));
//     }
//   }
//     String? barnType;

//   void setBarnType(String type) {
//     barnType = type;
//     emit(RadioListUpdate()); // Use a meaningful state name
//   }

// }
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/constants/app_constant.dart';
import '../../../../shared/shared_preference_helper.dart';
import '../../farm/model/farm_info_model.dart';
import '../../farm/repo/farm_setup_repo.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final Dio dio = Dio();
  int currentIndex = 0;
  List<FarmModel> farms = [];
  TextEditingController farmController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String userRole = '5'; // القيمة الافتراضية: مستخدم عادي

  HomeCubit(this.repo) : super(HomeInitialState());

  Future<void> getUserRole() async {
    emit(HomeLoadingState());
    try {
      final roleId = await CacheNetwork.getStringFromCache(key: AppConstants.roleIdKey) ?? '5';
      userRole = roleId;
      emit(HomeLoadedState(userRole));
    } catch (e) {
      emit(HomeErrorState('حدث خطأ أثناء تحميل بيانات المستخدم'));
    }
  }

  void changeTab(int index) {
    currentIndex = index;
    emit(HomeLoadedState(userRole));
  }
  //   Future<void> fetchFarms() async {
  //   try {
  //     emit(FetchFarmLoadingState());
  //     final response = await dio.get("https://your-api-url.com/farms");

  //     if (response.statusCode == 200) {
  //       farms = (response.data as List)
  //           .map((farm) => FarmModel.fromJson(farm))
  //           .toList();
  //       emit(FetchFarmSuccessState(farms));
  //     } else {
  //       farms = [];
  //       emit(FetchFarmSuccessState(farms)); // عرض UI فارغ بدلاً من الخطأ
  //     }
  //   } catch (e) {
  //     farms = [];
  //     emit(FetchFarmSuccessState(farms)); // منع ظهور الخطأ واستمرار UI طبيعي
  //   }
  // }

  // Future<void> addFarmer(String farmerName) async {
  //   try {
  //     emit(FarmLoadingState());
  //     final response = await dio.post(
  //       "https://your-api-url.com/farmers",
  //       data: {"name": farmerName},
  //     );

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       await fetchFarms(); // تحديث القائمة بعد الإضافة
  //       emit(FarmSuccessState());
  //     } else {
  //       emit(FarmFailureState(response.data['message'] ?? 'فشل إضافة المزرعة'));
  //     }
  //   } catch (e) {
  //     emit(FarmFailureState(e.toString()));
  //   }
  // }
    String? barnType;

  void setBarnType(String type) {
    barnType = type;
    emit(RadioListUpdate()); // Use a meaningful state name
  }
 final FarmRepository repo;

  Future<void> addFarmer(String farmName) async {
    emit(FarmLoadingState());
    try {
      final farm = FarmModel(
        farmName: farmName,
        address: "example address",
        region: "example region",
        governorate: "example governorate",
        userId: 24, // هنا تحط ID المستخدم
      );
      await repo.createFarm(farm);
      emit(FarmSuccessState());
    } catch (e) {
      emit(FarmFailureState( e.toString()));
    }
  }

  Future<void> fetchFarms() async {
    emit(FetchFarmLoadingState());
    try {
      final farms = await repo.getUserFarms(24); // ID المستخدم
      emit(FetchFarmSuccessState( farms));
    } catch (e) {
      emit(FarmFailureState( e.toString()));
    }
  }

  Future<void> deleteFarm(int id) async {
    try {
      await repo.deleteFarm(id);
      fetchFarms();
    } catch (e) {
      emit(FarmFailureState( e.toString()));
    }
  }
  Future<void> logout() async {
    await CacheNetwork.deleteCacheItem(key: AppConstants.token);
    await CacheNetwork.deleteCacheItem(key: AppConstants.roleIdKey);
  }

}


