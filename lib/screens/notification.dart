import 'package:assignment/api/http/http_notification.dart';
import 'package:assignment/api/http/http_user.dart';
import 'package:assignment/screens/post/post_view.dart';
import 'package:assignment/screens/profile/profile_main_other.dart';
import 'package:assignment/screens/riverpod/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

import '../api/base_urls.dart';

class NotificationUnseen extends StatefulWidget {
  const NotificationUnseen({Key? key}) : super(key: key);

  @override
  _NotificationUnseenState createState() => _NotificationUnseenState();
}

class _NotificationUnseenState extends State<NotificationUnseen> {
  final themeController =
      StateNotifierProvider<ThemeNotifier, bool>((_) => ThemeNotifier());
  int activeNav = 3;
  String profileUrl = BaseUrl.profilePicUrl;

  late Future<List> notifications;
  late Future<Map> getUser;
  String unSeenNum = '0';
  String seenNum = '0';
  bool unSeen = true;

  @override
  void initState() {
    super.initState();
    notifications = HttpConnectNotification().getUnSeen();
    getUser = HttpConnectUser().getUser();
    HttpConnectNotification().getNotificationNum().then((res) {
      setState(() {
        unSeenNum = res["unSeenNum"];
        seenNum = res["seenNum"];
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
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: _screenWidth * .05,
            ),
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              unSeen = true;
                              notifications =
                                  HttpConnectNotification().getUnSeen();
                            });
                          },
                          child: Text(
                            "Unseen",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.deepPurpleAccent[700],
                            elevation: unSeen ? 25 : 0,
                            shadowColor: Colors.deepPurpleAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        Text(
                          unSeen ? unSeenNum : seenNum,
                          style: TextStyle(
                            color: textColor,
                            fontSize: 25,
                            fontFamily: "Laila-Bold",
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              unSeen = false;
                              notifications =
                                  HttpConnectNotification().getSeen();
                            });
                          },
                          child: Text(
                            "Seen",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.deepPurpleAccent[700],
                            elevation: !unSeen ? 25 : 0,
                            shadowColor: Colors.deepPurpleAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                    unSeen
                        ? unSeenNum != "0"
                            ? TextButton(
                                onPressed: () async {
                                  await HttpConnectNotification().seenUnSeen();
                                  setState(() {
                                    notifications =
                                        HttpConnectNotification().getUnSeen();
                                  });
                                  HttpConnectNotification()
                                      .getNotificationNum()
                                      .then((res) {
                                    setState(() {
                                      unSeenNum = res["unSeenNum"];
                                      seenNum = res["seenNum"];
                                    });
                                  });
                                },
                                child: Text(
                                  "Mark as seen",
                                  style: TextStyle(
                                    color: Colors.deepPurpleAccent[700],
                                    fontSize: 15,
                                  ),
                                ),
                              )
                            : SizedBox(
                                height: 5,
                              )
                        : seenNum != "0"
                            ? TextButton(
                                onPressed: () async {
                                  await HttpConnectNotification().deleteSeen();
                                  setState(() {
                                    notifications =
                                        HttpConnectNotification().getSeen();
                                  });
                                  HttpConnectNotification()
                                      .getNotificationNum()
                                      .then((res) {
                                    setState(() {
                                      unSeenNum = res["unSeenNum"];
                                      seenNum = res["seenNum"];
                                    });
                                  });
                                },
                                child: Text(
                                  "Delete all",
                                  style: TextStyle(
                                    color: Colors.deepPurpleAccent[700],
                                    fontSize: 15,
                                  ),
                                ),
                              )
                            : SizedBox(
                                height: 5,
                              ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 600,
                      child: FutureBuilder<List>(
                        future: notifications,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) => ListTile(
                                horizontalTitleGap: 15,
                                minVerticalPadding: 10,
                                leading: CircleAvatar(
                                  radius: 25,
                                  backgroundImage: NetworkImage(profileUrl +
                                      snapshot.data![index]
                                              ["notification_generator"]
                                          ["profile_pic"]),
                                ),
                                title: Text(
                                  snapshot.data![index]["notification_for"],
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: textColor,
                                      fontFamily: "Laila-bold"),
                                ),
                                subtitle: Text(
                                  snapshot.data![index]["notification"],
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: textColor,
                                  ),
                                ),
                                trailing: unSeen
                                    ? IconButton(
                                        padding: EdgeInsets.zero,
                                        constraints: BoxConstraints(),
                                        onPressed: () {
                                          if (snapshot.data![index]
                                                  ["notification_for"] ==
                                              "Follow") {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (builder) =>
                                                    ProfileMainOther(
                                                        user_id: snapshot.data![
                                                                    index][
                                                                "notification_generator"]
                                                            ["_id"]),
                                              ),
                                            );
                                          } else {
                                            if (snapshot.data![index]
                                                    ["target_post"] !=
                                                null) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (builder) => PostView(
                                                      post_id: snapshot
                                                                  .data![index]
                                                              ["target_post"]
                                                          ["_id"],
                                                      activeNav: 3),
                                                ),
                                              );
                                            } else {
                                              MotionToast.error(
                                                position:
                                                    MOTION_TOAST_POSITION.top,
                                                animationType:
                                                    ANIMATION.fromTop,
                                                toastDuration:
                                                    Duration(seconds: 2),
                                                description:
                                                    "The post is no more available.",
                                              ).show(context);
                                            }
                                          }
                                        },
                                        icon: Icon(
                                          Icons.remove_red_eye_sharp,
                                          color: Colors.deepPurpleAccent[700],
                                        ),
                                      )
                                    : SizedBox(
                                        height: 0,
                                      ),
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
                          return Center(
                            child: Text(
                              "Search users by their username or email address or by their profile first_name or last_name.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: textColor,
                                fontSize: 20,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
                  radius: 18,
                  backgroundColor: (activeNav == 4)
                      ? Colors.deepPurpleAccent[700]
                      : textColor,
                  child: FutureBuilder<Map>(
                      future: getUser,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return CircleAvatar(
                            radius: 16,
                            backgroundImage: NetworkImage(profileUrl +
                                snapshot.data!["userData"]["profile_pic"]),
                          );
                        }
                        return CircleAvatar(
                          radius: 16,
                        );
                      }),
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
