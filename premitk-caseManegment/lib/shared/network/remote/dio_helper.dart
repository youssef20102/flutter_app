import 'package:dio/dio.dart';

import 'package:primitk_crm/shared/network/remote/end_points.dart';

class DioHelper {
  static late Dio dio;

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: BASE_URL,
        headers: {
          "Access-Control-Allow-Credentials": true, // Required for cookies, authorization headers with HTTPS
          "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token",
          "Access-Control-Allow-Methods": "GET, POST, OPTIONS"
        }
      ),
    );
  }

  static Future<Response> postData({
    required Map<String, dynamic> data,
    required String url,
    String? token,
    Map<String, dynamic>? query,
  }) {
    return dio.post(
      url,
      data: data,
      options: Options(

        headers: {
          'api-token':token
        },
      ),


    );
  }

  static Future<Response> getData({
    required String url,
    String? token,
    Map<String, dynamic>? query,
  }) {
    return dio.get(
      url,
      options: Options(
        headers: {
          'api-token':token??'',


        },
      ),
      queryParameters: query,
    );
  }


  static Future<Response> uploadData({
    Map<String, dynamic>? query,
    required  data,
    required String url,
    String? token,
  }) {
    return dio.post(
      url,
      data: data,
      options: Options(
extra:query ,
        headers: {
          'api-token':token
        },
      ),
    );
  }



}
