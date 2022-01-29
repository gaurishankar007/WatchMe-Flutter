import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:assignment/api/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class HttpConnectUser {
  String baseurl = 'http://10.0.2.2:4040/';
  static String token = "";

  Future<Map> registerUser(UserRegister user) async {
    try {
      Map<String, dynamic> userData = {
        "username": user.username,
        "password": user.password,
        "email": user.email,
        "phone": user.phone,
      };

      final response =
          await post(Uri.parse(baseurl + "user/register"), body: userData);

      //json serializing inline
      final responseData = jsonDecode(response.body) as Map;
      return responseData;
    } catch (err) {
      log('$err');
    }
    return {"message": "Error Occured."};
  }

  Future<Map> loginUser(UserLogin user) async {
    try {
      Map<String, dynamic> userData = {
        "username_email": user.usernameEmail,
        "password": user.password,
      };

      final response =
          await post(Uri.parse(baseurl + "user/login"), body: userData);

      //json serializing inline
      final responseData = jsonDecode(response.body) as Map;
      return responseData;
    } catch (err) {
      log('$err');
    }
    return {"message": "Error Occured."};
  }

  Future<Map> addProfile(File? profilePicture) async {
    try {
      var request = http.MultipartRequest(
          'PUT', Uri.parse(baseurl + "user/changeProfile"));
      //using the token in the headers
      request.headers.addAll({
        'Authorization': 'Bearer $token',
      });
      // need a filename

      var profilePictureName = profilePicture!.path.split('/').last;
      // adding the file in the request
      request.files.add(
        http.MultipartFile(
          'file',
          profilePicture.readAsBytes().asStream(),
          profilePicture.lengthSync(),
          filename: profilePictureName,
        ),
      );
      print(token);
      var response = await request.send();
      var responseString = await response.stream.bytesToString();
      final responseData = jsonDecode(responseString) as Map;
      return responseData;
    } catch (err) {
      log('$err');
    }
    return {"message": "Error Occured."};
  }

  Future<Map> addCover(File? coverPicture) async {
    try {
      var request = http.MultipartRequest(
          'PUT', Uri.parse(baseurl + "user/changeCover"));
      //using the token in the headers
      request.headers.addAll({
        'Authorization': 'Bearer $token',
      });
      // need a filename

      var coverPictureName = coverPicture!.path.split('/').last;
      // adding the file in the request
      request.files.add(
        http.MultipartFile(
          'file',
          coverPicture.readAsBytes().asStream(),
          coverPicture.lengthSync(),
          filename: coverPictureName,
        ),
      );
      print(token);
      var response = await request.send();
      var responseString = await response.stream.bytesToString();
      final responseData = jsonDecode(responseString) as Map;
      return responseData;
    } catch (err) {
      log('$err');
    }
    return {"message": "Error Occured."};
  }
}
