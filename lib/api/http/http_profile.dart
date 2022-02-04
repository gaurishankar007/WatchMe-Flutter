import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:assignment/api/http/http_user.dart';
import 'package:assignment/api/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class HttpConnectProfile {
  String baseurl = 'http://10.0.2.2:4040/';
  String token = HttpConnectUser.token;

  Future<Map> getPersonalInfo() async {
    try {
      final bearerToken = {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      };

      final response = await get(Uri.parse(baseurl + "profile/get/my"),
          headers: bearerToken);

      //json serializing inline
      final responseData = jsonDecode(response.body) as Map;
      return responseData;
    } catch (err) {
      log('$err');
    }
    return {"message": "Error Occured."};
  }

  Future<Map> addPersonalInfo(PersonalInfoRegister pInfo) async {
    try {
      Map<String, dynamic> userData = {
        "first_name": pInfo.firstname,
        "last_name": pInfo.lastname,
        "gender": pInfo.gender,
        "birthday": pInfo.birthdate,
        "biography": pInfo.biography,
      };

      final bearerToken = {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      };

      final response = await put(Uri.parse(baseurl + "profile/update"),
          body: userData, headers: bearerToken);

      //json serializing inline
      final responseData = jsonDecode(response.body) as Map;

      return responseData;
    } catch (err) {
      log('$err');
    }
    return {"message": "Error Occured."};
  }
}
