import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:live_football_stats/config/const/api_timeout.dart';
import 'package:live_football_stats/core/error/exceptions.dart';

class DioClient {
  Dio? dio;
  DioClient(String baseUrl) {
    dio = Dio()
      ..options.baseUrl = baseUrl
      ..options.connectTimeout =
          const Duration(seconds: ApiTimeout.connectionTimeout)
      ..options.receiveTimeout =
          const Duration(seconds: ApiTimeout.receiveTimeout)
      ..options.responseType = ResponseType.json;
    dio!.interceptors.add(InterceptorsWrapper(
      onError: (error, handler) {
        // Handle errors
        print('Error occurred: $error');
        handler.next(error);
        if (kDebugMode) {
          print("app error data $error");
        }
        ErrorEntity eInfo = createErrorEntity(error);
        onError(eInfo);
      },
      onRequest: (options, handler) {
        // Perform tasks before sending the request
        print('Sending request to: ${options.uri}');
        handler.next(options);
        return handler.next(options);
      },
      onResponse: (response, handler) {
        // Perform tasks on successful response
        print('Received response with status: ${response.statusCode}');
        if (kDebugMode) {
          print("app response data ${response.data}");
        }
        return handler.next(response);
      },
    ));
  }
}
