import 'dart:convert';
import 'dart:io';
// import 'dart:typed_data';

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
    // bool isResourceList =

    var parsedData = jsonDecode(data.body!);

    if (parsedData.runtimeType.toString() == 'List<dynamic>') {
      return ResponseData(
        data.bodyBytes,
        data.statusCode,
        isRedirect: data.isRedirect,
        headers: data.headers,
        request: data.request,
        persistentConnection: data.persistentConnection,
        contentLength: data.contentLength,
        body: jsonEncode(parsedData),
      );
    }

    bool isResourceList = parsedData.containsKey('results');

    var responseData = isResourceList ? parsedData['results'] : parsedData;

    responseData = jsonEncode(responseData);
    // var dataBytes = Uint8List.fromList(responseData.codeUnits);

    // print(parsedData.runtimeType.toString());


    return ResponseData(
      data.bodyBytes,
      data.statusCode,
      isRedirect: data.isRedirect,
      headers: data.headers,
      request: data.request,
      persistentConnection: data.persistentConnection,
      contentLength: data.contentLength,
      body: responseData
    );
  }
}
