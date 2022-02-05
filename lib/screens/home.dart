import 'package:assignment/api/token.dart';
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

  List posts = [
    [
      "user1",
      ["defaultProfile.png", "defaultCover.png"],
      "Flying to the Moon.",
      "Anyone interestied flying to the Moon with me, then they can contact me. It will be really relly fun.",
      285
    ],
    [
      "user2",
      ["defaultProfile.png", "defaultCover.png"],
      "Flying to the Moon.",
      "Anyone interestied flying to the Moon with me, then they can contact me. It will be really relly fun.",
      360
    ],
    [
      "user3",
      ["defaultProfile.png", "defaultCover.png"],
      "Flying to the Moon.",
      "Anyone interestied flying to the Moon with me, then they can contact me. It will be really relly fun.",
      145
    ]
  ];
  List activeIndexField = [],
      liked = [],
      likedNum = [],
      comment = [],
      save = [],
      unwatch = [];
  void addIndex() {
    for (int i = 0; i < posts.length; i++) {
      activeIndexField.add(0);
      liked.add(false);
      likedNum.add(posts[i][4]);
      comment.add(false);
      save.add(false);
      unwatch.add(false);
    }
  }

  @override
  void initState() {
    super.initState();
    Token().getToken().then((value) {
      if (value.isEmpty) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
      }
    });
    addIndex();
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
        body: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            List<String> images = posts[index][1];
            return Container(
              color: backColor,
              child: Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage("images/defaultProfile.png"),
                    ),
                    title: Text(
                      posts[index][0],
                      style: TextStyle(
                        color: textColor,
                        fontFamily: "Laila-Bold",
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (builder) => Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: _screenWidth * .20,
                            ),
                            decoration: BoxDecoration(
                              color: backColor,
                            ),
                            height: 170,
                            child: Column(
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "View tagged friends",
                                    style: TextStyle(
                                      color: Colors.deepPurpleAccent[700],
                                      fontFamily: "Laila-Bold",
                                    ),
                                  ),
                                ),
                                Divider(
                                  height: 2,
                                  thickness: 1,
                                  color: textColor,
                                ),
                                unwatch[index]
                                    ? TextButton(
                                        style: TextButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                        ),
                                        onPressed: () {
                                          unwatch[index] = false;
                                          ScaffoldMessenger.of(context)
                                              .hideCurrentSnackBar();
                                        },
                                        child: Text(
                                          "Watch",
                                          style: TextStyle(
                                            color: Colors.deepPurpleAccent[700],
                                            fontFamily: "Laila-Bold",
                                          ),
                                        ),
                                      )
                                    : TextButton(
                                        style: TextButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                        ),
                                        onPressed: () {
                                          unwatch[index] = true;
                                          ScaffoldMessenger.of(context)
                                              .hideCurrentSnackBar();
                                        },
                                        child: Text(
                                          "Unwatch",
                                          style: TextStyle(
                                            color: Colors.deepPurpleAccent[700],
                                            fontFamily: "Laila-Bold",
                                          ),
                                        ),
                                      ),
                                Divider(
                                  height: 2,
                                  thickness: 1,
                                  color: textColor,
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                  ),
                                  onPressed: () {},
                                  child: Text(
                                    "Report",
                                    style: TextStyle(
                                      color: Colors.red[700],
                                      fontFamily: "Laila-Bold",
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
                    items: images.map((i) {
                      return Builder(builder: (BuildContext context) {
                        return Image(
                          image: AssetImage("images/$i"),
                          fit: BoxFit.contain,
                        );
                      });
                    }).toList(),
                    options: CarouselOptions(
                      initialPage: 0, // shows the first image
                      viewportFraction: 1, // shows one image at a time
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
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                padding: EdgeInsets.all(0),
                                onPressed: () {
                                  setState(() {
                                    likedNum[index] = likedNum[index] + 1;
                                    liked[index]
                                        ? liked[index] = false
                                        : liked[index] = true;
                                  });
                                },
                                icon: Icon(
                                  Icons.favorite,
                                  color: liked[index]
                                      ? Colors.deepPurpleAccent[700]
                                      : textColor,
                                ),
                              ),
                              IconButton(
                                padding: EdgeInsets.all(0),
                                alignment: Alignment.centerLeft,
                                onPressed: () {},
                                icon: Icon(
                                  Icons.mode_comment_outlined,
                                  color: comment[index]
                                      ? Colors.deepPurpleAccent[700]
                                      : textColor,
                                ),
                              )
                            ],
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                save[index]
                                    ? save[index] = false
                                    : save[index] = true;
                              });
                            },
                            icon: Icon(
                              Icons.bookmark,
                              color: save[index]
                                  ? Colors.deepPurpleAccent[700]
                                  : textColor,
                            ),
                          )
                        ],
                      ),
                      AnimatedSmoothIndicator(
                        activeIndex: activeIndexField[index],
                        count: images.length,
                        effect: WormEffect(
                          dotColor: textColor,
                          activeDotColor: Colors.deepPurpleAccent,
                          dotHeight: 9,
                          dotWidth: 9,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${likedNum[index].toString()} likes",
                          style: TextStyle(
                            color: textColor,
                            fontFamily: "Laila-Bold",
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                              text: "${posts[index][2]} ",
                              style: TextStyle(
                                color: textColor,
                                fontFamily: "Laila-Bold",
                              ),
                              children: [
                                TextSpan(
                                  text: " ${posts[index][3]}",
                                  style: TextStyle(
                                    color: textColor,
                                    fontFamily: "Laila-Regulor",
                                  ),
                                )
                              ]),
                        )
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      final _formKey = GlobalKey<FormState>();
                      double containerPadding = 0;

                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (builder) => Container(
                          padding: EdgeInsets.only(bottom: containerPadding),
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
                                  keyboardType: TextInputType.multiline,
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
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
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
                  ),
                ],
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
    });
  }
}
