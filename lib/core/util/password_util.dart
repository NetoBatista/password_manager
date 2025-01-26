import 'package:password_manager/core/enum/password_strength_enum.dart';
import 'package:password_manager/extension/translate_extension.dart';

class PasswordUtil {
  static PasswordStrengthEnum validatePasswordStrength(String password) {
    if (password.isEmpty) {
      return PasswordStrengthEnum.none;
    }

    bool hasUpperCase = password.contains(RegExp(r'[A-Z]'));
    bool hasLowerCase = password.contains(RegExp(r'[a-z]'));
    bool hasDigits = password.contains(RegExp(r'[0-9]'));
    bool hasSpecialCharacters = password.contains(RegExp(r'[!@#\$&*~]'));
    int length = password.length;

    if (length < 8) {
      return PasswordStrengthEnum.weak;
    }

    if (length >= 8 && length < 12) {
      if (hasUpperCase && hasLowerCase && (hasDigits || hasSpecialCharacters)) {
        return PasswordStrengthEnum.normal;
      } else {
        return PasswordStrengthEnum.weak;
      }
    }

    if (length >= 12 &&
        hasUpperCase &&
        hasLowerCase &&
        hasDigits &&
        hasSpecialCharacters) {
      return PasswordStrengthEnum.strong;
    }

    return PasswordStrengthEnum.normal;
  }

  static String translate(PasswordStrengthEnum passwordStrengthEnum) {
    if (passwordStrengthEnum == PasswordStrengthEnum.weak) {
      return "password_type.weak".translate();
    }
    if (passwordStrengthEnum == PasswordStrengthEnum.normal) {
      return "password_type.normal".translate();
    }
    if (passwordStrengthEnum == PasswordStrengthEnum.strong) {
      return "password_type.strong".translate();
    }
    return "password_type.none".translate();
  }
}
