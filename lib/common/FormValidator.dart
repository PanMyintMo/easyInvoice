class FormValidator {
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email!';
    }
    final RegExp emailRegex = RegExp(
      r'^[\w+\-.]+@[a-zA-Z\d\-]+(\.[a-zA-Z\d\-]+)*(\.[a-zA-Z]{2,})$',
    );

    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address!';
    }
    final List<String> parts = value.split('@');
    if (parts.length != 2 || parts[1].isEmpty) {
      return 'Please enter a valid email address!';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter your password!';
    }
    final RegExp passwordRegx = RegExp(
      r'^(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[@#$%^&+=])(?=.{8,})',
    );

    if (!passwordRegx.hasMatch(value)) {
      return 'Password must contain at one number, special character and text, and have a length of 8 characters!';
    }
    return null;
  }
}

String? validateProductField(String? value) {
  if (value!.isEmpty) {
    return 'Please fill this field!';
  }
  return null;
}

String? validateFirstName(String? value) {
  if(value == null || value.isEmpty){
    return 'Please enter first name';
  }
  return null;
}

String? validateLastName(String? value) {
  if(value == null || value.isEmpty){
    return 'Please enter Last name';
  }
  return null;
}