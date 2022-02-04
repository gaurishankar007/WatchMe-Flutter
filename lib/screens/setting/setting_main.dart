import 'package:assignment/api/http/http_user.dart';
import 'package:assignment/api/token.dart';
import 'package:assignment/screens/riverpod/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final themeController =
      StateNotifierProvider<ThemeNotifier, bool>((_) => ThemeNotifier());
  int activeNav = 5;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      Color backColor =
          ref.watch(themeController) ? Colors.black : Colors.white;
      Color textColor =
          ref.watch(themeController) ? Colors.white : Colors.black87;
      return Scaffold(
        backgroundColor: backColor,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: textColor,
          ),
          backgroundColor: backColor,
          title: Text(
            "Settings",
            style: TextStyle(
              color: textColor,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
          shape: Border(
            bottom: BorderSide(
              color: textColor,
              width: .1,
            ),
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, "/profile-setting");
                },
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 0,
                ),
                horizontalTitleGap: 5,
                leading: Icon(
                  Icons.face_retouching_natural_sharp,
                  size: 30,
                  color: Colors.deepPurpleAccent[700],
                ),
                title: Text(
                  "Profile Picture",
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, "/cover-setting");
                },
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 0,
                ),
                horizontalTitleGap: 5,
                leading: Icon(
                  Icons.picture_in_picture_sharp,
                  size: 30,
                  color: Colors.deepPurpleAccent[700],
                ),
                title: Text(
                  "Cover Picture",
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, "/password-setting");
                },
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 0,
                ),
                horizontalTitleGap: 5,
                leading: Icon(
                  Icons.vpn_key_sharp,
                  size: 30,
                  color: Colors.deepPurpleAccent[700],
                ),
                title: Text(
                  "Password",
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, "/user-setting");
                },
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 0,
                ),
                horizontalTitleGap: 5,
                leading: Icon(
                  Icons.person,
                  size: 30,
                  color: Colors.deepPurpleAccent[700],
                ),
                title: Text(
                  "User information",
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, "/personal-setting");
                },
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 0,
                ),
                horizontalTitleGap: 5,
                leading: Icon(
                  Icons.person_pin_rounded,
                  size: 30,
                  color: Colors.deepPurpleAccent[700],
                ),
                title: Text(
                  "Personal information",
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, "/address-setting");
                },
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 0,
                ),
                horizontalTitleGap: 5,
                leading: Icon(
                  Icons.person_pin_circle_sharp,
                  size: 30,
                  color: Colors.deepPurpleAccent[700],
                ),
                title: Text(
                  "Address information",
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  ref.watch(themeController)
                      ? ref.read(themeController.notifier).lightTheme()
                      : ref.read(themeController.notifier).darkTheme();

                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/home', (Route<dynamic> route) => false);

                  ref.watch(themeController)
                      ? MotionToast.info(
                          position: MOTION_TOAST_POSITION.top,
                          animationType: ANIMATION.fromTop,
                          description: "Light Theme",
                        ).show(context)
                      : MotionToast.info(
                          position: MOTION_TOAST_POSITION.top,
                          animationType: ANIMATION.fromTop,
                          description: "Dark Theme",
                        ).show(context);
                },
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 0,
                ),
                horizontalTitleGap: 5,
                leading: ref.watch(themeController)
                    ? Icon(
                        Icons.light_mode_sharp,
                        size: 30,
                        color: Colors.deepPurpleAccent[700],
                      )
                    : Icon(
                        Icons.dark_mode_sharp,
                        size: 30,
                        color: Colors.deepPurpleAccent[700],
                      ),
                title: ref.watch(themeController)
                    ? Text(
                        "Light Theme",
                        style: TextStyle(
                          color: textColor,
                          fontSize: 18,
                        ),
                      )
                    : Text(
                        "Dark Theme",
                        style: TextStyle(
                          color: textColor,
                          fontSize: 18,
                        ),
                      ),
              ),
              ListTile(
                onTap: () {
                  Token().removeToken();
                  HttpConnectUser.token = "";
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/login', (Route<dynamic> route) => false);
                },
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 7,
                  vertical: 0,
                ),
                horizontalTitleGap: 5,
                leading: Icon(
                  Icons.logout_sharp,
                  size: 30,
                  color: Colors.deepPurpleAccent[700],
                ),
                title: Text(
                  "Log Out",
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
