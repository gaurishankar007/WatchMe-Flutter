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
    final _screenWidth = MediaQuery.of(context).size.width;
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
              fontFamily: "BerkshireSwash-Regular",
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
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                onPressed: () {},
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 0,
                  ),
                  horizontalTitleGap: 5,
                  leading: Icon(
                    Icons.face_retouching_natural_sharp,
                    size: 30,
                    color: textColor,
                  ),
                  title: Text(
                    "Profile Picture",
                    style: TextStyle(
                      color: textColor,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),          
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                onPressed: () {},
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 0,
                  ),
                  horizontalTitleGap: 5,
                  leading: Icon(
                    Icons.picture_in_picture_sharp,
                    size: 30,
                    color: textColor,
                  ),
                  title: Text(
                    "Cover Picture",
                    style: TextStyle(
                      color: textColor,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),           
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                onPressed: () {},
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 0,
                  ),
                  horizontalTitleGap: 5,
                  leading: Icon(
                    Icons.vpn_key_sharp,
                    size: 30,
                    color: textColor,
                  ),
                  title: Text(
                    "Password",
                    style: TextStyle(
                      color: textColor,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                onPressed: () {},
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 0,
                  ),
                  horizontalTitleGap: 5,
                  leading: Icon(
                    Icons.person,
                    size: 30,
                    color: textColor,
                  ),
                  title: Text(
                    "User information",
                    style: TextStyle(
                      color: textColor,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                onPressed: () {},
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 0,
                  ),
                  horizontalTitleGap: 5,
                  leading: Icon(
                    Icons.person_pin_rounded,
                    size: 30,
                    color: textColor,
                  ),
                  title: Text(
                    "Personal information",
                    style: TextStyle(
                      color: textColor,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                onPressed: () {},
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 0,
                  ),
                  horizontalTitleGap: 5,
                  leading: Icon(
                    Icons.person_pin_circle_sharp,
                    size: 30,
                    color: textColor,
                  ),
                  title: Text(
                    "Address information",
                    style: TextStyle(
                      color: textColor,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                onPressed: () {
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
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 0,
                  ),
                  horizontalTitleGap: 5,
                  leading: ref.watch(themeController)
                      ? Icon(
                          Icons.light_mode_sharp,
                          size: 30,
                          color: textColor,
                        )
                      : Icon(
                          Icons.dark_mode_sharp,
                          size: 30,
                          color: textColor,
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
              ),
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                onPressed: () {
                  Token().removeToken();
                  HttpConnectUser.token = "";
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/login', (Route<dynamic> route) => false);
                },
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 0,
                  ),
                  horizontalTitleGap: 5,
                  leading: Icon(
                    Icons.logout_sharp,
                    size: 30,
                    color: textColor,
                  ),
                  title: Text(
                    "Log Out",
                    style: TextStyle(
                      color: textColor,
                      fontSize: 18,
                    ),
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
