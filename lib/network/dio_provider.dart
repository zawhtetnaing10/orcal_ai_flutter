import 'package:dio/dio.dart';

import '../utils/constants.dart';

class DioProvider {
  static final DioProvider _instance = DioProvider._internal();
  late final Dio _dio;

  DioProvider._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: kBaseUrl,
        headers: {
          Headers.acceptHeader: 'application/json',
          Headers.contentTypeHeader: 'application/json',
        },
        connectTimeout: const Duration(seconds: 120),
        receiveTimeout: const Duration(seconds: 120),
      ),
    );
  }

  factory DioProvider() {
    return _instance;
  }

  Dio get dio => _dio;
}