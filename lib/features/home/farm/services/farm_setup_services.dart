import '../../../../shared/dio_helper.dart';
import '../model/farm_info_model.dart';

class FarmService {
  final String baseUrl = 'Farms';

  // CREATE
  Future<void> createFarm(FarmModel farm) async {
    try {
      final response = await DioHelper.postData(
        url: '$baseUrl/Create',
        data: farm.toJson(),

      );
      print(response.data);
      if (response.statusCode != 200) {
        print(response.data);
        throw Exception('فشل في إنشاء المزرعة');
        
      }
    } catch (e) {
      print(e.toString());
      throw Exception('خطأ في إنشاء المزرعة: $e');
    }
  }

  // GET ALL
  // Future<List<FarmModel>> getFarms() async {
  //   try {
  //     final response = await DioHelper.getData(url: '$baseUrl/GetAll');
  //     if (response.statusCode == 200) {
  //       return (response.data as List)
  //           .map((json) => FarmModel.fromJson(json))
  //           .toList();
  //     } else {
  //       throw Exception('فشل في جلب المزارع');
  //     }
  //   } catch (e) {
  //     throw Exception('خطأ في جلب المزارع: $e');
  //   }
  // }
  Future<List<FarmModel>> getFarms() async {
  try {
    final response = await DioHelper.getData(url: '$baseUrl/GetAll');
    if (response.statusCode == 200) {
      final List farmsJson = response.data['data'];
      return farmsJson.map((json) => FarmModel.fromJson(json)).toList();
    } else {
      throw Exception('فشل في جلب المزارع');
    }
  } catch (e) {
    throw Exception('خطأ في جلب المزارع: $e');
  }
}


  // GET BY ID
  Future<FarmModel> getFarmById(int id) async {
    try {
      final response = await DioHelper.getData(url: '$baseUrl/GetFarmById/$id');
      if (response.statusCode == 200) {
        return FarmModel.fromJson(response.data);
      } else {
        throw Exception('فشل في جلب بيانات المزرعة');
      }
    } catch (e) {
      throw Exception('خطأ في جلب بيانات المزرعة: $e');
    }
  }

  // UPDATE by ID
  Future<void> updateFarm(int id, FarmModel farm) async {
    try {
      final response = await DioHelper.putData(
        url: '$baseUrl/Update/$id',
        data: farm.toJson(),
      );
      if (response.statusCode != 200) {
        throw Exception('فشل في تحديث بيانات المزرعة');
      }
    } catch (e) {
      throw Exception('خطأ في تحديث بيانات المزرعة: $e');
    }
  }

  // DELETE by ID
  Future<void> deleteFarm(int id) async {
    try {
      final response = await DioHelper.deleteData(
        url: '$baseUrl/$id',
        data: {'farmId': id}, 
      );
      if (response.statusCode != 200) {
        throw Exception('فشل في حذف المزرعة');
      }
    } catch (e) {
      throw Exception('خطأ في حذف المزرعة: $e');
    }
  }
}
