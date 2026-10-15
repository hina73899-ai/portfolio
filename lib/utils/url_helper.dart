import 'package:url_launcher/url_launcher.dart';

/// Link open karta hai (web par new tab mein).
/// Email ke liye: openUrl('mailto:abc@gmail.com')
Future<void> openUrl(String url) async {
  final uri = Uri.parse(url);
  await launchUrl(uri, webOnlyWindowName: '_blank');
}
