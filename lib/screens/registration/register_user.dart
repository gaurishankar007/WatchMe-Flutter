import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:motion_toast/motion_toast.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({Key? key}) : super(key: key);

  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  final _formKey = GlobalKey<FormState>();
  String username = "", password = "", email = "", phoneNumber = "";

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
                    "Welcome to WatchMe",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    onSaved: (value) {
                      username = value!;
                    },
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Username is required!"),
                      MinLengthValidator(3,
                          errorText: "Provide at least 3 characters!"),
                      MaxLengthValidator(15,
                          errorText: "Provide at most 15 characters!"),
                      PatternValidator(r'^[a-zA-Z0-9]+$',
                          errorText:
                              "Special characters and white spaces not allowed!")
                    ]),
                    decoration: InputDecoration(
                      labelText: "Username",
                      hintText: "Enter a username.....",
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
                      password = value!.trim();
                    },
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Password is required!"),
                      MinLengthValidator(5,
                          errorText: "Provide at least 5 characters!"),
                      MaxLengthValidator(15,
                          errorText: "Provide at most 15 characters!"),
                      PatternValidator(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{5,15}$',
                          errorText:
                              'At least 1 upper, lowercase, number & special character!')
                    ]),
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      hintText: "Enter a password.....",
                      helperText: "Excludes whitespaces around the password.",
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
                      email = value!;
                    },
                    keyboardType: TextInputType.emailAddress,
                    validator: MultiValidator([
                      RequiredValidator(
                          errorText: "Email address is required!"),
                      EmailValidator(errorText: "Invalid email!")
                    ]),
                    decoration: InputDecoration(
                      labelText: "Email",
                      hintText: "Enter your email.....",
                      helperText: "Useful for reseting password.",
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
                      phoneNumber = value!;
                    },
                    keyboardType: TextInputType.number,
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Phone number is required!"),
                      PatternValidator(r'^(?:[+0]9)?[0-9]{10}$',
                          errorText: "Invalid phone number!")
                    ]),
                    decoration: InputDecoration(
                      labelText: "Phone Number",
                      hintText: "Enter your phone number.....",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        MotionToast.success(
                          title: "Account created :)",
                          description: "You created your 'WatchMe' account.",
                          toastDuration: Duration(seconds: 3),
                        ).show(context);
                      } else {
                        MotionToast.error(
                          title: "SignUp Failed :(",
                          description: "Fill up the form correctly.",
                          toastDuration: Duration(seconds: 3),
                        ).show(context);
                      }
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
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
