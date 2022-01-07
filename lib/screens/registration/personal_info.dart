import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
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
      gender = "",
      birthdate = "",
      biography = "";
  List<String> hobbies = [];

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
                      } 
                      if (value.contains(RegExp(r'[0-9]')) || value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                          return "Invalid first name!";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "First Name",
                      hintText: "Enter your first name.....",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onSaved: (value) {
                      lastName = value!.trim();
                    },
                    textCapitalization: TextCapitalization.words,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Last name is required!";
                      } 
                      if (value.contains(RegExp(r'[0-9]')) || value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                          return "Invalid last name!";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Last Name",
                      hintText: "Enter your last name.....",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onSaved: (value) {
                      biography = value!.trim();
                    },
                    textCapitalization: TextCapitalization.sentences,
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Biography  is required!"),
                    ]),
                    decoration: InputDecoration(
                      labelText: "Biography",
                      hintText: "Enter your biography here.....",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
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
                            fontSize: 15,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
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
