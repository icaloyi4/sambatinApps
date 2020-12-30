import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import '../global_conts.dart';
import 'app_exception.dart';

class ApiBaseHelper {

  Future<dynamic> get(String url, Map<String, String> headers) async {
    print('Api Get, url $url');
    var responseJson;
    try {
      final response = await http.get(MyConst.baseUrl + url, headers: headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api get recieved!');
    return responseJson;
  }

  Future<dynamic> post(String url, Map<String, String> headers, Map<String, String> body ) async {
    print('Api Get, url $url');
    var responseJson;
    try {
      final response = await http.post(MyConst.baseUrl + url, headers: headers, body: body);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api get recieved!');
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response
                .statusCode}');
    }
  }
}