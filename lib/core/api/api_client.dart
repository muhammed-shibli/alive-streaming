import 'package:dio/dio.dart';

/// Centralised Dio client used by all repositories. Swap [baseUrl] / add
/// auth interceptors here when integrating real APIs.
class ApiClient {
  ApiClient._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    _dio.interceptors.add(
      LogInterceptor(
        requestBody: false,
        responseBody: false,
        request: false,
        responseHeader: false,
        requestHeader: false,
      ),
    );
  }

  static final ApiClient instance = ApiClient._internal();

  static const String baseUrl = 'https://api.example.com';

  late final Dio _dio;

  Dio get dio => _dio;

  Future<Response<T>> get<T>(String path, {Map<String, dynamic>? query}) =>
      _dio.get<T>(path, queryParameters: query);

  Future<Response<T>> post<T>(String path, {Object? data}) =>
      _dio.post<T>(path, data: data);
}
