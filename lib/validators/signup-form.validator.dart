import 'package:email_validator/email_validator.dart';

class SignupFormValidator {
  static String? usernameValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter a valid username";
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty || value.length < 8) {
      return "Password must contains at least 8 characters";
    }
    return null;
  }

  static String? emailValidator(String? value) {
    if (value == null || value.trim().isEmpty || !EmailValidator.validate(value)) {
      return "Please enter a valid email";
    }
    return null;
  }

  static String? rePasswordValidator(String? rePassword, String? password) {
    if (rePassword != password) {
      return "Passwords do not match";
    }
    return null;
  }
}