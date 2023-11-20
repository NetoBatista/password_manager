import 'package:url_launcher/url_launcher.dart';

class UrlUtil {
  static void openLink(String url) {
    launchUrl(Uri.parse(url));
  }
}
