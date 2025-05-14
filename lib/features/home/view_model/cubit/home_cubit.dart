
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

// // }
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../core/utils/constants/app_constant.dart';
// import '../../../../shared/shared_preference_helper.dart';
// import '../../farm/model/farm_info_model.dart';
// import '../../farm/repo/farm_setup_repo.dart';
// import 'home_state.dart';

// class HomeCubit extends Cubit<HomeState> {
//   final Dio dio = Dio();
//   int currentIndex = 0;
//   List<FarmModel> farms = [];
//   TextEditingController farmController = TextEditingController();
//   GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   String userRole = '5';
//     bool roleLoaded = false; 

//   HomeCubit(this.repo) : super(HomeInitialState());
  
// // Future<void> getUserRole() async {
// //   emit(HomeLoadingState());
// //   try {
// //     final roleId = await CacheNetwork.getStringFromCache(key: AppConstants.roleIdKey);

// //     if (roleId != null && roleId.isNotEmpty) {
// //       userRole = roleId;
// //       print('✅ Role loaded from cache: $roleId');
// //     } else {
// //       userRole = '5';
// //       print('⚠️ No roleId found in cache, using default');
// //     }

// //     roleLoaded = true; // <<< أضف السطر ده هنا
// //     emit(HomeLoadedState(userRole));
// //   } catch (e) {
// //     roleLoaded = true; // <<< حتى في حالة الخطأ، حدث القيمة
// //     emit(HomeErrorState('فشل في تحميل الدور'));
// //   }
// // }
// // Future<void> reloadUserRole() async {
// //   emit(HomeLoadingState()); // لازم تبعت الحالة قبل التحميل

// //   try {
// //     final roleId = await CacheNetwork.getStringFromCache(key: AppConstants.roleIdKey);
// //     if (roleId != null && roleId.isNotEmpty) {
// //       userRole = roleId;
// //       print('✅ Reloaded roleId from cache: $roleId');
// //     } else {
// //       userRole = '5'; // افتراضي
// //     }

// //     roleLoaded = true;
// //     emit(HomeLoadedState(userRole));
// //   } catch (e) {
// //     roleLoaded = true;
// //     emit(HomeErrorState('حدث خطأ أثناء تحميل بيانات المستخدم'));
// //   }
// // }


//   Future<void> getUserRole() async {
//     emit(HomeLoadingState());
//     try {
//       final roleId = await CacheNetwork.getStringFromCache(key: AppConstants.roleIdKey);
//       if (roleId != null && roleId.isNotEmpty) {
//         userRole = roleId;
//         print('✅ Role loaded from cache: $roleId');
//       } else {
//         userRole = '5';
//         print('⚠️ No roleId found in cache, using default');
//       }
//       roleLoaded = true;
//       emit(HomeLoadedState(userRole));
//     } catch (e) {
//       roleLoaded = true;
//       emit(HomeErrorState('فشل في تحميل الدور'));
//     }
//   }
// Future<void> reloadUserRole() async {
//   emit(HomeLoadingState()); // إضافة حالة التحميل قبل البدء

//   try {
//     final roleId = await CacheNetwork.getStringFromCache(key: AppConstants.roleIdKey);
//     if (roleId != null && roleId.isNotEmpty) {
//       userRole = roleId;
//       print('🔄 Reloaded roleId from cache: $roleId');
//     } else {
//       userRole = '5'; // افتراضي
//       print('⚠️ No roleId found during reload, using default: 5');
//     }

//     roleLoaded = true;
//     emit(HomeLoadedState(userRole));
//   } catch (e) {
//     print('❌ Error reloading role: $e');
//     roleLoaded = true;
//     emit(HomeErrorState('حدث خطأ أثناء إعادة تحميل الدور'));
//   }
// }

// // أضف هذه الدالة لتأكيد تحميل الدور عند Hot Reload
// void ensureRoleLoaded() {
//   if (!roleLoaded) {
//     getUserRole();
//   } else {
//     reloadUserRole(); // إعادة تحميل الدور حتى في حالة كان محمل من قبل
//   }
// }
//   void changeTab(int index) {
//     currentIndex = index;
//     emit(HomeLoadedState(userRole));
//   }
//   //   Future<void> fetchFarms() async {
//   //   try {
//   //     emit(FetchFarmLoadingState());
//   //     final response = await dio.get("https://your-api-url.com/farms");

//   //     if (response.statusCode == 200) {
//   //       farms = (response.data as List)
//   //           .map((farm) => FarmModel.fromJson(farm))
//   //           .toList();
//   //       emit(FetchFarmSuccessState(farms));
//   //     } else {
//   //       farms = [];
//   //       emit(FetchFarmSuccessState(farms)); // عرض UI فارغ بدلاً من الخطأ
//   //     }
//   //   } catch (e) {
//   //     farms = [];
//   //     emit(FetchFarmSuccessState(farms)); // منع ظهور الخطأ واستمرار UI طبيعي
//   //   }
//   // }

//   // Future<void> addFarmer(String farmerName) async {
//   //   try {
//   //     emit(FarmLoadingState());
//   //     final response = await dio.post(
//   //       "https://your-api-url.com/farmers",
//   //       data: {"name": farmerName},
//   //     );

//   //     if (response.statusCode == 200 || response.statusCode == 201) {
//   //       await fetchFarms(); // تحديث القائمة بعد الإضافة
//   //       emit(FarmSuccessState());
//   //     } else {
//   //       emit(FarmFailureState(response.data['message'] ?? 'فشل إضافة المزرعة'));
//   //     }
//   //   } catch (e) {
//   //     emit(FarmFailureState(e.toString()));
//   //   }
//   // }
//     String? barnType;

//   void setBarnType(String type) {
//     barnType = type;
//     emit(RadioListUpdate()); // Use a meaningful state name
//   }
//  final FarmRepository repo;

//   Future<void> logout() async {
//     await CacheNetwork.deleteCacheItem(key: AppConstants.token);
//     await CacheNetwork.deleteCacheItem(key: AppConstants.roleIdKey);
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
  String userRole = '5';
  bool roleLoaded = false;

  HomeCubit(this.repo) : super(HomeInitialState());

  // Future<void> getUserRole() async {
  //   emit(HomeLoadingState());
  //   try {
  //     final roleId = await CacheNetwork.getStringFromCache(key: AppConstants.roleIdKey);
  //     if (roleId != null && roleId.isNotEmpty) {
  //       userRole = roleId;
  //       print('✅ Role loaded from cache: $roleId');
  //     } else {
  //       userRole = '5';
  //       print('⚠️ No roleId found in cache, using default');
  //     }
  //     roleLoaded = true;
  //     emit(HomeLoadedState(userRole));
  //   } catch (e) {
  //     roleLoaded = true;
  //     emit(HomeErrorState('فشل في تحميل الدور'));
  //   }
  // }
  Future<void> getUserRole() async {
    emit(HomeLoadingState());
    try {
      final roleId = await CacheNetwork.getStringFromCache(key: AppConstants.roleIdKey);
      if (roleId != null && roleId.isNotEmpty) {
        userRole = roleId;
        print('✅ Role loaded from cache: $roleId');
      } else {
        userRole = '5';
        print('⚠️ No roleId found in cache, using default');
      }
      roleLoaded = true;
      emit(HomeLoadedState(userRole));
    } catch (e) {
      roleLoaded = true;
      emit(HomeErrorState('فشل في تحميل الدور'));
    }
  }

  Future<void> reloadUserRole() async {
    emit(HomeLoadingState()); // إضافة حالة التحميل قبل البدء

    try {
      final roleId = await CacheNetwork.getStringFromCache(key: AppConstants.roleIdKey);
      if (roleId != null && roleId.isNotEmpty) {
        userRole = roleId;
        print('🔄 Reloaded roleId from cache: $roleId');
      } else {
        userRole = '5'; // افتراضي
        print('⚠️ No roleId found during reload, using default: 5');
      }

      roleLoaded = true;
      emit(HomeLoadedState(userRole));
    } catch (e) {
      print('❌ Error reloading role: $e');
      roleLoaded = true;
      emit(HomeErrorState('حدث خطأ أثناء إعادة تحميل الدور'));
    }
  }

  // أضف هذه الدالة لتأكيد تحميل الدور عند Hot Reload
  void ensureRoleLoaded() {
    if (!roleLoaded) {
      getUserRole();
    } else {
      reloadUserRole(); // إعادة تحميل الدور حتى في حالة كان محمل من قبل
    }
  }

  void changeTab(int index) {
    currentIndex = index;
    emit(HomeLoadedState(userRole));
  }

  String? barnType;

  void setBarnType(String type) {
    barnType = type;
    emit(RadioListUpdate()); // Use a meaningful state name
  }
  final FarmRepository repo;

  Future<void> logout() async {
    await CacheNetwork.deleteCacheItem(key: AppConstants.token);
    await CacheNetwork.deleteCacheItem(key: AppConstants.roleIdKey);
  }
}

// حالة جديدة عشان نعرف إن فيه تحديث في الـ RadioList
class RadioListUpdate extends HomeState {}