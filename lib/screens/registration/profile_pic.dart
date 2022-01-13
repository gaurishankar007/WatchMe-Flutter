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
  String profilePicture = "defaultProfile.png";
  String profilePicturePath = "images/defaultProfile.png";

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
            "WatchMe",
            style: TextStyle(
              color: textColor,
              fontSize: 30,
              fontFamily: "BerkshireSwash-Regular",
            ),
          ),
          centerTitle: true,
          elevation: 2,
          shadowColor: textColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: _screenWidth * 0.03,
              left: _screenWidth * 0.10,
              right: _screenWidth * 0.10,
            ),
            child: Column(
              children: [
                Text(
                  "Add Profile Picture",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 25,
                    fontFamily: "Laila-Bold",
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
                        backgroundImage: FileImage(File(profilePicturePath)),
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
                        color:textColor,
                        fontSize: 15,
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
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                      },
                      child: Text(
                        "Next",
                        style: TextStyle(
                          fontSize: 15,
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
      );
    });
  }
}
