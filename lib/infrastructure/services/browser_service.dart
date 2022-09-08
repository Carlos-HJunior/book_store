import 'package:book_store/domain/util/normalized_exception.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services.dart';

BrowserService newBrowserService() {
  return _BrowserService();
}

class _BrowserService implements BrowserService {

  @override
  Future tryLaunch(String url) async {
    var uri = Uri.tryParse(url);

    if (uri == null)
      throw NormalizedException('Invalid url, contact administrator.');

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw NormalizedException('Website unavailable, please try again later.');
    }
  }
}
