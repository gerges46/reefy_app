import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../features/home/farm/repo/chicken_type_repo.dart';
import '../features/home/farm/repo/farm_setup_repo.dart';
import '../features/home/farm/services/chicken_type_service.dart';
import '../features/home/farm/services/farm_setup_services.dart';
import '../features/home/farm/view_model/cubit/farm_managment_cubit.dart';
import '../features/home/view_model/cubit/home_cubit.dart';
final sl = GetIt.instance;
void setupLocator() {
  sl.registerLazySingleton<Dio>(() => Dio(
        BaseOptions(
          baseUrl: 'http://farmsmanagement.runasp.net/api/',
          receiveTimeout: const Duration(seconds: 10),
          connectTimeout: const Duration(seconds: 10),
        ),
      ));

  // Services
  sl.registerLazySingleton<FarmService>(() => FarmService()); // ✅ بدون sl()
  sl.registerLazySingleton<ChickenTypeService>(() => ChickenTypeService()); // ✅ بدون sl()

  // Repositories
  sl.registerLazySingleton<FarmRepository>(() => FarmRepository(sl()));
  sl.registerLazySingleton<ChickenTypeRepository>(() => ChickenTypeRepository(sl()));

  // Cubits
  sl.registerFactory<HomeCubit>(() => HomeCubit(sl()));
  sl.registerFactory<FarmManagmentCubit>(() => FarmManagmentCubit(sl(), sl()));
}
