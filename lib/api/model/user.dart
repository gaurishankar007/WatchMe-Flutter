class UserRegister {
  final String? username;
  final String? password;
  final String? email;
  final String? phone;

  UserRegister(
      {this.username,
      this.password,
      this.email,
      this.phone});
}

class UserLogin {
  final String? usernameEmail;
  final String? password;

  UserLogin({this.usernameEmail, this.password});
}
