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
      // adding the file in the request
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

      final response = await post(Uri.parse(baseurl + "profile/add"),
          body: userData, headers: bearerToken);

      //json serializing inline
      final responseData = jsonDecode(response.body) as Map;

      return responseData;
    } catch (err) {
      log('$err');
    }
    return {"message": "Error Occured."};
  }

  Future<Map> addAddress(AddressRegister address) async {
    try {
      Map<String, dynamic> userData = {
        "pCountry": address.pCountry,
        "pState": address.pState,
        "pCity": address.pCity,
        "pStreet": address.pStreet,
        "tCountry": address.tCountry,
        "tState": address.tState,
        "tCity": address.tCity,
        "tStreet": address.tStreet,
      };

      final bearerToken = {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      };

      final response = await post(Uri.parse(baseurl + "address/add"),
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
