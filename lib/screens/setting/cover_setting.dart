import 'dart:io';
import 'package:assignment/api/http/http_user.dart';
import 'package:assignment/screens/riverpod/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

class CoverSetting extends StatefulWidget {
  const CoverSetting({Key? key}) : super(key: key);

  @override
  _CoverSettingState createState() => _CoverSettingState();
}

class _CoverSettingState extends State<CoverSetting> {
  final themeController =
      StateNotifierProvider<ThemeNotifier, bool>((_) => ThemeNotifier());
  File? coverPicture = null;
  String coverPictureName = "";
  String coverPictureUrl = 'http://10.0.2.2:4040/covers/';

  late Future<Map> getCover;

  @override
  void initState() {
    super.initState();
    getCover = HttpConnectUser().getUser();
  }

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
            "Cover Picture",
            style: TextStyle(
              color: textColor,
              fontSize: 20,
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
          child: FutureBuilder<Map>(
              future: getCover,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        (coverPicture == null)
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image(
                                  height: 150,
                                  width: _screenWidth * .90,
                                  fit: BoxFit.contain,
                                  image: NetworkImage(coverPictureUrl +
                                      snapshot.data!["userData"]["cover_pic"]),
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image(
                                  height: 150,
                                  width: _screenWidth * .90,
                                  fit: BoxFit.cover,
                                  image: FileImage(coverPicture!),
                                ),
                              ),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  backgroundColor: backColor,
                                  builder: (builder) => Container(
                                    padding: EdgeInsets.only(top: 5),
                                    decoration: BoxDecoration(
                                      color: backColor,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10.0),
                                        topRight: Radius.circular(10.0),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: textColor,
                                          spreadRadius: 1,
                                          blurRadius: 2,
                                          offset: Offset(0,
                                              1), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    height: 80,
                                    width: _screenWidth,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () async {
                                                final image =
                                                    await ImagePicker()
                                                        .pickImage(
                                                            source: ImageSource
                                                                .camera);
                                                setState(() {
                                                  coverPicture =
                                                      File(image!.path);
                                                  coverPictureName = image.path
                                                      .split("/")
                                                      .last;
                                                Navigator.pop(context);
                                                });
                                              },
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.camera,
                                                    size: 30,
                                                    color: backColor,
                                                  ),
                                                  SizedBox(
                                                    width: _screenWidth * .03,
                                                  ),
                                                  Text(
                                                    "Camera",
                                                    style: TextStyle(
                                                      color: backColor,
                                                      fontSize: 15,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 15,
                                                    vertical: 5),
                                                primary: Colors
                                                    .deepPurpleAccent[700],
                                                elevation: 5,
                                                shadowColor:
                                                    Colors.deepPurpleAccent,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              color:
                                                  Colors.deepPurpleAccent[700],
                                              height: 55,
                                              width: 4,
                                            ),
                                            ElevatedButton(
                                              onPressed: () async {
                                                final image =
                                                    await ImagePicker()
                                                        .pickImage(
                                                            source: ImageSource
                                                                .gallery);
                                                setState(() {
                                                  coverPicture =
                                                      File(image!.path);
                                                  coverPictureName = image.path
                                                      .split("/")
                                                      .last;
                                                });
                                                Navigator.pop(context);
                                              },
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.photo_album,
                                                    size: 30,
                                                    color: backColor,
                                                  ),
                                                  SizedBox(
                                                    width: _screenWidth * .03,
                                                  ),
                                                  Text(
                                                    "Gallery",
                                                    style: TextStyle(
                                                      color: backColor,
                                                      fontSize: 15,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 15,
                                                    vertical: 5),
                                                primary: Colors
                                                    .deepPurpleAccent[700],
                                                elevation: 5,
                                                shadowColor:
                                                    Colors.deepPurpleAccent,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          color: Colors.deepPurpleAccent[700],
                                          width: _screenWidth * .30,
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                "Select a cover picture",
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
                              coverPictureName,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: textColor,
                                fontSize: 15,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (coverPicture != null) {
                              final res = await HttpConnectUser()
                                  .addCover(coverPicture);
                              if (res["message"] ==
                                  "New cover picture added.") {
                                Navigator.pop(context);
                                MotionToast.success(
                                  position: MOTION_TOAST_POSITION.top,
                                  animationType: ANIMATION.fromTop,
                                  toastDuration: Duration(seconds: 2),
                                  description: res["message"],
                                ).show(context);
                              } else {
                                MotionToast.error(
                                  position: MOTION_TOAST_POSITION.top,
                                  animationType: ANIMATION.fromTop,
                                  toastDuration: Duration(seconds: 2),
                                  description: res["message"],
                                ).show(context);
                              }
                            } else {
                              MotionToast.error(
                                position: MOTION_TOAST_POSITION.top,
                                animationType: ANIMATION.fromTop,
                                toastDuration: Duration(seconds: 1),
                                description: "Select a cover picture first.",
                              ).show(context);
                            }
                          },
                          child: Text(
                            "Change Cover Picture",
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
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "${snapshot.error}",
                      style: TextStyle(
                        color: textColor,
                        fontSize: 15,
                      ),
                    ),
                  );
                }
                return CircularProgressIndicator();
              }),
        ),
      );
    });
  }
}
