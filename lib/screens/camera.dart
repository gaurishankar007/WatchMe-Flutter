import 'dart:io';

import 'package:assignment/api/http/http_user.dart';
import 'package:assignment/screens/riverpod/theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Camera extends StatefulWidget {
  const Camera({Key? key}) : super(key: key);

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  final themeController =
      StateNotifierProvider<ThemeNotifier, bool>((_) => ThemeNotifier());
  int activeNav = 2;

  List<File> posts = [];
  int activatedIndex = 0;
  String caption = "", description = "";

  void fromCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      posts.add(File(image!.path));
    });
  }

  void fromGallery() async {
    final images = await ImagePicker().pickMultiImage();
    if (images!.length > 12) {
      return MotionToast.error(
        position: MOTION_TOAST_POSITION.top,
        animationType: ANIMATION.fromTop,
        toastDuration: Duration(seconds: 2),
        description: "A post can have up to 12 images only.",
      ).show(context);
    }
    setState(() {
      images.forEach((singleImage) {
        posts.add(File(singleImage.path));
      });
    });
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
        body: SafeArea(
          child: posts.isEmpty
              ? Center(
                  child: CircleAvatar(
                    radius: _screenWidth * .5,
                    backgroundColor: Colors.deepPurpleAccent[700],
                    child: CircleAvatar(
                      radius: _screenWidth * .45,
                      backgroundColor: backColor,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    fromCamera();
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.camera,
                                        size: 35,
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
                                        horizontal: 20, vertical: 8),
                                    primary: Colors.deepPurpleAccent[700],
                                    elevation: 5,
                                    shadowColor: Colors.deepPurpleAccent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.deepPurpleAccent[700],
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.deepPurpleAccent,
                                        spreadRadius: 1,
                                        blurRadius: 20,
                                        offset: Offset(1, 1),
                                      ),
                                    ],
                                  ),
                                  height: 100,
                                  width: 20,
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    fromGallery();
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.photo_album,
                                        size: 35,
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
                                        horizontal: 20, vertical: 8),
                                    primary: Colors.deepPurpleAccent[700],
                                    elevation: 5,
                                    shadowColor: Colors.deepPurpleAccent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.deepPurpleAccent[700],
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.deepPurpleAccent,
                                    spreadRadius: 1,
                                    blurRadius: 20,
                                    offset: Offset(1, 1),
                                  ),
                                ],
                              ),
                              width: _screenWidth * .5,
                              height: 50,
                              child: Center(
                                  child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: backColor,
                                ),
                                height: 20,
                                width: _screenWidth * .4,
                              )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : Column(
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    CarouselSlider(
                      items: posts.map((i) {
                        return Builder(builder: (BuildContext context) {
                          return Image(
                            image: FileImage(i),
                            fit: BoxFit.contain,
                          );
                        });
                      }).toList(),
                      options: CarouselOptions(
                        initialPage: 0, // shows the first image
                        viewportFraction: 1, // shows one image at a time
                        height: 250,
                        enableInfiniteScroll:
                            false, // makes carousel scrolling only from first image to last image, disables loop scrolling
                        onPageChanged: ((indexCar, reason) {
                          setState(() {
                            activatedIndex = indexCar;
                          });
                        }),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    AnimatedSmoothIndicator(
                      activeIndex: activatedIndex,
                      count: posts.length,
                      effect: WormEffect(
                        dotColor: textColor,
                        activeDotColor: Colors.deepPurpleAccent,
                        dotHeight: 9,
                        dotWidth: 9,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: _screenWidth * .05,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            onSaved: (value) {
                              caption = value!.trim();
                            },
                            textCapitalization: TextCapitalization.words,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: "Caption is requied.")
                            ]),
                            style: TextStyle(
                              color: textColor,
                            ),
                            decoration: InputDecoration(
                              labelText: "Caption",
                              labelStyle: TextStyle(
                                color: textColor,
                                fontFamily: "Laila-Bold",
                              ),
                              hintText: "Enter post's caption.....",
                              hintStyle: TextStyle(
                                color: textColor,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  width: 2,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: textColor,
                                  width: 2,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: textColor,
                                  width: 2,
                                  style: BorderStyle.solid,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            maxLines: 3,
                            onSaved: (value) {
                              description = value!.trim();
                            },
                            keyboardType: TextInputType.multiline,
                            textCapitalization: TextCapitalization.sentences,
                            style: TextStyle(
                              color: textColor,
                            ),
                            decoration: InputDecoration(
                              labelText: "Description",
                              labelStyle: TextStyle(
                                color: textColor,
                                fontFamily: "Laila-Bold",
                              ),
                              hintText: "Enter post's description.....",
                              hintStyle: TextStyle(
                                color: textColor,
                              ),
                              helperText: "Optional",
                              helperStyle: TextStyle(
                                color: textColor,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  width: 2,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: textColor,
                                  width: 2,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: textColor,
                                  width: 2,
                                  style: BorderStyle.solid,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pushNamed(context, "/camera");
                                },
                                child: Text(
                                  "Cancel",
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
                                onPressed: () async {
                                  if (5 == 4) {
                                    final res = await HttpConnectUser()
                                        .addProfile(File("skdjlk"));
                                    if (res["message"] ==
                                        "New profile picture added.") {
                                      Navigator.pushNamed(
                                          context, "/add-cover");
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
                                      description:
                                          "Select a profile picture first.",
                                    ).show(context);
                                  }
                                },
                                child: Text(
                                  "Post",
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
                  ],
                ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: textColor,
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.camera),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: CircleAvatar(
                  radius: 16,
                  backgroundColor: (activeNav == 4)
                      ? Colors.deepPurpleAccent[700]
                      : textColor,
                  child: CircleAvatar(
                    radius: 14,
                    backgroundImage: AssetImage("images/defaultProfile.png"),
                  ),
                ),
                label: "",
              ),
            ],
            currentIndex: activeNav,
            type: BottomNavigationBarType.fixed,
            selectedFontSize: 0,
            unselectedFontSize: 0,
            backgroundColor: backColor,
            iconSize: 35,
            selectedItemColor: Colors.deepPurpleAccent[700],
            unselectedItemColor: textColor,
            onTap: (int navIndex) {
              if (navIndex == 0 && activeNav != navIndex) {
                Navigator.pushNamed(context, "/home");
              } else if (navIndex == 1 && activeNav != navIndex) {
                Navigator.pushNamed(context, "/search");
              } else if (navIndex == 2 && activeNav != navIndex) {
                Navigator.pushNamed(context, "/camera");
              } else if (navIndex == 3 && activeNav != navIndex) {
                Navigator.pushNamed(context, "/notification");
              } else if (navIndex == 4 && activeNav != navIndex) {
                Navigator.pushNamed(context, "/profile");
              }
            },
          ),
        ),
      );
    });
  }
}
