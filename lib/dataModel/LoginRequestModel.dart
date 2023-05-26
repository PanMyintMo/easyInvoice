class LoginRequestModel {
  String loginemail;
  String loginpassword;

  LoginRequestModel(this.loginemail, this.loginpassword);

  Map<String, dynamic> toJson() {
    return {
      'loginemail': loginemail,
     'loginpassword': loginpassword
    };
   }
}



