// lib/service_locator.dart
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import '../features/home/farm/repo/farm_setup_repo.dart';
import '../features/home/farm/services/farm_setup_services.dart';
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

       // Register services
  sl.registerLazySingleton<FarmService>(() => FarmService(sl()));

  // Register repositories
  sl.registerLazySingleton<FarmRepository>(() => FarmRepository(sl()));

  // Register cubits
  sl.registerFactory<HomeCubit>(() => HomeCubit(sl()));
}
