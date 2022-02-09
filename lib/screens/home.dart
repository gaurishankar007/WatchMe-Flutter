import 'package:assignment/api/http/http_like.dart';
import 'package:assignment/api/http/http_post.dart';
import 'package:assignment/api/response/response_post.dart';
import 'package:assignment/api/token.dart';
import 'package:assignment/screens/post/comment.dart';
import 'package:assignment/screens/post/like.dart';
import 'package:assignment/screens/profile/profile_main_other.dart';
import 'package:assignment/screens/report.dart';
import 'package:assignment/screens/riverpod/theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final themeController =
      StateNotifierProvider<ThemeNotifier, bool>((_) => ThemeNotifier());
  int activeNav = 0;

  late Future<List<GetPost>> followedPosts;

  String postUrl = "http://10.0.2.2:4040/posts/";
  String profilePicUrl = "http://10.0.2.2:4040/profiles/";

  List activeIndexField = [],
      liked = [],
      likeNum = [],
      comment = [],
      commentNum = [];

  @override
  void initState() {
    super.initState();
    Token().getToken().then((value) {
      if (value.isEmpty) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
      }
    });

    followedPosts = HttpConnectPost().getFollowedPost();
    followedPosts.then((value) {
      setState(() {
        for (int i = 0; i < value.length; i++) {
          activeIndexField.add(0);
          likeNum.add(value[i].like_num);
          commentNum.add(value[i].comment_num);
        }
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
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: textColor,
          ),
          automaticallyImplyLeading: false,
          backgroundColor: backColor,
          title: Text(
            "WatchMe",
            style: TextStyle(
              color: textColor,
              fontSize: 20,
              fontFamily: "BerkshireSwash-Regular",
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "/setting");
              },
              icon: Icon(
                Icons.settings,
                size: 25,
                color: textColor,
              ),
            )
          ],
          shape: Border(
            bottom: BorderSide(
              color: textColor,
              width: .1,
            ),
          ),
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: FutureBuilder<List<GetPost>>(
              future: followedPosts,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Column(
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 0,
                                vertical: 0,
                              ),
                              onLongPress: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (builder) => ProfileMainOther(
                                      user_id:
                                          snapshot.data![index].user_id!["_id"],
                                    ),
                                  ),
                                );
                              },
                              leading: CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(profilePicUrl +
                                    snapshot
                                        .data![index].user_id!["profile_pic"]!),
                              ),
                              title: Text(
                                snapshot.data![index].user_id!["username"]!,
                                style: TextStyle(
                                  color: textColor,
                                  fontFamily: "Laila-Bold",
                                ),
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    backgroundColor: Colors.transparent,
                                    builder: (builder) => Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 5,
                                        horizontal: _screenWidth * .20,
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
                                            offset: Offset(0,
                                                1), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      height: 115,
                                      child: Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color:
                                                  Colors.deepPurpleAccent[700],
                                            ),
                                            height: 5,
                                            width: _screenWidth * .20,
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              showModalBottomSheet(
                                                backgroundColor:
                                                    Colors.transparent,
                                                context: context,
                                                builder: (builder) =>
                                                    SingleChildScrollView(
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                      top: 5,
                                                      left: _screenWidth * .05,
                                                      right: 5,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: backColor,
                                                      borderRadius:
                                                          new BorderRadius.only(
                                                        topLeft: const Radius
                                                            .circular(25.0),
                                                        topRight: const Radius
                                                            .circular(25.0),
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
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            color: Colors
                                                                    .deepPurpleAccent[
                                                                700],
                                                          ),
                                                          height: 5,
                                                          width: _screenWidth *
                                                              .20,
                                                        ),
                                                        Container(
                                                          height: 200,
                                                          child:
                                                              ListView.builder(
                                                            itemCount: snapshot
                                                                .data![index]
                                                                .tag_friend!
                                                                .length,
                                                            itemBuilder: (context,
                                                                    index1) =>
                                                                ListTile(
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              minVerticalPadding:
                                                                  1,
                                                              leading:
                                                                  CircleAvatar(
                                                                radius: 25,
                                                                backgroundImage:
                                                                    NetworkImage(profilePicUrl +
                                                                        snapshot
                                                                            .data![index]
                                                                            .tag_friend![index1]["profile_pic"]!),
                                                              ),
                                                              title: Text(
                                                                snapshot
                                                                        .data![
                                                                            index]
                                                                        .tag_friend![index1]
                                                                    [
                                                                    "username"]!,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color:
                                                                        textColor,
                                                                    fontFamily:
                                                                        "Laila-Bold"),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Text(
                                              "View tagged friends",
                                              style: TextStyle(
                                                color: Colors
                                                    .deepPurpleAccent[700],
                                                fontFamily: "Laila-Bold",
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                          TextButton(
                                            style: TextButton.styleFrom(
                                              padding: EdgeInsets.zero,
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (builder) => Report(
                                                      post_id: snapshot
                                                          .data![index].id),
                                                ),
                                              );
                                            },
                                            child: Text(
                                              "Report",
                                              style: TextStyle(
                                                color: Colors.deepOrange,
                                                fontFamily: "Laila-Bold",
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.more_vert,
                                  color: textColor,
                                ),
                              ),
                            ),
                            CarouselSlider(
                              items:
                                  snapshot.data![index].attach_file!.map((i) {
                                return Builder(builder: (BuildContext context) {
                                  return Image(
                                    image: NetworkImage(postUrl + i),
                                    fit: BoxFit.cover,
                                  );
                                });
                              }).toList(),
                              options: CarouselOptions(
                                initialPage: 0, // shows the first image
                                viewportFraction:
                                    1, // shows one image at a time
                                height: 400,
                                enableInfiniteScroll:
                                    false, // makes carousel scrolling only from first image to last image, disables loop scrolling
                                onPageChanged: ((indexCar, reason) {
                                  setState(() {
                                    activeIndexField.insert(index, indexCar);
                                  });
                                }),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            AnimatedSmoothIndicator(
                              activeIndex: activeIndexField[index],
                              count: snapshot.data![index].attach_file!.length,
                              effect: WormEffect(
                                dotColor: textColor,
                                activeDotColor: Colors.deepPurpleAccent,
                                dotHeight: 9,
                                dotWidth: 9,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 40,
                              child: Row(
                                children: [
                                  IconButton(
                                    padding: EdgeInsets.all(0),
                                    constraints: BoxConstraints(minWidth: 20),
                                    onPressed: () async {
                                      await HttpConnectLike()
                                          .likePost(snapshot.data![index].id);
                                      setState(() {
                                        followedPosts =
                                            HttpConnectPost().getFollowedPost();
                                      });
                                    },
                                    icon: Icon(
                                      Icons.favorite,
                                      color: textColor,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (builder) => Likers(
                                              post_id: snapshot.data![index].id,
                                              activeNav: 0),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "${likeNum[index].toString()} likes,",
                                      style: TextStyle(
                                        color: textColor,
                                        fontFamily: "Laila-Bold",
                                      ),
                                    ),
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (builder) => Commenters(
                                              post_id: snapshot.data![index].id,
                                              activeNav: 0),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "${commentNum[index].toString()} comments",
                                      style: TextStyle(
                                        color: textColor,
                                        fontFamily: "Laila-Bold",
                                      ),
                                    ),
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                  text: "${snapshot.data![index].caption} ",
                                  style: TextStyle(
                                    color: textColor,
                                    fontFamily: "Laila-Bold",
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          " ${snapshot.data![index].description}",
                                      style: TextStyle(
                                        color: textColor,
                                        fontFamily: "Laila-Regular",
                                      ),
                                    )
                                  ]),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 0,
                                vertical: 0,
                              ),
                              onTap: () {
                                final _formKey = GlobalKey<FormState>();
                                double containerPadding = 0;

                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (builder) => Container(
                                    padding: EdgeInsets.only(
                                        bottom: containerPadding),
                                    decoration: BoxDecoration(
                                      color: backColor,
                                    ),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 2,
                                      ),
                                      title: Form(
                                        key: _formKey,
                                        child: Focus(
                                          onFocusChange: (value) {
                                            if (value) {
                                              containerPadding = 300;
                                            } else {
                                              containerPadding = 0;
                                            }
                                          },
                                          child: TextFormField(
                                            autofocus: true,
                                            maxLines: 2,
                                            keyboardType:
                                                TextInputType.multiline,
                                            onSaved: (value) {},
                                            validator: MultiValidator([
                                              RequiredValidator(
                                                  errorText: "Empty field!"),
                                            ]),
                                            style: TextStyle(
                                              color: textColor,
                                            ),
                                            decoration: InputDecoration(
                                              hintText: "   Add a comment....",
                                              hintStyle: TextStyle(
                                                color: textColor,
                                              ),
                                              isDense: true,
                                              contentPadding: EdgeInsets.zero,
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                      trailing: IconButton(
                                        onPressed: () {
                                          _formKey.currentState!.validate();
                                        },
                                        icon: Icon(
                                          Icons.send_rounded,
                                          size: 35,
                                          color: Colors.deepPurpleAccent[700],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              leading: CircleAvatar(
                                radius: 18,
                                backgroundImage:
                                    AssetImage("images/defaultProfile.png"),
                              ),
                              title: Text(
                                "Comment on this post.....",
                                style: TextStyle(
                                  color: textColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
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
                    "No posts yet.",
                    style: TextStyle(
                      color: textColor,
                      fontSize: 15,
                    ),
                  ),
                );
                ;
              }),
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
