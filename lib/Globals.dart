import 'dart:io' show Platform;

import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;

import 'ListenHandler.dart';

late final ListenHandler _listenHandler;
late final AudioSession _session;

const String _fallback =
    "https://generic.ything.app/music/separation-185196.mp3";
final _urlSource = Uri.parse("https://generic.ything.app/music/player.url");
late final String _radioUrl;

Future<void> loadCurrentUrl() async {
  final resp = await http.get(_urlSource);
  if (resp.statusCode == 200) {
    _radioUrl = resp.body.trim();
    print('Loaded remote url');
  } else {
    _radioUrl = _fallback;
    print('Request for current streaming url failed, using fallback url');
  }
}

const String _fallbackAbout =
    "Ything Radio is an internet radio streaming application.";
final _urlAbout =
    Uri.parse("https://generic.ything.app/ything_radio/about.txt");

final _urlAboutIOS =
    Uri.parse("https://generic.ything.app/ything_radio/about_ios.txt");

late final String _remoteAbout;

Future<void> loadAboutUrl() async {
  final resp = await http.get(Platform.isIOS ? _urlAboutIOS : _urlAbout);

  if (resp.statusCode == 200) {
    _remoteAbout = resp.body;
    print('Loaded remote about');
  } else {
    _remoteAbout = _fallbackAbout;
    print('Request for remote about failed, using fallback about');
  }
}

String getAboutText() => _remoteAbout;

Future<void> setupListenHandler() async {
  _listenHandler = await AudioService.init(
    builder: () => ListenHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'net.ything.radio.channel.audio',
      androidNotificationChannelName: 'Ything Radio Playback',
    ),
  );
  _session = await AudioSession.instance;

  await _session.configure(const AudioSessionConfiguration.music());

  //TODO: Do I need to handle these events? audioplayers may be doing it already
  //_session.interruptionEventStream.listen((event) {
  //  if (event.begin) {
  //    switch (event.type) {
  //      case AudioInterruptionType.duck:
  //        _listenHandler.duck();
  //        break;
  //      case AudioInterruptionType.pause:
  //      case AudioInterruptionType.unknown:
  //        _listenHandler.pause();
  //        break;
  //    }
  //  } else {
  //    switch (event.type) {
  //      case AudioInterruptionType.duck:
  //        _listenHandler.unDuck();
  //        break;
  //      case AudioInterruptionType.pause:
  //        _listenHandler.play();
  //        break;
  //      case AudioInterruptionType.unknown:
  //        break;
  //    }
  //  }
  //});

  //_session.becomingNoisyEventStream.listen((_) {
  //  _listenHandler.pause();
  //});
}

ListenHandler getListenHandlder() => _listenHandler;

UrlSource getUrlSource() {
  return UrlSource(_radioUrl, mimeType: "audio/mpeg");
}

Future<bool> startAudioSession() async {
  return await _session.setActive(true);
}

Future<void> stopAudioSession() async {
  await _session.setActive(false);
}
