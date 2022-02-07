import 'package:assignment/api/http/http_watch.dart';
import 'package:assignment/screens/profile/profile_main_other.dart';
import 'package:assignment/screens/riverpod/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Watching extends StatefulWidget {
  const Watching({Key? key}) : super(key: key);

  @override
  _WatchingState createState() => _WatchingState();
}

class _WatchingState extends State<Watching> {
  final themeController =
      StateNotifierProvider<ThemeNotifier, bool>((_) => ThemeNotifier());
  int activeNav = 4;
  String profileUrl = "http://10.0.2.2:4040/profiles/";

  late Future<List> userWatchings;

  @override
  void initState() {
    super.initState();
    userWatchings = HttpConnectWatch().getWatchings();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
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
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "/profile");
              },
              icon: Icon(
                Icons.arrow_back,
                color: textColor,
              ),
            ),
            backgroundColor: backColor,
            title: Text(
              "Watchings",
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
          body: FutureBuilder<List>(
            future: userWatchings,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) => ListTile(
                    onLongPress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (builder) => ProfileMainOther(
                            user_id: snapshot.data![index]["followed_user"]
                                ["_id"],
                          ),
                        ),
                      );
                    },
                    horizontalTitleGap: 15,
                    minVerticalPadding: 20,
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(profileUrl +
                          snapshot.data![index]["followed_user"]
                              ["profile_pic"]),
                    ),
                    title: Text(
                      snapshot.data![index]["followed_user"]["username"],
                      style: TextStyle(
                          fontSize: 20,
                          color: textColor,
                          fontFamily: "Laila-bold"),
                    ),
                    subtitle: Text(
                      snapshot.data![index]["followed_user"]["email"],
                      style: TextStyle(
                        fontSize: 15,
                        color: textColor,
                      ),
                    ),
                    trailing: ElevatedButton(
                      onPressed: () async {
                        await HttpConnectWatch().unWatch(
                            snapshot.data![index]["followed_user"]["_id"]);

                        setState(() {
                          userWatchings = HttpConnectWatch().getWatchings();
                        });
                      },
                      child: Text(
                        "UnWatch",
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
                  "You have not watched anybody yet.",
                  style: TextStyle(
                    color: textColor,
                    fontSize: 15,
                  ),
                ),
              );
            },
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
      },
    );
  }
}
