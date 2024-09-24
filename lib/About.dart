import 'package:flutter/material.dart';
import 'package:ything_radio/SafeZone.dart';

import 'Globals.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/app-background2.jpg'),
          fit: BoxFit.cover,
          opacity: 0.2,
        ),
      ),
      child: SafeZone(
        child: DefaultTextStyle(
          style: Theme.of(context).textTheme.bodyLarge!,
          child: SingleChildScrollView(
            child: Text(
              getAboutText(),
              textAlign: TextAlign.justify,
            ),
          ),
        ),
      ),
    );
  }
}
