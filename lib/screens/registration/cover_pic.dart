import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:motion_toast/motion_toast.dart';

class AddCoverPicture extends StatefulWidget {
  const AddCoverPicture({Key? key}) : super(key: key);

  @override
  _AddCoverPictureState createState() => _AddCoverPictureState();
}

class _AddCoverPictureState extends State<AddCoverPicture> {
  final _formKey = GlobalKey<FormState>();
  String coverPicture = "defaultCover.jpg";
  String coverPicturePath = "images/defaultCover.jpg";

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
                    "Add Cover Picture",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  (coverPicture == "defaultCover.jpg")
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image(
                            height: 150,
                            width: _screenWidth*.90,
                            fit: BoxFit.cover,
                            image: AssetImage(coverPicturePath),
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image(
                            height: 150,
                            width: _screenWidth*.90,
                            fit: BoxFit.cover,
                            image: FileImage(File(coverPicturePath)),
                          ),
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
                          // OpenFile.open(pickedProfile.path);
                          setState(() {
                            coverPicture = pickedProfile.name;
                            coverPicturePath = pickedProfile.path!;
                          });
                        },
                        child: Text("Select Cover Picture"),
                      ),
                      Text(
                        coverPicture,
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
                          Navigator.pushNamed(
                              context, "/AddPersonalInformation");
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
