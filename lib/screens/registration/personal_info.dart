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
                      color: textColor,
                      fontSize: 25,
                      fontFamily: "Laila-Bold",
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
                    style: TextStyle(
                      color: textColor,
                    ),
                    decoration: InputDecoration(
                      labelText: "First Name",
                      labelStyle: TextStyle(
                        color: textColor,
                        fontFamily: "Laila-Bold",
                      ),
                      hintText: "Enter your first name.....",
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
                    style: TextStyle(
                      color: textColor,
                    ),
                    decoration: InputDecoration(
                      labelText: "Last Name",
                      labelStyle: TextStyle(
                        color: textColor,
                        fontFamily: "Laila-Bold",
                      ),
                      hintText: "Enter your last name.....",
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Gender:",
                        style: TextStyle(
                          color: textColor,
                          fontSize: 17,
                          fontFamily: "Laila-Bold",
                        ),
                      ),
                      Row(
                        children: [
                          Radio(
                            fillColor: MaterialStateColor.resolveWith(
                                (states) => textColor),
                            value: "Male",
                            groupValue: gender,
                            onChanged: (String? value) => setState(() {
                              gender = value;
                            }),
                          ),
                          Text(
                            "Male",
                            style: TextStyle(
                              color: textColor,
                              fontSize: 15,
                            ),
                          ),
                          Radio(
                            fillColor: MaterialStateColor.resolveWith(
                                (states) => textColor),
                            value: "Female",
                            groupValue: gender,
                            onChanged: (String? value) => setState(() {
                              gender = value;
                            }),
                          ),
                          Text(
                            "Female",
                            style: TextStyle(
                              color: textColor,
                              fontSize: 15,
                            ),
                          ),
                          Radio(
                            fillColor: MaterialStateColor.resolveWith(
                                (states) => textColor),
                            value: "Other",
                            groupValue: gender,
                            onChanged: (String? value) => setState(() {
                              gender = value;
                            }),
                          ),
                          Text(
                            "Other",
                            style: TextStyle(
                              color: textColor,
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
                            color: textColor,
                            fontSize: 17,
                            fontFamily: "Laila-Bold"),
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
                    height: 20,
                  ),
                  TextFormField(
                    maxLines: 5,
                    onSaved: (value) {
                      biography = value!.trim();
                    },
                    keyboardType: TextInputType.multiline,
                    textCapitalization: TextCapitalization.sentences,
                    style: TextStyle(
                      color: textColor,
                    ),
                    decoration: InputDecoration(
                      labelText: "Biography",
                      labelStyle: TextStyle(
                        color: textColor,
                        fontFamily: "Laila-Bold",
                      ),
                      hintText: "Enter your biography here.....",
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
