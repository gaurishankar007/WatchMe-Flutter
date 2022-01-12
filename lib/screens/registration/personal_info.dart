import 'package:assignment/screens/riverpod/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motion_toast/motion_toast.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({Key? key}) : super(key: key);

  @override
  _PersonalInformationState createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  final themeController =
      StateNotifierProvider<ThemeNotifier, bool>((_) => ThemeNotifier());
  final _formKey = GlobalKey<FormState>();
  String firstName = "",
      lastName = "",
      birthdate = "2018-01-01",
      biography = "";
  String? gender = "Male";

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    return Consumer(builder: (context, ref, child) {
      return Scaffold(
        backgroundColor:
            ref.watch(themeController) ? Colors.black : Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: ref.watch(themeController) ? Colors.white : Colors.black,
          ),
          backgroundColor:
              ref.watch(themeController) ? Colors.black : Colors.white,
          title: Text(
            "WatchMe",
            style: TextStyle(
              color: ref.watch(themeController) ? Colors.white : Colors.black,
              fontSize: 35,
              fontWeight: FontWeight.bold,
              fontFamily: "Rochester-Regular",
            ),
          ),
          centerTitle: true,
          elevation: 2,
          shadowColor: ref.watch(themeController) ? Colors.white : Colors.black,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: _screenWidth * 0.03,
              left: _screenWidth * 0.10,
              right: _screenWidth * 0.10,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    "Add Personal Information",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ref.watch(themeController)
                          ? Colors.white
                          : Colors.black,
                      fontSize: 25,
                      fontFamily: "Kalam-Bold",
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onSaved: (value) {
                      firstName = value!.trim();
                    },
                    textCapitalization: TextCapitalization.words,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "First name is required!";
                      } else if (value.contains(RegExp(r'[0-9]')) ||
                          value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')) ||
                          value.length < 2) {
                        return "Invalid first name!";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "First Name",
                      labelStyle: TextStyle(
                        color: ref.watch(themeController)
                            ? Colors.white
                            : Colors.black,
                        fontFamily: "Kalam-Bold",
                      ),
                      hintText: "Enter your first name.....",
                      hintStyle: TextStyle(
                        color: ref.watch(themeController)
                            ? Colors.white
                            : Colors.black,
                        fontFamily: "Kalam-Bold",
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
                          color: ref.watch(themeController)
                              ? Colors.white
                              : Colors.black,
                          width: 2,
                          style: BorderStyle.solid,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: ref.watch(themeController)
                              ? Colors.white
                              : Colors.black,
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
                    onSaved: (value) {
                      lastName = value!;
                    },
                    textCapitalization: TextCapitalization.words,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Last name is required!";
                      } else if (value.contains(RegExp(r'[0-9]')) ||
                          value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')) ||
                          value.length < 2) {
                        return "Invalid last name!";
                      } else if (value.contains(" ")) {
                        return "Whitespaces not allowed!";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Last Name",
                      labelStyle: TextStyle(
                        color: ref.watch(themeController)
                            ? Colors.white
                            : Colors.black,
                        fontFamily: "Kalam-Bold",
                      ),
                      hintText: "Enter your last name.....",
                      hintStyle: TextStyle(
                        color: ref.watch(themeController)
                            ? Colors.white
                            : Colors.black,
                        fontFamily: "Kalam-Bold",
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
                          color: ref.watch(themeController)
                              ? Colors.white
                              : Colors.black,
                          width: 2,
                          style: BorderStyle.solid,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: ref.watch(themeController)
                              ? Colors.white
                              : Colors.black,
                          width: 2,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Gender:",
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      Row(
                        children: [
                          Radio(
                            value: "Male",
                            groupValue: gender,
                            onChanged: (String? value) => setState(() {
                              gender = value;
                            }),
                          ),
                          Text(
                            "Male",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          Radio(
                            value: "Female",
                            groupValue: gender,
                            onChanged: (String? value) => setState(() {
                              gender = value;
                            }),
                          ),
                          Text(
                            "Female",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          Radio(
                            value: "Other",
                            groupValue: gender,
                            onChanged: (String? value) => setState(() {
                              gender = value;
                            }),
                          ),
                          Text(
                            "Other",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Birthday:",
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      DatePickerWidget(
                        dateFormat: "yyyy-MMMM-dd",
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                        initialDate: DateTime(2018),
                        onChange: (DateTime newDate, _) {
                          String month = "${newDate.month}";
                          String day = "${newDate.day}";
                          if (int.parse(newDate.month.toString()) < 10) {
                            month = "0${newDate.month}";
                          }
                          if (int.parse(newDate.day.toString()) < 10) {
                            day = "0${newDate.day}";
                          }
                          birthdate = "${newDate.year}-$month-$day";
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    maxLines: 5,
                    onSaved: (value) {
                      biography = value!.trim();
                    },
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      labelText: "Biography",
                      hintText: "Enter your biography here.....",
                      helperText: "Optional",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/AddAddress");
                        },
                        child: Text(
                          "Skip",
                          style: TextStyle(
                            color: Colors.deepPurpleAccent[700],
                            fontSize: 20,
                            fontFamily: "Kalam-Bold",
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            Navigator.pushNamed(context, "/AddAddress");
                          } else {
                            MotionToast.error(
                              title: "Submit Failed :(",
                              description: "",
                              toastDuration: Duration(seconds: 3),
                            ).show(context);
                          }
                        },
                        child: Text(
                          "Next",
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: "Kalam-Bold",
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepPurpleAccent[700],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
