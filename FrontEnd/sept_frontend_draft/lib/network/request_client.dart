import 'package:dio/dio.dart';

class RequestClient {
  static const int CONNECT_TIMEOUT = 30000;
  static const int RECEIVE_TIMEOUT = 30000;
  static const int HTTP_SUCCEED = 10000;
  static const String contentType = 'application/json; charset=UTF-8';

  static final RequestClient _instance = RequestClient._internal();

  factory RequestClient() => _instance;
  Dio? _client;

  Dio? get dioService => _client;

  RequestClient._internal() {
    if (_client == null) {
      var options = BaseOptions(
          baseUrl: 'baseUrl',
          connectTimeout: CONNECT_TIMEOUT,
          receiveTimeout: RECEIVE_TIMEOUT,
          headers: {
            'content-type': 'application/json;charset=UTF-8',
          });

      _client = Dio(options);
    }
  }
}
