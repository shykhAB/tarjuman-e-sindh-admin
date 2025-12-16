class LoginModel {
  String email = "";
  String password = "";

  LoginModel.fromJson(Map<String, dynamic> json) {
    email = json["email"] ?? "";
    password = json["password"] ?? "";
  }

  Map<String, dynamic> toJson(){
    return {
      "email" : email,
      "password" : password,
    };
  }

  LoginModel.empty();

  @override
  String toString() {
    return 'LoginModel{email: $email, _password: $password,}';
  }
}
