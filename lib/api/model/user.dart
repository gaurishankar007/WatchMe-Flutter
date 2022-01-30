class UserRegister {
  final String? username;
  final String? password;
  final String? email;
  final String? phone;

  UserRegister({this.username, this.password, this.email, this.phone});
}

class UserLogin {
  final String? usernameEmail;
  final String? password;

  UserLogin({this.usernameEmail, this.password});
}

class PersonalInfoRegister {
  final String? firstname;
  final String? lastname;
  final String? gender;
  final String? birthdate;
  final String? biography;

  PersonalInfoRegister(
      {this.firstname,
      this.lastname,
      this.gender,
      this.birthdate,
      this.biography});
}

class AddressRegister {
  final String? pCountry;
  final String? pState;
  final String? pCity;
  final String? pStreet;
  final String? tCountry;
  final String? tState;
  final String? tCity;
  final String? tStreet;

  AddressRegister({
    this.pCountry,
    this.pState,
    this.pCity,
    this.pStreet,
    this.tCountry,
    this.tState,
    this.tCity,
    this.tStreet,
  });
}
