class EditUserRoleRequestModel{
  String name;
  String email;
  String password;
  String utype;
  String newimage;

  EditUserRoleRequestModel({required this.name,required this.email,required this.password,required this.utype, required this.newimage});

  Map<String,dynamic> toJson(){
    return {
      'name' : name,
      'email' : email,
      'password' : password,
      'utype' : utype,
      'newimage' : newimage
    };
  }

}