import 'package:assignment/api/http/http_post.dart';
import 'package:assignment/api/response/response_post.dart';
import 'package:assignment/screens/post/comment.dart';
import 'package:assignment/screens/post/like.dart';
import 'package:assignment/screens/riverpod/theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PostView extends StatefulWidget {
  final String? post_id;
  final int? activeNav;
  const PostView({Key? key, @required this.post_id, @required this.activeNav})
      : super(key: key);

  @override
  _PostViewState createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  final themeController =
      StateNotifierProvider<ThemeNotifier, bool>((_) => ThemeNotifier());
  int activeNav = 4;

  late Future<GetPost> userPost;
  int totalImages = 0;
  int activatedIndex = 0;

  String postUrl = "http://10.0.2.2:4040/posts/";
  String profilePicUrl = "http://10.0.2.2:4040/profiles/";

  @override
  void initState() {
    super.initState();
    activeNav = widget.activeNav!;
    userPost = HttpConnectPost().getSinglePost(widget.post_id);
    userPost.then((value) {
      setState(() {
        totalImages = value.attach_file!.length;
      });
    });
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
            "Post",
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
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              FutureBuilder<GetPost>(
                future: userPost,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      color: backColor,
                      child: Column(
                        children: [
                          ListTile(
                            minVerticalPadding: 0,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            leading: CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(profilePicUrl +
                                  snapshot.data!.user_id!["profile_pic"]!),
                            ),
                            title: Text(
                              snapshot.data!.user_id!["username"]!,
                              style: TextStyle(
                                color: textColor,
                                fontFamily: "Laila-Bold",
                              ),
                            ),
                          ),
                          CarouselSlider(
                            items: snapshot.data!.attach_file!.map((i) {
                              return Builder(builder: (BuildContext context) {
                                return Image(
                                  image: NetworkImage(postUrl + i),
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
                          AnimatedSmoothIndicator(
                            activeIndex: activatedIndex,
                            count: totalImages,
                            effect: WormEffect(
                              dotColor: textColor,
                              activeDotColor: Colors.deepPurpleAccent,
                              dotHeight: 9,
                              dotWidth: 9,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (builder) => Likers(
                                                post_id: widget.post_id,
                                                activeNav: 4),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        "${snapshot.data!.like_num.toString()} likes,",
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
                                      width: 10,
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (builder) => Commenters(
                                                post_id: widget.post_id,
                                                activeNav: 4),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        "${snapshot.data!.comment_num.toString()} comments",
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
                                RichText(
                                  text: TextSpan(
                                      text: "${snapshot.data!.caption} ",
                                      style: TextStyle(
                                        color: textColor,
                                        fontFamily: "Laila-Bold",
                                      ),
                                      children: [
                                        TextSpan(
                                          text:
                                              " ${snapshot.data!.description}",
                                          style: TextStyle(
                                            color: textColor,
                                            fontFamily: "Laila-Regular",
                                          ),
                                        )
                                      ]),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Tagged Watchers",
                                    style: TextStyle(
                                      color: textColor,
                                      fontFamily: "Laila-Bold",
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 150,
                                  child: ListView.builder(
                                    itemCount:
                                        snapshot.data!.tag_friend!.length,
                                    itemBuilder: (context, index) => ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      minVerticalPadding: 1,
                                      leading: CircleAvatar(
                                        radius: 20,
                                        backgroundImage: NetworkImage(
                                            profilePicUrl +
                                                snapshot.data!
                                                        .tag_friend![index]
                                                    ["profile_pic"]!),
                                      ),
                                      title: Text(
                                        snapshot.data!.tag_friend![index]
                                            ["username"]!,
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: textColor,
                                            fontFamily: "Laila-bold"),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
                },
              ),
              SizedBox(
                height: 20,
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
