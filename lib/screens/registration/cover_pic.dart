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
  String coverPicture = "defaultCover.jpg";
  String coverPicturePath = "images/defaultCover.jpg";

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
          shape: Border(
            bottom: BorderSide(
              color: textColor,
              width: .1,
            ),
          ),
          elevation: 0,
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
                  "Add Cover Picture",
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
                        final picProfile = await FilePicker.platform.pickFiles(
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
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurpleAccent[700],
                        elevation: 10,
                        shadowColor: Colors.deepPurpleAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    Text(
                      coverPicture,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: textColor,
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
                        Navigator.pushNamed(context, "/AddPersonalInformation");
                      },
                      child: Text(
                        "Skip",
                        style: TextStyle(
                          color: Colors.deepPurpleAccent[700],
                          fontSize: 20,
                          shadows: const [
                            Shadow(
                              color: Colors.deepPurpleAccent,
                              offset: Offset(3, 4),
                              blurRadius: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "Next",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurpleAccent[700],
                        elevation: 10,
                        shadowColor: Colors.deepPurpleAccent,
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
      );
    });
  }
}
