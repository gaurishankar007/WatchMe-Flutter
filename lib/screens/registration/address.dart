import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:country_picker/country_picker.dart';
import 'package:motion_toast/motion_toast.dart';

class Address extends StatefulWidget {
  const Address({Key? key}) : super(key: key);

  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<Address> {
  final _formKey = GlobalKey<FormState>();
  String pCountry = "Afganistan",
      pState = "",
      pCity = "",
      pStreet = "",
      tCountry = "Afganistan",
      tState = "",
      tCity = "",
      tStreet = "";

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
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Temporary",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [                      
                      Text(
                        "Country:",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Row(
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.black,
                              side: BorderSide(),
                              padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                            ),
                            onPressed: () {
                              showCountryPicker(
                                context: context,
                                showPhoneCode: true,
                                onSelect: (Country country) {
                                  setState(() {
                                    String countryName = "";
                                    List<String> countryDetail = country.displayName.split(" ");
                                    for (int i = 0; i < countryDetail.length; i++) {
                                      if(i<(countryDetail.length-2)) {
                                        countryName += countryDetail[i]+ " ";
                                      }
                                    }
                                    tCountry = countryName.trim();
                                  });
                                },
                              );
                            },
                            child: Row(
                              children: [
                                Text(
                                  tCountry,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_drop_down_sharp,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onSaved: (value) {
                      tState = value!.trim();
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
                    height: 15,
                  ),
                  TextFormField(
                    onSaved: (value) {
                      tCity = value!.trim();
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
                    height: 15,
                  ),
                  TextFormField(
                    onSaved: (value) {
                      tStreet = value!.trim();
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
                    height: 20,
                  ),
                  Text(
                    "Permanent",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [                      
                      Text(
                        "Country:",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Row(
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.black,
                              side: BorderSide(),
                              padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                            ),
                            onPressed: () {
                              showCountryPicker(
                                context: context,
                                showPhoneCode: true,
                                onSelect: (Country country) {
                                  setState(() {
                                    String countryName = "";
                                    List<String> countryDetail = country.displayName.split(" ");
                                    for (int i = 0; i < countryDetail.length; i++) {
                                      if(i<(countryDetail.length-2)) {
                                        countryName += countryDetail[i]+ " ";
                                      }
                                    }
                                    pCountry = countryName.trim();
                                  });
                                },
                              );
                            },
                            child: Row(
                              children: [
                                Text(
                                  pCountry,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_drop_down_sharp,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onSaved: (value) {
                      pState = value!.trim();
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
                    height: 15,
                  ),
                  TextFormField(
                    onSaved: (value) {
                      pCity = value!.trim();
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
                    height: 15,
                  ),
                  TextFormField(
                    onSaved: (value) {
                      pStreet = value!.trim();
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
