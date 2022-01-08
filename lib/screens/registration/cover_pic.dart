import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:motion_toast/motion_toast.dart';

class AddCoverPicture extends StatefulWidget {
  const AddCoverPicture({ Key? key }) : super(key: key);

  @override
  _AddCoverPictureState createState() => _AddCoverPictureState();
}

class _AddCoverPictureState extends State<AddCoverPicture> {
  final _formKey = GlobalKey<FormState>();
  String coverPicture = "";

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
                    "Add Cover Picture",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onSaved: (value) {
                      coverPicture = value!;
                    },
                    validator: MultiValidator([
                      RequiredValidator(
                          errorText: "Cover picture not selected!"),
                    ]),
                    decoration: InputDecoration(
                      labelText: "Cover Picture",
                      hintText: "Select a Cover picture.....",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
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
                          Navigator.pushNamed(context, "/AddPersonalInformation");
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