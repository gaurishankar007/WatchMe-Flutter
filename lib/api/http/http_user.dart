import 'dart:convert';

import 'package:assignment/api/model/user.dart';
import 'package:http/http.dart';

class HttpConnectUser {
  String baseurl = 'http://10.0.2.2:4040/';
  static String token = '';

  // Sending data to the server
  // Future<bool> registerPost(UserRegister user) async {
  //   Map<String, dynamic> userMap = {
  //     "username": user.username,
  //     "password": user.password,
  //     "email": user.email,
  //     "phone": user.phone,
  //   };
  //   final response =
  //       await post(Uri.parse(baseurl + "auth/register"), body: userMap);
  //   if (response.statusCode == 200) {
  //     var usrRes = ResponseUser.fromJson(jsonDecode(response.body));
  //     return usrRes.success!;
  //   } else {
  //     return false;
  //   }
  // }

  Future<Map> loginUser(String usernameEmail, String password) async {
    Map<String, dynamic> userData = {
      "username_email": usernameEmail,
      "password": password,
    };

    try {
      final response =
          await post(Uri.parse(baseurl + "user/login"), body: userData);

      //json serializing inline
      final responseData = jsonDecode(response.body) as Map;
      return responseData;
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return {"message": "Login Faild, Error Occured!"};
  }
}
