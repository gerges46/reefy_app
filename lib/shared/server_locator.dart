// lib/service_locator.dart
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

final sl = GetIt.instance;

void setupLocator() {
  sl.registerLazySingleton<Dio>(() => Dio(
        BaseOptions(
          baseUrl: 'http://farmsmanagement.runasp.net/api/',
          receiveTimeout: const Duration(seconds: 10),
          connectTimeout: const Duration(seconds: 10),
        ),
      ));
}
