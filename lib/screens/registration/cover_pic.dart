import 'dart:io';
import 'package:assignment/screens/riverpod/theme.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motion_toast/motion_toast.dart';

class AddCoverPicture extends StatefulWidget {
  const AddCoverPicture({Key? key}) : super(key: key);

  @override
  _AddCoverPictureState createState() => _AddCoverPictureState();
}

class _AddCoverPictureState extends State<AddCoverPicture> {
  final themeController =
      StateNotifierProvider<ThemeNotifier, bool>((_) => ThemeNotifier());
  final _formKey = GlobalKey<FormState>();
  String coverPicture = "defaultCover.jpg";
  String coverPicturePath = "images/defaultCover.jpg";

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    return Consumer(builder: (context, ref, child) {
      return Scaffold(
        backgroundColor:
            ref.watch(themeController) ? Colors.black : Colors.white,
        appBar: AppBar(
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
                        color: ref.watch(themeController)
                            ? Colors.white
                            : Colors.black,
                        fontSize: 30,
                        fontFamily: "Kalam-Bold",
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    (coverPicture == "defaultCover.jpg")
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image(
                              height: 150,
                              width: _screenWidth * .90,
                              fit: BoxFit.cover,
                              image: AssetImage(coverPicturePath),
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image(
                              height: 150,
                              width: _screenWidth * .90,
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
                          child: Text(
                            "Select Cover Picture",
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
                          coverPicture,
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
                            Navigator.pushNamed(
                                context, "/AddPersonalInformation");
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
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
