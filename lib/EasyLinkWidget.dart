import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ything_radio/EasyLink.dart';

class EasyLinkWidget extends StatelessWidget {
  final EasyLink linkInfo;

  const EasyLinkWidget({super.key, required this.linkInfo});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _launchUrl();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            FittedBox(
              child: Center(
                child: Icon(linkInfo.icon),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                ),
                child: Text(linkInfo.displayText),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse(linkInfo.uri))) {
      throw Exception('Could not launch url');
    }
  }
}
