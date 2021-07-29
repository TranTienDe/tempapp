import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tempapp/commons/constants/url_path.dart';

class BaseService {
  BaseService._privateConstructor();

  static final BaseService instance = BaseService._privateConstructor();

  var _client = http.Client();

  Future<dynamic> get(String url) async {
    String endpoint = UrlPath.host + url;

    return await _client.get(Uri.parse(endpoint)).then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400) throw Exception(response.body.toString());

      return json.decode(response.body);
    });
  }

  Future<dynamic> post(String url, {body, encoding}) async {
    String endpoint = UrlPath.host + url;

    return await _client
        .post(Uri.parse(endpoint), body: body, headers: {'Content-type': 'application/json'}, encoding: encoding)
        .then((http.Response response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400) throw Exception(response.body.toString());

      return json.decode(response.body);
    });
  }
}
