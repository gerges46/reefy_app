import 'package:dio/dio.dart';

import '../model/farm_info_model.dart';

class FarmService {
  final Dio _dio;
  final String baseUrl = "http://farmsmanagement.runasp.net/api/Farms";

  FarmService(this._dio);

  Future<void> createFarm(FarmModel farm) async {
    await _dio.post("$baseUrl/Create", data: farm.toJson());
  }

  Future<void> updateFarm(int farmId, FarmModel farm) async {
    await _dio.put("$baseUrl/Update/$farmId", data: farm.toJson());
  }

  Future<void> deleteFarm(int farmId) async {
    await _dio.delete("$baseUrl/Delete/$farmId");
  }

  Future<List<FarmModel>> getUserFarms(int userId) async {
    final response = await _dio.get("$baseUrl/GetAllByUserId/$userId");
    List data = response.data;
    return data.map((json) => FarmModel.fromJson(json)).toList();
  }
}
