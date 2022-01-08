import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:motion_toast/motion_toast.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({Key? key}) : super(key: key);

  @override
  _PersonalInformationState createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  final _formKey = GlobalKey<FormState>();
  String firstName = "",
      lastName = "",
      birthdate = "2018-01-01",
      biography = "";
  String? gender = "Male";

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(_screenWidth * 0.10),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    "Add Personal Information",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(
                    height: 30,
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
                      hintText: "Enter your first name.....",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
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
                      hintText: "Enter your last name.....",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
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
                          Navigator.pushNamed(context, "//AddAddress");
                        },
                        child: Text(
                          "Skip",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            Navigator.pushNamed(context, "//AddAddress");
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
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
