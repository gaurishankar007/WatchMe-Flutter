import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:assignment/api/http/http_user.dart';
import 'package:assignment/api/model/post.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class HttpConnetPost {
  String baseurl = 'http://10.0.2.2:4040/';
  String token = HttpConnectUser.token;

  Future<Map> postImage(AddPost postData) async {
    try {
      // Making multipart request
      var request =
          http.MultipartRequest('POST', Uri.parse(baseurl + "post/add"));

      // Adding headers
      request.headers.addAll({
        'Authorization': 'Bearer $token',
      });

      // Adding forms data
      Map<String, String> postDetail = {
        "caption": "${postData.caption}",
        "description": "${postData.description}",
      };
      request.fields.addAll(postDetail);
      for (int i = 0; i < postData.taggedFriend!.length; i++) {
        request.fields.addAll({"tag_friend[${i}]": "${postData.taggedFriend![i]}"});
      }

      // Adding images
      List<MultipartFile> multipartList = [];
      for (int i = 0; i < postData.images!.length; i++) {
        multipartList.add(http.MultipartFile(
          'images',
          postData.images![i].readAsBytes().asStream(),
          postData.images![i].lengthSync(),
          filename: postData.images![i].path.split('/').last,
        ));
      }
      request.files.addAll(multipartList);

      final response = await request.send();
      var responseString = await response.stream.bytesToString();
      final responseData = jsonDecode(responseString) as Map;
      return responseData;
    } catch (err) {
      log('$err');
    }
    return {"message": "Error Occured."};
  }
}
