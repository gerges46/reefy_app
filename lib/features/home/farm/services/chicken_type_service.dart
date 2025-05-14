// import '../../../../shared/dio_helper.dart';
// import '../model/checken_type_model.dart';

// class ChickenTypeService {
//   // CREATE
//   Future<void> createChickenType(String name) async {
//     try {
//       final response = await DioHelper.postData(
//         url: 'ChickenTypes/Create',
//         data: {'chickenTypeName': name},
//       );
//       if (response.statusCode != 200) {
//         throw Exception('فشل في إنشاء نوع الدجاج');
//       }
//     } catch (e) {
//       throw Exception('خطأ في إنشاء نوع الدجاج: $e');
//     }
//   }

//   // UPDATE
//   Future<void> updateChickenType(int id, String name) async {
//     try {
//       final response = await DioHelper.putData(
//         url: 'ChickenTypes/Update/$id',
//         data: {'chickenTypeName': name},
//       );
//       if (response.statusCode != 200) {
//         throw Exception('فشل في تحديث نوع الدجاج');
//       }
//     } catch (e) {
//       throw Exception('خطأ في تحديث نوع الدجاج: $e');
//     }
//   }

//   // DELETE
//   Future<void> deleteChickenType(int id) async {
//     try {
//       final response = await DioHelper.deleteData(
//         data: {'chickenTypeId': id},
//         url: 'ChickenTypes/Delete/$id',
//       );
//       if (response.statusCode != 200) {
//         throw Exception('فشل في حذف نوع الدجاج');
//       }
//     } catch (e) {
//       throw Exception('خطأ في حذف نوع الدجاج: $e');
//     }
//   }

//   // GET ALL
//   Future<List<ChickenTypeModel>> getAllChickenTypes() async {
//     try {
//       final response = await DioHelper.getData(url: 'ChickenTypes/GetAll');
//       if (response.statusCode == 200) {
//         return (response.data as List)
//             .map((json) => ChickenTypeModel.fromJson(json))
//             .toList();
//       } else {
//         throw Exception('فشل في جلب أنواع الدجاج');
//       }
//     } catch (e) {
//       throw Exception('خطأ في جلب أنواع الدجاج: $e');
//     }
//   }
// }
import '../../../../shared/dio_helper.dart';

class ChickenTypeService {
  final String baseUrl = 'ChickenTypes';

  Future<void> create(String name) async {
    try {
      final response = await DioHelper.postData(
        url: '$baseUrl/Create',
        data: {'chickenTypeName': name},
      );
      if (response.statusCode != 200) {
        throw Exception('فشل في إنشاء نوع الفراخ');
      }
    } catch (e) {
      throw Exception('خطأ أثناء إنشاء النوع: $e');
    }
  }

  Future<List<String>> getAll() async {
    try {
      final response = await DioHelper.getData(url: '$baseUrl/GetAll');
      if (response.statusCode == 200) {
        return List<String>.from(response.data.map((e) => e['chickenTypeName']));
      } else {
        throw Exception('فشل في جلب الأنواع');
      }
    } catch (e) {
      throw Exception('خطأ أثناء جلب الأنواع: $e');
    }
  }

  Future<void> update(int id, String name) async {
    try {
      final response = await DioHelper.putData(
        url: '$baseUrl/Update/$id',
        data: {'chickenTypeName': name},
      );
      if (response.statusCode != 200) {
        throw Exception('فشل في تحديث النوع');
      }
    } catch (e) {
      throw Exception('خطأ أثناء تحديث النوع: $e');
    }
  }

  Future<void> delete(int id) async {
    try {
      final response = await DioHelper.deleteData(
        url: '$baseUrl/$id',
        data: {'id': id},
      );
      if (response.statusCode != 200) {
        throw Exception('فشل في حذف النوع');
      }
    } catch (e) {
      throw Exception('خطأ أثناء حذف النوع: $e');
    }
  }
}

