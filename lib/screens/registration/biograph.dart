import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:motion_toast/motion_toast.dart';

class Biograph extends StatefulWidget {
  const Biograph({ Key? key }) : super(key: key);

  @override
  _BiographState createState() => _BiographState();
}

class _BiographState extends State<Biograph> {
  final _formKey = GlobalKey<FormState>();
  String biography = "";

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