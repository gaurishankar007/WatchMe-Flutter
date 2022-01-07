import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:motion_toast/motion_toast.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  String email = "", newPassword = "";

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
                    "Generate Reset Link",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      email = value;
                    },
                    keyboardType: TextInputType.emailAddress,
                    validator: MultiValidator([
                      RequiredValidator(
                          errorText: "Email address is required!"),
                      EmailValidator(errorText: "Invalid email!")
                    ]),
                    decoration: InputDecoration(
                      labelText: "Email",
                      hintText: "Enter your account email.....",
                      helperText: "Wrong email won't reset your password.",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      newPassword = value;
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
                      labelText: "New Password",
                      hintText: "Enter a new password.....",
                      helperText: "Excludes white spaces around the password.",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) =>
                        MatchValidator(errorText: "Password did not match.")
                            .validateMatch(value!, newPassword),
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
                      hintText: "Enter the password again.....",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ), 
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pushNamed(context, "/ResetPassword");
                      } else {
                        MotionToast.error(
                          title: "Submit Failed :(",
                          description: "",
                          toastDuration: Duration(seconds: 3),
                        ).show(context);
                      }
                    },
                    child: Text(
                      "Submit",
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
