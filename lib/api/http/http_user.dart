import 'dart:convert';

import 'package:assignment/api/model/user.dart';
import 'package:http/http.dart';

class HttpConnectUser {
  String baseurl = 'http://10.0.2.2:4040/';
  static String token = '';

  // Sending data to the server
  Future<Map> registerPost(UserRegister user) async {
    Map<String, dynamic> userMap = {
      "username": user.username,
      "password": user.password,
      "email": user.email,
      "phone": user.phone,
    };
    
    final response =
        await post(Uri.parse(baseurl + "user/register"), body: userMap);

    //json serializing inline
    final responseData = jsonDecode(response.body) as Map;
    return responseData;
  }

  Future<Map> loginUser(String usernameEmail, String password) async {
    Map<String, dynamic> userData = {
      "username_email": usernameEmail,
      "password": password,
    };

    final response =
        await post(Uri.parse(baseurl + "user/login"), body: userData);

    //json serializing inline
    final responseData = jsonDecode(response.body) as Map;
    return responseData;
  }
}
