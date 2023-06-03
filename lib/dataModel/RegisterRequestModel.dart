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

  factory RegisterRequestModel.fromJson(Map<String, dynamic> data) {
    return RegisterRequestModel(
      name: data['name'],
      email: data['email'],
      password: data['password'],
      password_confirmation: data['password_confirmation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': password_confirmation,
    };
  }
}
