import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

class AppUtils {
  urlLaunch({url}) async {
    // ignore: deprecated_member_use
    await launch(url, universalLinksOnly: false, forceSafariVC: false);
  }

  /// Phone dialer launcher
  static Future<void> launchPhone(String phone) async {
    final Uri uri = Uri(
      scheme: 'tel',
      path: phone.replaceAll(' ', '').replaceAll('-', ''), // sanitize
    );

    if (!await launchUrl(uri)) {
      debugPrint("Could not launch phone: $phone");
    }
  }
}
