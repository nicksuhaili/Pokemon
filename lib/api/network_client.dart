import 'package:dio/dio.dart';

// Set up dio client and will use by Retrofit to make http req
class NetworkClient {
  static Dio createDio() {
    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 3),
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    dio.interceptors.add(LogInterceptor(responseBody: true));
    return dio;
  }
}
