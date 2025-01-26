import 'package:localization/localization.dart';

extension StringExtension on String {
  String translate() {
    return i18n();
  }
}
