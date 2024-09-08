import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:ything_radio/EasyLink.dart';
import 'package:ything_radio/EasyLinkWidget.dart';
import 'package:ything_radio/SafeZone.dart';

class Links extends StatelessWidget {
  const Links({super.key});

  final List<EasyLinkWidget> links = const [
    EasyLinkWidget(
      linkInfo: EasyLink(
          uri: "https://github.com/YthingLLC/ything_radio",
          displayText: "GitHub - Ything Radio",
          icon: TablerIcons.brand_github),
    ),
    EasyLinkWidget(
      linkInfo: EasyLink(
        uri: "http://ything.net",
        displayText: "Ything Home",
        icon: TablerIcons.home,
      ),
    ),
    //EasyLinkWidget(
    //  linkInfo: EasyLink(
    //    uri: "http://",
    //    displayText: "Link 3",
    //    icon: TablerIcons.abc,
    //  ),
    //),
    //EasyLinkWidget(
    //  linkInfo: EasyLink(
    //      uri: "https://",
    //      displayText: "Link 4",
    //      icon: TablerIcons.brand_wikipedia),
    //),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.headlineSmall!,
      child: SafeZone(
        child: Center(
          child: Column(
            children: links.map((link) => link).toList(),
          ),
        ),
      ),
    );
  }
}
