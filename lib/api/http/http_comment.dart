import 'dart:convert';
import 'dart:io';

import 'package:assignment/api/http/http_user.dart';
import 'package:http/http.dart';

class HttpConnectComment {
  String baseurl = 'http://10.0.2.2:4040/';
  String token = HttpConnectUser.token;

  Future<List> getComments(String? post_id) async {
    final bearerToken = {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };

    final response = await post(Uri.parse(baseurl + "comments/get"),
        body: {"post_id": post_id}, headers: bearerToken);

    //json serializing inline
    final responseData = jsonDecode(response.body);
    return responseData;
  }
}
