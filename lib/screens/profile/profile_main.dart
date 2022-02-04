import 'package:assignment/api/http/http_address.dart';
import 'package:assignment/api/http/http_post.dart';
import 'package:assignment/api/http/http_profile.dart';
import 'package:assignment/api/http/http_user.dart';
import 'package:assignment/api/http/http_watch.dart';
import 'package:assignment/screens/riverpod/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileMain extends StatefulWidget {
  const ProfileMain({Key? key}) : super(key: key);

  @override
  _ProfileMainState createState() => _ProfileMainState();
}

class _ProfileMainState extends State<ProfileMain> {
  final themeController =
      StateNotifierProvider<ThemeNotifier, bool>((_) => ThemeNotifier());
  int activeNav = 4;
  String profileUrl = "http://10.0.2.2:4040/profiles/";
  String coverUrl = "http://10.0.2.2:4040/covers/";
  String postUrl = "http://10.0.2.2:4040/posts/";

  late Future<Map> getUser;
  late Future<Map> userProfile;
  late Future<Map> userAdddress;
  late Future<List> userPosts;
  late Future<List> userTaggedPosts;

  String watchersNum = "0";
  String watchingsNum = "0";

  Future setWatchersWatchingNum() async {
    final res = await HttpConnectWatch().getWatcheNum();
    setState(() {
      watchersNum = res["followers"];
      watchingsNum = res["followed_users"];
    });
  }

  @override
  void initState() {
    super.initState();
    getUser = HttpConnectUser().getUser();
    setWatchersWatchingNum();
    userProfile = HttpConnectProfile().getPersonalInfo();
    userAdddress = HttpConnectAddress().getAddressInfo();
    userPosts = HttpConnectPost().getPosts();
    userTaggedPosts = HttpConnectPost().getTaggedPosts();
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
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: _screenWidth * .025,
              vertical: _screenWidth * .025,
            ),
            child: Column(
              children: [
                FutureBuilder<Map>(
                  future: getUser,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              CircleAvatar(
                                radius: 80,
                                backgroundColor: Colors.deepPurpleAccent[700],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {},
                                    onLongPress: () {
                                      Navigator.pop(context);
                                      Navigator.pushNamed(context, "/watchers");
                                    },
                                    child: Column(
                                      children: [
                                        Text(
                                          watchersNum.toString(),
                                          style: TextStyle(
                                            color: textColor,
                                            fontSize: 25,
                                            fontFamily: "Laila-Bold",
                                          ),
                                        ),
                                        Text(
                                          "Waterchs",
                                          style: TextStyle(
                                            color: textColor,
                                            fontSize: 15,
                                            fontFamily: "Laila-Bold",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    onLongPress: () {
                                      Navigator.pop(context);
                                      Navigator.pushNamed(
                                          context, "/watchings");
                                    },
                                    child: Column(
                                      children: [
                                        Text(
                                          watchingsNum.toString(),
                                          style: TextStyle(
                                            color: textColor,
                                            fontSize: 25,
                                            fontFamily: "Laila-Bold",
                                          ),
                                        ),
                                        Text(
                                          "Watchings",
                                          style: TextStyle(
                                            color: textColor,
                                            fontSize: 15,
                                            fontFamily: "Laila-Bold",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                  bottom: 80,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image(
                                    width: _screenWidth * .95,
                                    fit: BoxFit.contain,
                                    image: NetworkImage(
                                      coverUrl +
                                          snapshot.data!["userData"]
                                              ["cover_pic"],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                  bottom: 5,
                                ),
                                child: CircleAvatar(
                                  radius: 75,
                                  backgroundImage: NetworkImage(
                                    profileUrl +
                                        snapshot.data!["userData"]
                                            ["profile_pic"],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            snapshot.data!["userData"]["username"],
                            style: TextStyle(
                              color: textColor,
                              fontSize: 20,
                              fontFamily: "Laila-Bold",
                            ),
                          ),
                        ],
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
                    return CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.deepPurpleAccent[700],
                    );
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {},
                      onLongPress: () {
                        showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (builder) => SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.only(
                                top: 10,
                                left: _screenWidth * .05,
                                right: 5,
                              ),
                              decoration: BoxDecoration(
                                color: backColor,
                                borderRadius: new BorderRadius.only(
                                  topLeft: const Radius.circular(25.0),
                                  topRight: const Radius.circular(25.0),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: textColor,
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: Offset(
                                        0, 1), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.deepPurpleAccent[700],
                                    ),
                                    height: 5,
                                    width: _screenWidth * .20,
                                  ),
                                  Container(
                                    height: 300,
                                    child: FutureBuilder<Map>(
                                      future: userProfile,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Column(
                                            children: [
                                              ListTile(
                                                leading: Text(
                                                  "First Name: ",
                                                  style: TextStyle(
                                                    color: textColor,
                                                    fontSize: 15,
                                                    fontFamily: "Laila-Bold",
                                                  ),
                                                ),
                                                title: Text(
                                                  snapshot.data!["userProfile"]
                                                      ["first_name"],
                                                  style: TextStyle(
                                                    color: textColor,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                              ListTile(
                                                leading: Text(
                                                  "Last Name: ",
                                                  style: TextStyle(
                                                    color: textColor,
                                                    fontSize: 15,
                                                    fontFamily: "Laila-Bold",
                                                  ),
                                                ),
                                                title: Text(
                                                  snapshot.data!["userProfile"]
                                                      ["last_name"],
                                                  style: TextStyle(
                                                    color: textColor,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                              ListTile(
                                                leading: Text(
                                                  "Gender: ",
                                                  style: TextStyle(
                                                    color: textColor,
                                                    fontSize: 15,
                                                    fontFamily: "Laila-Bold",
                                                  ),
                                                ),
                                                title: Text(
                                                  snapshot.data!["userProfile"]
                                                      ["gender"],
                                                  style: TextStyle(
                                                    color: textColor,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                              ListTile(
                                                leading: Text(
                                                  "Birthday: ",
                                                  style: TextStyle(
                                                    color: textColor,
                                                    fontSize: 15,
                                                    fontFamily: "Laila-Bold",
                                                  ),
                                                ),
                                                title: Text(
                                                  snapshot.data!["userProfile"]
                                                      ["birthday"],
                                                  style: TextStyle(
                                                    color: textColor,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                              ListTile(
                                                leading: Text(
                                                  "Biography: ",
                                                  style: TextStyle(
                                                    color: textColor,
                                                    fontSize: 15,
                                                    fontFamily: "Laila-Bold",
                                                  ),
                                                ),
                                                title: Text(
                                                  snapshot.data!["userProfile"]
                                                      ["biography"],
                                                  style: TextStyle(
                                                    color: textColor,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                            ],
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
                                        return const CircularProgressIndicator(
                                          color: Colors.deepPurple,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      label: Text(
                        "Profile",
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
                    ElevatedButton.icon(
                      onPressed: () {
                        showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (builder) => SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.only(
                                top: 10,
                                left: _screenWidth * .05,
                                right: 5,
                              ),
                              height: 350,
                              decoration: BoxDecoration(
                                color: backColor,
                                borderRadius: new BorderRadius.only(
                                  topLeft: const Radius.circular(25.0),
                                  topRight: const Radius.circular(25.0),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: textColor,
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: Offset(
                                        0, 1), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.deepPurpleAccent[700],
                                    ),
                                    height: 5,
                                    width: _screenWidth * .20,
                                  ),
                                  Container(
                                    child: FutureBuilder<Map>(
                                      future: userAdddress,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Column(
                                            children: [
                                              Text(
                                                "Permanent",
                                                style: TextStyle(
                                                  color: textColor,
                                                  fontSize: 20,
                                                  decoration:
                                                      TextDecoration.underline,
                                                  fontFamily: "Laila-Bold",
                                                ),
                                              ),
                                              ListTile(
                                                leading: Text(
                                                  "Country: ",
                                                  style: TextStyle(
                                                    color: textColor,
                                                    fontSize: 15,
                                                    fontFamily: "Laila-Bold",
                                                  ),
                                                ),
                                                title: Text(
                                                  snapshot.data!["userAddress"]
                                                      ["permanent"]["country"],
                                                  style: TextStyle(
                                                    color: textColor,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                              ListTile(
                                                leading: Text(
                                                  "State: ",
                                                  style: TextStyle(
                                                    color: textColor,
                                                    fontSize: 15,
                                                    fontFamily: "Laila-Bold",
                                                  ),
                                                ),
                                                title: Text(
                                                  snapshot.data!["userAddress"]
                                                      ["permanent"]["state"],
                                                  style: TextStyle(
                                                    color: textColor,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                              ListTile(
                                                leading: Text(
                                                  "City: ",
                                                  style: TextStyle(
                                                    color: textColor,
                                                    fontSize: 15,
                                                    fontFamily: "Laila-Bold",
                                                  ),
                                                ),
                                                title: Text(
                                                  snapshot.data!["userAddress"]
                                                      ["permanent"]["city"],
                                                  style: TextStyle(
                                                    color: textColor,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                              ListTile(
                                                leading: Text(
                                                  "Street: ",
                                                  style: TextStyle(
                                                    color: textColor,
                                                    fontSize: 15,
                                                    fontFamily: "Laila-Bold",
                                                  ),
                                                ),
                                                title: Text(
                                                  snapshot.data!["userAddress"]
                                                      ["permanent"]["street"],
                                                  style: TextStyle(
                                                    color: textColor,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                "Temporary",
                                                style: TextStyle(
                                                  color: textColor,
                                                  fontSize: 20,
                                                  decoration:
                                                      TextDecoration.underline,
                                                  fontFamily: "Laila-Bold",
                                                ),
                                              ),
                                              ListTile(
                                                leading: Text(
                                                  "Country: ",
                                                  style: TextStyle(
                                                    color: textColor,
                                                    fontSize: 15,
                                                    fontFamily: "Laila-Bold",
                                                  ),
                                                ),
                                                title: Text(
                                                  snapshot.data!["userAddress"]
                                                      ["temporary"]["country"],
                                                  style: TextStyle(
                                                    color: textColor,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                              ListTile(
                                                leading: Text(
                                                  "State: ",
                                                  style: TextStyle(
                                                    color: textColor,
                                                    fontSize: 15,
                                                    fontFamily: "Laila-Bold",
                                                  ),
                                                ),
                                                title: Text(
                                                  snapshot.data!["userAddress"]
                                                      ["temporary"]["state"],
                                                  style: TextStyle(
                                                    color: textColor,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                              ListTile(
                                                leading: Text(
                                                  "City: ",
                                                  style: TextStyle(
                                                    color: textColor,
                                                    fontSize: 15,
                                                    fontFamily: "Laila-Bold",
                                                  ),
                                                ),
                                                title: Text(
                                                  snapshot.data!["userAddress"]
                                                      ["temporary"]["city"],
                                                  style: TextStyle(
                                                    color: textColor,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                              ListTile(
                                                leading: Text(
                                                  "Street: ",
                                                  style: TextStyle(
                                                    color: textColor,
                                                    fontSize: 15,
                                                    fontFamily: "Laila-Bold",
                                                  ),
                                                ),
                                                title: Text(
                                                  snapshot.data!["userAddress"]
                                                      ["temporary"]["street"],
                                                  style: TextStyle(
                                                    color: textColor,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                            ],
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
                                        return const CircularProgressIndicator(
                                          color: Colors.deepPurple,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.location_on_sharp,
                        color: Colors.white,
                      ),
                      label: Text(
                        "Address",
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
                )
              ],
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

  Widget watch(Future<List> users) {
    return Container();
  }
}
