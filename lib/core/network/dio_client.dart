import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

import '../../commons/constants/api_url.dart';
import 'interceptors.dart';

class DioClient {
  late final Dio _dio;
  DioClient()
      : _dio = Dio(
          BaseOptions(
              baseUrl: ApiUrl.baseUrl,
              headers: {'Content-Type': 'application/json; charset=UTF-8'},
              responseType: ResponseType.json,
              sendTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 10)),
        )..interceptors.addAll([
            AuthorizationInterceptor(),
            LoggerInterceptor(),
          ]);

  // GET METHOD
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException {
      rethrow;
    }
  }

  // POST METHOD
  Future<Response> post(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.post(
        url,
        data: data,
        options: options,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // PUT METHOD
  Future<Response> put(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // DELETE METHOD
  Future<dynamic> delete(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final Response response = await _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> downloadFile(
    String url,
    String fileName, {
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final filePath = '${dir.path}/$fileName';

      await _dio.download(
        url,
        filePath,
        onReceiveProgress: onReceiveProgress,
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            receiveTimeout: const Duration(minutes: 1)),
      );

      return filePath;
    } catch (e) {
      rethrow;
    }
  }
}
