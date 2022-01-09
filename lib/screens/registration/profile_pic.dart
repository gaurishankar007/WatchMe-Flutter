import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:motion_toast/motion_toast.dart';

class AddProfilePicture extends StatefulWidget {
  const AddProfilePicture({Key? key}) : super(key: key);

  @override
  _AddProfilePictureState createState() => _AddProfilePictureState();
}

class _AddProfilePictureState extends State<AddProfilePicture> {
  final _formKey = GlobalKey<FormState>();
  String profilePicture = "defaultProfile.png";
  String profilePicturePath = "images/defaultProfile.png";

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(_screenWidth * 0.10),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    "Add Profile Picture",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  (profilePicture == "defaultProfile.png")
                      ? CircleAvatar(
                          radius: 75,
                          backgroundImage: AssetImage(profilePicturePath),
                        )
                      : CircleAvatar(
                          radius: 75,
                          backgroundImage: FileImage(File(profilePicture)),
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
                            type: FileType.image,
                            // allowedExtensions: ['png', 'jpg'], // Error
                          );
                          if (picProfile == null) {
                            return;
                          }

                          final pickedProfile = picProfile.files.first;
                          // OpenFile.open(pickedProfile.path);
                          setState(() {
                            profilePicture = pickedProfile.name;
                            profilePicturePath = pickedProfile.path!;
                          });
                        },
                        child: Text("Select Profile Picture"),
                      ),
                      Text(
                        profilePicture,
                        textAlign: TextAlign.center,
                        style: TextStyle(),
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
                            fontSize: 15,
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
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
