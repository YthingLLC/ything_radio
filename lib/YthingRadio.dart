import 'package:flutter/material.dart';

import 'HomePage.dart';

class YthingRadio extends StatelessWidget {
  const YthingRadio({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ything Radio',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'Ything Radio'),
    );
  }
}
