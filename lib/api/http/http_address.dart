import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:assignment/api/http/http_user.dart';
import 'package:assignment/api/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class HttpConnectAddress {
  String baseurl = 'http://10.0.2.2:4040/';
  String token = HttpConnectUser.token;

  Future<Map> getAddressInfo() async {
    try {
      final bearerToken = {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      };

      final response = await get(Uri.parse(baseurl + "address/get/my"),
          headers: bearerToken);

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

      final response = await put(Uri.parse(baseurl + "address/update"),
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
