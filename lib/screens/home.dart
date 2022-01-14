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
  List posts = [
    [
      "user1",
      ["defaultProfile.png", "defaultCover.jpg"],
      "Flying to the Moon.",
      "Anyone interestied flying to the Moon with me, then they can contact me. It will be really relly fun.",
      285
    ],
    [
      "user2",
      ["defaultProfile.png", "defaultCover.jpg"],
      "Flying to the Moon.",
      "Anyone interestied flying to the Moon with me, then they can contact me. It will be really relly fun.",
      360
    ],
    [
      "user3",
      ["defaultProfile.png", "defaultCover.jpg"],
      "Flying to the Moon.",
      "Anyone interestied flying to the Moon with me, then they can contact me. It will be really relly fun.",
      145
    ]
  ];
  List activeIndexField = [],
      liked = [],
      likedNum = [],
      comment = [],
      save = [];
  void addIndex() {
    for (int i = 0; i < posts.length; i++) {
      activeIndexField.add(0);
      liked.add(false);
      likedNum.add(posts[i][4]);
      comment.add(false);
      save.add(false);
    }
  }

  @override
  void initState() {
    super.initState();
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
          backgroundColor: backColor,
          title: Text(
            "WatchMe",
            style: TextStyle(
              color: textColor,
              fontSize: 30,
              fontFamily: "BerkshireSwash-Regular",
            ),
          ),
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
            final _formKey = GlobalKey<FormState>();
            return Container(
              color: backColor,
              child: Column(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 4,
                      ),
                      leading: CircleAvatar(
                        radius: 20,
                        backgroundImage:
                            AssetImage("images/defaultProfile.png"),
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
                          final snackBar = SnackBar(
                            backgroundColor: backColor,
                            duration: Duration(minutes: 5),
                            padding: EdgeInsets.symmetric(
                              horizontal: _screenWidth * .28,
                            ),
                            content: Container(
                              height: 150,
                              child: ListView(
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
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                    ),
                                    onPressed: () {},
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
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        icon: Icon(
                          Icons.more_vert,
                          color: textColor,
                        ),
                      ),
                    ),
                  ),
                  CarouselSlider(
                    items: images.map((i) {
                      return Builder(builder: (BuildContext context) {
                        return Image(
                          image: AssetImage("images/$i"),
                          fit: BoxFit.cover,
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
                      (images.length > 1)
                          ? AnimatedSmoothIndicator(
                              activeIndex: activeIndexField[index],
                              count: images.length,
                              effect: WormEffect(
                                dotColor: textColor,
                                activeDotColor: Colors.deepPurpleAccent,
                                dotHeight: 9,
                                dotWidth: 9,
                              ),
                            )
                          : SizedBox(
                              width: 0,
                              height: 0,
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
                      final snackBar = SnackBar(
                        backgroundColor: backColor,
                        duration: Duration(minutes: 30),
                        content: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          leading: CircleAvatar(
                            radius: 18,
                            backgroundImage:
                                AssetImage("images/defaultProfile.png"),
                          ),
                          title: Form(
                            key: _formKey,
                            child: TextFormField(
                              maxLines: 2,
                              keyboardType: TextInputType.multiline,
                              onSaved: (value) {},
                              validator: MultiValidator([
                                RequiredValidator(errorText: "Empty field!"),
                              ]),
                              style: TextStyle(
                                color: textColor,
                              ),
                              decoration: InputDecoration(
                                hintText: "Add a comment....",
                                hintStyle: TextStyle(
                                  color: textColor,
                                ),
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: textColor,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: textColor,
                                  ),
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
                              color: Colors.deepPurpleAccent[700],
                            ),
                          ),
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
      );
    });
  }
}
