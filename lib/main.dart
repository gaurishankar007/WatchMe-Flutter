import 'package:assignment/screens/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const WatchMe());
}

class WatchMe extends StatefulWidget {
  const WatchMe({ Key? key }) : super(key: key);

  @override
  _WatchMeState createState() => _WatchMeState();
}

class _WatchMeState extends State<WatchMe> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // initialRoute: '/',
      // routes: {
      //   '': ,
      //   '': ,
      // },
      title: "WatchMe Social Media App",
      home: Home()      
    );
  }
}