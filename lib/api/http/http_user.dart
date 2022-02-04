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
    if (profilePicture == null) {
      return {"message": "File not selected."};
    }

    try {
      var request = http.MultipartRequest(
          'PUT', Uri.parse(baseurl + "user/changeProfile"));

      //using the token in the headers
      request.headers.addAll({
        'Authorization': 'Bearer $token',
      });

      // Open a bytestream
      var stream = profilePicture.readAsBytes().asStream();

      // Get the file length
      var length = profilePicture.lengthSync();

      // Get the filename
      var profilePictureName = profilePicture.path.split('/').last;

      // Adding the file in the request
      request.files.add(
        http.MultipartFile(
          'profile',
          stream,
          length,
          filename: profilePictureName,
        ),
      );

      var response = await request.send();
      var responseString = await response.stream.bytesToString();
      final responseData = jsonDecode(responseString) as Map;
      return responseData;
    } catch (err) {
      log('$err');
    }
    return {"message": "Error occured. Something went wrong."};
  }

  Future<Map> addCover(File? coverPicture) async {
    if (coverPicture == null) {
      return {"message": "File not selected."};
    }
    try {
      var request =
          http.MultipartRequest('PUT', Uri.parse(baseurl + "user/changeCover"));

      //using the token in the headers
      request.headers.addAll({
        'Authorization': 'Bearer $token',
      });

      // need a filename
      var coverPictureName = coverPicture.path.split('/').last;

      // adding the image in the request
      request.files.add(
        http.MultipartFile(
          'cover',
          coverPicture.readAsBytes().asStream(),
          coverPicture.lengthSync(),
          filename: coverPictureName,
        ),
      );

      var response = await request.send();
      var responseString = await response.stream.bytesToString();
      final responseData = jsonDecode(responseString) as Map;
      return responseData;
    } catch (err) {
      log('$err');
    }
    return {"message": "Error Occured. Something went wrong."};
  }

  Future<Map> generateResetToken(passResetToken user) async {
    try {
      Map<String, dynamic> userData = {
        "email": user.email,
        "newPass": user.newPassword,
      };

      final response = await post(
          Uri.parse(baseurl + "user/generatePassResetToken"),
          body: userData);

      //json serializing inline
      final responseData = jsonDecode(response.body) as Map;

      return responseData;
    } catch (err) {
      log('$err');
    }
    return {"message": "Error Occured."};
  }

  Future<Map> resetPassword(String resetToken) async {
    try {
      final response =
          await put(Uri.parse(baseurl + "user/passReset/" + resetToken));

      //json serializing inline
      final responseData = jsonDecode(response.body) as Map;

      return responseData;
    } catch (err) {
      log('$err');
    }
    return {"message": "Error Occured."};
  }

  Future<Map> getUser() async {
    try {
      final bearerToken = {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      };

      final response = await get(Uri.parse(baseurl + "user/checkType"),
          headers: bearerToken);

      //json serializing inline
      final responseData = jsonDecode(response.body) as Map;
      return responseData;
    } catch (err) {
      log('$err');
    }
    return {"message": "Error Occured."};
  }

  Future<Map> getUserOther(String? user_id) async {
    try {
      final bearerToken = {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      };

      final response = await post(Uri.parse(baseurl + "user/other"),
          body: {"user_id": user_id!}, headers: bearerToken);

      //json serializing inline
      final responseData = jsonDecode(response.body) as Map;
      return responseData;
    } catch (err) {
      log('$err');
    }
    return {"message": "Error Occured."};
  }

  Future<Map> changePassword(ChangePassword passwordData) async {
    try {
      Map<String, dynamic> passData = {
        "currPassword": passwordData.currentPassword,
        "newPassword": passwordData.newPassword,
      };

      final bearerToken = {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      };

      final response = await put(Uri.parse(baseurl + "user/changePassword"),
          body: passData, headers: bearerToken);

      //json serializing inline
      final responseData = jsonDecode(response.body) as Map;
      return responseData;
    } catch (err) {
      log('$err');
    }
    return {"message": "Error Occured."};
  }

  Future<Map> changeUsername(String username) async {
    try {
      Map<String, dynamic> userData = {
        "username": username,
      };

      final bearerToken = {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      };

      final response = await put(Uri.parse(baseurl + "user/changeUsername"),
          body: userData, headers: bearerToken);

      //json serializing inline
      final responseData = jsonDecode(response.body) as Map;
      return responseData;
    } catch (err) {
      log('$err');
    }
    return {"message": "Error Occured."};
  }

  Future<Map> changeEmail(String email) async {
    try {
      Map<String, dynamic> userData = {
        "email": email,
      };

      final bearerToken = {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      };

      final response = await put(Uri.parse(baseurl + "user/changeEmail"),
          body: userData, headers: bearerToken);

      //json serializing inline
      final responseData = jsonDecode(response.body) as Map;
      return responseData;
    } catch (err) {
      log('$err');
    }
    return {"message": "Error Occured."};
  }

  Future<Map> changePhone(String phone) async {
    try {
      Map<String, dynamic> userData = {
        "phone": phone,
      };

      final bearerToken = {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      };

      final response = await put(Uri.parse(baseurl + "user/changePhone"),
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
