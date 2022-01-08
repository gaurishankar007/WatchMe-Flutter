import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:motion_toast/motion_toast.dart';

class Address extends StatefulWidget {
  const Address({Key? key}) : super(key: key);

  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<Address> {
  final _formKey = GlobalKey<FormState>();
  String country = "", state="", city="", street="";

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
                    "Add Address",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    onSaved: (value) {
                      state = value!.trim();
                    },
                    textCapitalization: TextCapitalization.sentences,
                    validator: MultiValidator([
                      RequiredValidator(errorText: "State  is required!"),
                    ]),
                    decoration: InputDecoration(
                      labelText: "State",
                      hintText: "Enter state here.....",
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
                      city = value!.trim();
                    },
                    textCapitalization: TextCapitalization.sentences,
                    validator: MultiValidator([
                      RequiredValidator(errorText: "City  is required!"),
                    ]),
                    decoration: InputDecoration(
                      labelText: "City",
                      hintText: "Enter city here.....",
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
                      street = value!.trim();
                    },
                    textCapitalization: TextCapitalization.sentences,
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Street  is required!"),
                    ]),
                    decoration: InputDecoration(
                      labelText: "Street",
                      hintText: "Enter street here.....",
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
