import 'package:dio/dio.dart';

class DioOption {
  static Options dioOptions({isMultipart = false, bool needAuth = false, String? token}) {
    Map<String, dynamic> header = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    if (needAuth) {
      header['Authorization'] = 'Bearer $token';
    }

    if (isMultipart) {
      header['Content-Type'] = 'multipart/form-data';
    }

    return Options(
      headers: header,
      validateStatus: (status) => true,
      receiveDataWhenStatusError: true,
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
    );
  }
}