import 'package:flutter/material.dart';

import 'Globals.dart';
import 'YthingRadio.dart';

Future<void> main() async {
  await setupListenHandler();
  runApp(const YthingRadio());
}
