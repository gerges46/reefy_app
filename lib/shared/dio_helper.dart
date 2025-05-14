import 'package:dio/dio.dart';

class DioHelper {
  static  Dio dio=Dio();

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://farmsmanagement.runasp.net/api/',
        receiveDataWhenStatusError: true,
        headers: {'Content-Type': 'application/json'},
      ),
    );
  }

  static Future<Response> getData({required String url}) async {
    return await dio.get(url);
  }

  static Future<Response> postData({required String url, required Map<String, dynamic> data}) async {
    return await dio.post(url, data: data);
  }

  static Future<Response> putData({required String url, required Map<String, dynamic> data}) async {
    return await dio.put(url, data: data);
  }
  static Future<Response> deleteData({required String url, required Map<String, dynamic> data}) async {
    return await dio.delete(url, data: data);
  }
}
