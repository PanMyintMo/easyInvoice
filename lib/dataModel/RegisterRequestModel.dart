class RegisterRequestModel{
  String username;
  String email;
  String password;
  RegisterRequestModel(this.username,this.email,this.password);
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
    };
  }
}
