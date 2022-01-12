import 'dart:io';

import 'package:assignment/screens/riverpod/theme.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motion_toast/motion_toast.dart';

class AddProfilePicture extends StatefulWidget {
  const AddProfilePicture({Key? key}) : super(key: key);

  @override
  _AddProfilePictureState createState() => _AddProfilePictureState();
}

class _AddProfilePictureState extends State<AddProfilePicture> {
  final themeController =
      StateNotifierProvider<ThemeNotifier, bool>((_) => ThemeNotifier());
  final _formKey = GlobalKey<FormState>();
  String profilePicture = "defaultProfile.png";
  String profilePicturePath = "images/defaultProfile.png";

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    return Consumer(builder: (context, ref, child) {
      return Scaffold(
        backgroundColor:
            ref.watch(themeController) ? Colors.black : Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: ref.watch(themeController) ? Colors.white : Colors.black,
          ),
          backgroundColor:
              ref.watch(themeController) ? Colors.black : Colors.white,
          title: Text(
            "WatchMe",
            style: TextStyle(
              color: ref.watch(themeController) ? Colors.white : Colors.black,
              fontSize: 35,
              fontWeight: FontWeight.bold,
              fontFamily: "Rochester-Regular",
            ),
          ),
          centerTitle: true,
          elevation: 2,
          shadowColor: ref.watch(themeController) ? Colors.white : Colors.black,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: _screenWidth * 0.03,
              left: _screenWidth * 0.10,
              right: _screenWidth * 0.10,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    "Add Profile Picture",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ref.watch(themeController)
                          ? Colors.white
                          : Colors.black,
                      fontSize: 25,
                      fontFamily: "Kalam-Bold",
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  (profilePicture == "defaultProfile.png")
                      ? CircleAvatar(
                          radius: 100,
                          backgroundImage: AssetImage(profilePicturePath),
                        )
                      : CircleAvatar(
                          radius: 100,
                          backgroundImage:
                              FileImage(File(profilePicturePath)),
                        ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          final picProfile =
                              await FilePicker.platform.pickFiles(
                            allowMultiple: false,
                            type: FileType.custom,
                            allowedExtensions: ['png', 'jpg'],
                          );
                          if (picProfile == null) {
                            return;
                          }

                          final pickedProfile = picProfile.files.first;
                          setState(() {
                            profilePicture = pickedProfile.name;
                            profilePicturePath = pickedProfile.path!;
                          });
                        },
                        child: Text(
                          "Select Profile Picture",
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: "Kalam-Bold",
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepPurpleAccent[700],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      Text(
                        profilePicture,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ref.watch(themeController)
                              ? Colors.white
                              : Colors.black,
                          fontSize: 15,
                          fontFamily: "Kalam-Regular",
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/AddCover");
                        },
                        child: Text(
                          "Skip",
                          style: TextStyle(
                            color: Colors.deepPurpleAccent[700],
                            fontSize: 20,
                            fontFamily: "Kalam-Bold",
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                          } else {
                            MotionToast.error(
                              title: "Submit Failed :(",
                              description: "",
                              toastDuration: Duration(seconds: 3),
                            ).show(context);
                          }
                        },
                        child: Text(
                          "Next",
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: "Kalam-Bold",
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepPurpleAccent[700],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ref.watch(themeController)
                          ? ref.read(themeController.notifier).lightTheme()
                          : ref.read(themeController.notifier).darkTheme();
                    },
                    child: ref.watch(themeController)
                        ? Text("Light Theme")
                        : Text("Dark Theme"),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
