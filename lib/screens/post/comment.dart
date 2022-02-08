import 'package:assignment/api/http/http_comment.dart';
import 'package:assignment/api/http/http_user.dart';
import 'package:assignment/screens/profile/profile_main_other.dart';
import 'package:assignment/screens/riverpod/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Commenters extends StatefulWidget {
  final String? post_id;
  final int? activeNav;
  const Commenters({Key? key, @required this.post_id, @required this.activeNav})
      : super(key: key);

  @override
  _CommentersState createState() => _CommentersState();
}

class _CommentersState extends State<Commenters> {
  final themeController =
      StateNotifierProvider<ThemeNotifier, bool>((_) => ThemeNotifier());
  int activeNav = 4;
  String profilePicUrl = "http://10.0.2.2:4040/profiles/";

  late Future<List> postCommenters;
  String? myId;

  @override
  void initState() {
    super.initState();
    postCommenters = HttpConnectComment().getComments(widget.post_id);
    HttpConnectUser()
        .getUser()
        .then((value) => myId = value["userData"]["_id"]);
    activeNav = widget.activeNav!;
  }

  @override
  Widget build(BuildContext context) {
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
            "Commenters",
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
          future: postCommenters,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) => ListTile(
                  horizontalTitleGap: 15,
                  minVerticalPadding: 20,
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(profilePicUrl +
                        snapshot.data![index]["user_id"]["profile_pic"]),
                  ),
                  title: Text(
                    snapshot.data![index]["user_id"]["username"],
                    style: TextStyle(
                        fontSize: 20,
                        color: textColor,
                        fontFamily: "Laila-bold"),
                  ),
                  subtitle: Text(
                    snapshot.data![index]["comment"],
                    style: TextStyle(
                        fontSize: 15,
                        color: textColor,
                        fontFamily: "Laila-Regulor"),
                  ),
                  trailing: myId != snapshot.data![index]["user_id"]["_id"]
                      ? ElevatedButton(
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (builder) => ProfileMainOther(
                                  user_id: snapshot.data![index]["user_id"]
                                      ["_id"],
                                ),
                              ),
                            );
                          },
                          child: Text(
                            "View Profile",
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
                "No one has liked this post yet.",
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
              if (navIndex == 0) {
                Navigator.pushNamed(context, "/home");
              } else if (navIndex == 1) {
                Navigator.pushNamed(context, "/search");
              } else if (navIndex == 2) {
                Navigator.pushNamed(context, "/camera");
              } else if (navIndex == 3) {
                Navigator.pushNamed(context, "/notification");
              } else if (navIndex == 4) {
                Navigator.pushNamed(context, "/profile");
              }
            },
          ),
        ),
      );
    });
  }
}
