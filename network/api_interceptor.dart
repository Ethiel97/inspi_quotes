import 'dart:convert';
import 'dart:io';

import 'package:http_interceptor/http/interceptor_contract.dart';
import 'package:http_interceptor/models/request_data.dart';
import 'package:http_interceptor/models/response_data.dart';

class ApiInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    data.headers[HttpHeaders.acceptHeader] = 'application/json';
    data.headers[HttpHeaders.contentTypeHeader] = 'application/json';
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    /*print(
        "{REQUEST: ${data.url}\n STATUS CODE: ${data.statusCode}\nBODY: ${jsonDecode(data.body)}\n");*/

    Map<String, dynamic> parsedData = jsonDecode(data.body!);

    return ResponseData(
      data.bodyBytes,
      data.statusCode,
      isRedirect: data.isRedirect,
      headers: data.headers,
      request: data.request,
      persistentConnection: data.persistentConnection,
      contentLength: data.contentLength,
      body: jsonDecode(parsedData.containsKey('results')
          ? parsedData['results']
          : parsedData),
    );

    // return data;
  }
}
