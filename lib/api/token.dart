import 'package:shared_preferences/shared_preferences.dart';

class Token {
  void setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
  }

  get getToken async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";
    return token;
  }

  void removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
  }
}
