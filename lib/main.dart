import 'package:flutter/material.dart';

import 'Globals.dart';
import 'YthingRadio.dart';

Future<void> main() async {
  await loadCurrentUrl();
  await loadAboutUrl();
  await setupListenHandler();
  runApp(const YthingRadio());
}
