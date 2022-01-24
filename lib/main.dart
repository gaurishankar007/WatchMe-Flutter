import 'package:assignment/screens/home.dart';
import 'package:assignment/screens/login/forgot_password.dart';
import 'package:assignment/screens/login/login.dart';
import 'package:assignment/screens/login/reset_password.dart';
import 'package:assignment/screens/registration/address.dart';
import 'package:assignment/screens/registration/cover_pic.dart';
import 'package:assignment/screens/registration/personal_info.dart';
import 'package:assignment/screens/registration/profile_pic.dart';
import 'package:assignment/screens/registration/register_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      initialRoute: '/Login',
      routes: {
        '/Login': (context) => LoginUser(),
        '/RegisterUser': (context) => RegisterUser(),
        '/AddProfile': (context) => AddProfilePicture(),
        '/AddCover': (context) => AddCoverPicture(),
        '/AddPersonalInformation': (context) => PersonalInformation(),
        '/AddAddress': (context) => Address(),
        '/ForgotPassword': (context) => ForgotPassword(),
        '/ResetPassword': (context) => ResetPassword(),
        '/Home': (context) => Home(),
      },
      title: "WatchMe Social Media App",
    );
  }
}
