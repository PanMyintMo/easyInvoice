class RegisterRequestModel {
  String name;
  String email;
  String password;
  String password_confirmation;

  RegisterRequestModel({
    required this.name,
    required this.email,
    required this.password,
    required this.password_confirmation,
  });


  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': password_confirmation,
    };
  }
}
