import 'dart:convert';
import 'dart:io';

import 'package:assignment/api/http/http_user.dart';
import 'package:assignment/api/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class HttpConnectWatch {
  String baseurl = 'http://10.0.2.2:4040/';
  String token = HttpConnectUser.token;

  Future<Map> removeWatcher(String userId) async {
    final bearerToken = {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };

    final response = await delete(Uri.parse(baseurl + "removeFollower"),
        body: {"follower": userId}, headers: bearerToken);

    //json serializing inline
    final responseData = jsonDecode(response.body);
    return responseData;
  }

  Future<Map> unWatch(String userId) async {
    final bearerToken = {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };

    final response = await delete(Uri.parse(baseurl + "unFollow"),
        body: {"followed_user": userId}, headers: bearerToken);
        
    //json serializing inline
    final responseData = jsonDecode(response.body);
    return responseData;
  }

  Future<Map> getUserNum() async {
    final bearerToken = {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };

    final response =
        await get(Uri.parse(baseurl + "number/user"), headers: bearerToken);

    //json serializing inline
    final responseData = jsonDecode(response.body);
    return responseData;
  }

  Future<List> getWatchers() async {
    final bearerToken = {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };

    final response =
        await get(Uri.parse(baseurl + "followers/get"), headers: bearerToken);

    //json serializing inline
    final responseData = jsonDecode(response.body);
    return responseData;
  }

  Future<List> getWatchings() async {
    final bearerToken = {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };

    final response = await get(Uri.parse(baseurl + "followedUsers/get"),
        headers: bearerToken);

    //json serializing inline
    final responseData = jsonDecode(response.body);
    return responseData;
  }
}
