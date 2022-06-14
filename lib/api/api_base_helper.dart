import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:phonon_github/api/api_url.dart';
import 'package:phonon_github/api/app_exception.dart';

class ApiBaseHelper {
  Future<dynamic> get(String username, String token) async {
    var basicHeaders = {
      "Authorization": "token $token",
      "Accept": "application/vnd.github.v3+json"
    };
    var responseJson;
    try {
      final response = await http.get(
          Uri.parse(ApiUrl().getRepositoryUrl(username)),
          headers: basicHeaders);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(utf8.decode(response.bodyBytes));
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(utf8.decode(response.bodyBytes));
      case 401:
      case 403:
        throw UnauthorisedException(utf8.decode(response.bodyBytes));
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
