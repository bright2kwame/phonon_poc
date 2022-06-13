import 'dart:async';
import 'dart:convert';
import 'network_util.dart';

class ApiService {
  final NetworkUtil _netUtil = NetworkUtil();
  static Map<String, String> basicHeaders = {};
  static const generalErrorMessage = "Something went wrong, try again later.";
  static const noInternetConnection =
      "It appears you are offline, connect and try again.";

  ApiService() {
    //MARK:  place your token here
    basicHeaders = {
      "Authorization": "token <REPLACE WITH PERSONAL TOKEN>",
      "Accept": "application/vnd.github.v3+json"
    };
  }

  //MARK: get list of items
  /// @url, url to fetch data
  Future<dynamic> getData(String url) {
    return _netUtil.get(url, basicHeaders, utf8).then((dynamic data) {
      return data;
    }).onError((error, stackTrace) => throw Exception(error));
  }

  //MARK: post data
  /// @url, url to fetch data
  Future<dynamic> postData(String url, Map<String, String> data) {
    return _netUtil.post(url, basicHeaders, data, utf8).then((dynamic data) {
      return data;
    }).onError((error, stackTrace) => throw Exception(error));
  }
}
