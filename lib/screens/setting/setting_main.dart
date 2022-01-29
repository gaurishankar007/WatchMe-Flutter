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
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Token().removeToken();
                HttpConnectUser.token = "";
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/login', (Route<dynamic> route) => false);
              },
              child: Text("Log Out"),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
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
                            description:
                                "Light theme applied. Restart the application to apply the theme properly.")
                        .show(context)
                    : MotionToast.info(
                            position: MOTION_TOAST_POSITION.top,
                            animationType: ANIMATION.fromTop,
                            description:
                                "Dark theme applied. Restart the application to apply the theme properly.")
                        .show(context);
              },
              child: ref.watch(themeController)
                  ? Text("Light Theme")
                  : Text("Dark Theme"),
            ),
          ],
        ),
      );
    });
  }
}
