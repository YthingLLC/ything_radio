import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'Globals.dart';
import 'YthingRadio.dart';

Future<void> main() async {
  AudioLogger.logLevel = AudioLogLevel.info;
  await loadAboutUrl();
  await setupListenHandler();
  runApp(const YthingRadio());
}
