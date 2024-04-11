import 'dart:io';

import 'package:dio/dio.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sept_frontend_draft/network/request_client.dart';

class BaseRequest {
  static const String contentType = 'application/json; charset=UTF-8';

  Future<T> get<T>(String requestUrl,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      Map<String, dynamic>? header}) async {
    var dio = _createDio(header);
    Response response = await dio!.get(
      requestUrl,
      queryParameters: queryParameters,
      options: options,
    );

    return _handleResponse(response, requestUrl);
  }

  Future<T> post<T>(String requestUrl,
      {data,
      Options? options,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? header}) async {
    var dio = _createDio(header);
    Response response = await dio!.post(
      requestUrl,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );

    return _handleResponse(response, requestUrl);
  }

  Future<T> delete<T>(String requestUrl,
      {data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      Map<String, dynamic>? header}) async {
    var dio = _createDio(header);
    Response response = await dio!.delete(
      requestUrl,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );

    return _handleResponse(response, requestUrl);
  }

  Future<T> put<T>(String requestUrl,
      {data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      Map<String, dynamic>? header}) async {
    var dio = _createDio(header);
    Response response = await dio!.put(
      requestUrl,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );

    return _handleResponse(response, requestUrl);
  }

  Dio? _createDio(Map<String, dynamic>? header) {
    var dio = RequestClient().dioService;
    dio?.options.contentType = contentType;
    dio?.options.headers["Access-Control-Allow-Origin"] = '*';

    if (header != null) {
      dio?.options.headers.addAll(header);
    }

    return dio;
  }

  Future<T> _handleResponse<T>(Response response, String requestUrl) {
    if (response.statusCode == HttpStatus.ok) {
      var baseResult = response.data;
      return Future.value(baseResult);
    } else {
      throw (DioError(requestOptions: RequestOptions(path: requestUrl)));
    }
  }
}
