import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    final safeLeftPadding = MediaQuery.of(context).padding.left + 16;
    final safeRightPadding = MediaQuery.of(context).padding.right + 16;
    final safeBottomPadding = MediaQuery.of(context).padding.bottom;
    final safeTopPadding = MediaQuery.of(context).padding.top;

    return DefaultTextStyle(
      style: Theme.of(context).textTheme.bodyLarge!,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: safeLeftPadding, right: safeRightPadding, bottom: safeBottomPadding, top: safeTopPadding),
          child: const Text(
            'Ything Radio is an app that is intended to provide a demonstration of the '
            'open source ything_radio app. This app is used to provide the ability for the '
            '"look and feel" of the app to be tested on real devices for those wishing to '
            'either use the code as a template for themselves; or, alternatively, have Ything LLC '
            'create a custom app for them!'
            '\n\n'
            'This app intentionally does not provide a method to change the streaming source '
            'as it is intended for use by internet radio stations to provide a dedicated app '
            'for their radio station. This is not intended to be an app for generic usage for '
            'multiple radio stations, a discovery platform, or to facilitate user input for '
            'internet radio sites.'
            '\n\n'
            'This app has been designed to run across all platforms!'
            '\n\n'
            'Android, iOS, MacOS, Windows, Linux, and Web!'
            '\n\n'
            'Have a single unified experience across all platforms for your users!'
            '\n\n'
            'Want to have us modify this app for you? Reach out at info@ything.net '
            'We can add additional features for you! Schedule views, up next listings, '
            'and even custom user interactivity! '
            '\n\n'
            'We look forward to hearing from you soon! We would love to build your app!',
            textAlign: TextAlign.justify,
          ),
        ),
      ),
    );
  }
}
