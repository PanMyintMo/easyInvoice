import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const String tokenKey =
      'token'; // Key for the token in SharedPreferences
  static const String usernameKey =
      'username'; // New key for username in SharedPreferences
  static const String emailKey =
      'email'; // New key for email in SharedPreferences
  static const String idKey = 'idkey';
  static const String utypeKey = 'utype';

  // Set the authorization token in shared preferences
  Future<void> setAuthToken(String token) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(tokenKey, token);
  }

  // Get the authorization token from shared preferences
  Future<String?> getAuthToken() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(tokenKey);
  }

  // Remove the authorization token from shared preferences
  Future<void> removeAuthToken() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(tokenKey);
  }

  //Set the username in share preferences
  Future<void> setUserName(String username) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(usernameKey, username);
  }

  //Get the username from share preference
  Future<String?> getUsername() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(usernameKey);
  }

  //set user type in share preferences

  Future<void> setUserType(String utype) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(utypeKey, utype);
  }

  //Get User type from share preference
  Future<String?> fetchUserType() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(utypeKey);
  }

//Set the email in share preferences
  Future<void> setEmail(String email) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(emailKey, email);
  }

  //Get the email from share preference
  Future<String?> getEmail() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(emailKey);
  }

//Set the user id in share preferences
  Future<void> setId(int id) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt(idKey, id);
  }

  //Get the email from share preference
  Future<int?> getLoginUserId() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt(idKey);
  }

  // Get the password from shared preference
  Future<String?> getPassword() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences
        .getString(emailKey); // Change 'passwordKey' to 'emailKey'
  }
}
