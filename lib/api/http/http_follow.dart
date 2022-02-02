import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:assignment/api/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class HttpConnectUser {
  String baseurl = 'http://10.0.2.2:4040/';
  static String token = "";

  Future<Map> getWatchers() async {
    try {
      final bearerToken = {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      };

      final response = await get(Uri.parse(baseurl + "followers/get"), headers: bearerToken);

      //json serializing inline
      final responseData = jsonDecode(response.body) as Map;
      return responseData;
    } catch (err) {
      log('$err');
    }
    return {"message": "Error Occured."};
  }
}
