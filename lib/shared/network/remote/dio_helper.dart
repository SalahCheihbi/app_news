import 'package:dio/dio.dart';


class DioHelper {
  static var dio = Dio();
  static int() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/',
        receiveDataWhenStatusError: false,
      ),
    );
  }

  static Future<Response> getData({
    required url,
    required dynamic query,
  }) async {
    return await dio.get(
      url,
      queryParameters: query,
    );
  }
}
