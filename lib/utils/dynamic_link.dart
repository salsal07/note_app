import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

import 'package:share_plus/share_plus.dart';

class DynamicLinking {
  Future<String> createLink(String refCode) async {
    final String url = 'http://com.example.music?ref=$refCode';
    final DynamicLinkParameters parameters = DynamicLinkParameters(
        androidParameters: const AndroidParameters(
            packageName: 'com.example.my_notes_with_firebase_mvvm',
            minimumVersion: 0),
        iosParameters: const IOSParameters(
            bundleId: 'com.example.my_notes_with_firebase_mvvm',
            minimumVersion: '0'),
        link: Uri.parse(url),
        uriPrefix: 'https://beatzmusicmojjoo.page.link');
    FirebaseDynamicLinks link = FirebaseDynamicLinks.instance;
    final refLink = await link.buildShortLink(parameters);
    return refLink.shortUrl.toString();
  }

  //init dynamic link
  Future<void> initDynamicLink() async {
    final instanceLink = await FirebaseDynamicLinks.instance.getInitialLink();
    if (instanceLink != null) {
      final Uri refLink = instanceLink.link;
      Share.share('this is the link ${refLink.queryParameters['ref']}');
    }
  }
}
