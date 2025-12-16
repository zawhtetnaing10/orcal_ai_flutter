import 'package:orcal_ai_flutter/network/dio_provider.dart';
import 'package:orcal_ai_flutter/network/orcal_api_client.dart';

import 'package:orcal_ai_flutter/network/orcal_api_client.dart';

class RetrofitProvider {
  static final RetrofitProvider _instance = RetrofitProvider._internal();
  late final OrcalApiClient _apiClient;

  RetrofitProvider._internal() {
    final dio = DioProvider().dio;

    _apiClient = OrcalApiClient(dio);
  }

  factory RetrofitProvider() {
    return _instance;
  }

  OrcalApiClient get apiClient => _apiClient;
}