import 'package:password_manager/extension/translate_extension.dart';

class FormValidator {
  static String? requiredField(String? value) {
    if (value == null || value.isEmpty) {
      return "required_field".translate();
    }
    return null;
  }

  static String? requiredPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "required_field".translate();
    }
    if (value.length < 6) {
      return "weak_password".translate();
    }
    return null;
  }
}
