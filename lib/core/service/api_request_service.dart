import 'package:dio/dio.dart';
import 'package:test_mvvm/core/failure/failure.dart';
import 'package:test_mvvm/core/remote/dio_option.dart';

class ApiRequestService {
  final Dio _dio = Dio();

  Future<Response> get(String url, {bool needAuth = false, String? token}) async {
    if (needAuth) {
      if (token == null) throw Future.error(const ServerFailure(statusCode: 401, message: 'Unauthorized'));
    }

    final response = await _dio.get(
      url,
      options: DioOption.dioOptions(needAuth: needAuth, token: token)
    );
    return response;
  }

  Future<Response> post(String url, {bool needAuth = false, String? token, Map<String, dynamic>? data}) async {
    if (needAuth) {
      if (token == null) throw Future.error(const ServerFailure(statusCode: 401, message: 'Unauthorized'));
    }

    final response = await _dio.post(
      url,
      options: DioOption.dioOptions(needAuth: needAuth, token: token),
      data: data
    );
    return response;
  }
}