import 'package:assignment/screens/camera.dart';
import 'package:assignment/screens/home.dart';
import 'package:assignment/screens/login/forgot_password.dart';
import 'package:assignment/screens/login/login.dart';
import 'package:assignment/screens/login/reset_password.dart';
import 'package:assignment/screens/notification/notification_unseen.dart';
import 'package:assignment/screens/profile/profile_main.dart';
import 'package:assignment/screens/registration/address.dart';
import 'package:assignment/screens/registration/cover_pic.dart';
import 'package:assignment/screens/registration/personal_info.dart';
import 'package:assignment/screens/registration/profile_pic.dart';
import 'package:assignment/screens/registration/register_user.dart';
import 'package:assignment/screens/search.dart';
import 'package:assignment/screens/setting/setting_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

String token = "";
void main() {
  runApp(ProviderScope(child: WatchMe()));
}

class WatchMe extends StatefulWidget {
  const WatchMe({Key? key}) : super(key: key);

  @override
  _WatchMeState createState() => _WatchMeState();
}

class _WatchMeState extends State<WatchMe> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "Laila-Medium",
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginUser(),
        '/register-user': (context) => RegisterUser(),
        '/add-profile': (context) => AddProfilePicture(),
        '/add-cover': (context) => AddCoverPicture(),
        '/add-personal-information': (context) => PersonalInformation(),
        '/add-address': (context) => Address(),
        '/forgot-password': (context) => ForgotPassword(),
        '/reset-password': (context) => ResetPassword(),
        '/home': (context) => Home(),
        '/search': (context) => Search(),
        '/camera': (context) => Camera(),
        '/notification': (context) => NotificationUnseen(),
        '/profile': (context) => ProfileMain(),
        '/setting': (context) => Setting(),
      },
      title: "WatchMe Social Media App",
    );
  }
}
