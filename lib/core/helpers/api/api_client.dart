import 'package:dio/dio.dart';
import 'package:i_pharaoh/core/helpers/api/api_endpoints.dart';

class ApiClient {
  final Dio _dio;

  ApiClient(this._dio) {
    _dio
      ..options.baseUrl = ApiEndPoints.baseUrl
      ..options.headers = {'Accept': 'application/json'};
  }

  Future<Response> get(String endPoint, {Map<String, dynamic>? data}) async =>
      await _dio.get(endPoint, data: data);

  Future<Response> post(String endPoint, dynamic data) async =>
      await _dio.post(endPoint,
          data: data,
          options: Options(headers: {'Content-Type': 'multipart/form-data'}));
}
