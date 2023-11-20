import 'package:localization/localization.dart';

class FormValidator {
  static String? requiredField(String? value) {
    if (value == null || value.isEmpty) {
      return "required_field".i18n();
    }
    return null;
  }

  static String? requiredPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "required_field".i18n();
    }
    if (value.length < 6) {
      return "weak_password".i18n();
    }
    return null;
  }
}
