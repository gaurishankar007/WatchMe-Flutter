import 'package:assignment/api/http/http_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Token {
  void setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
  }

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";
    HttpConnectUser.token = token;
    return token;
  }

  void removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
  }
}
