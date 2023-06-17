class UserRequestModel {
  String name;
  String email;
  String password;
  String utpye;
  String newimage;

  UserRequestModel(
      {required this.name,
      required this.email,
      required this.password,
      required this.utpye,
      required this.newimage});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'utype': utpye,
      'newimage': newimage
    };
  }
}
