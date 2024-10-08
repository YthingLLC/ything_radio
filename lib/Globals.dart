import 'dart:io' show Platform;

import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;

import 'ListenHandler.dart';

late final ListenHandler _listenHandler;
late final AudioSession _session;

final _fallbackSource =
    Uri.parse("https://generic.ything.app/music/fallback.url");
final _urlSource = Uri.parse("https://generic.ything.app/music/player.url");

Future<String?> loadStringFromUrl(Uri remote) async {
  try {
    final resp = await http.get(remote);
    if (resp.statusCode == 200) {
      var ret = resp.body.trim();
      print('Loaded remote url: $remote - $ret');
      return ret;
    } else {
      print(
          'Request to load remote url: $remote - failed - Status Code: ${resp.statusCode} - Body: ${resp.body}');
      return null;
    }
  } catch (e) {
    print("Exception - unable to load remote url: $remote - $e");
    return null;
  }
}

const String _fallbackAbout =
    "Ything Radio is an internet radio streaming application.";
final _urlAbout =
    Uri.parse("https://generic.ything.app/ything_radio/about.txt");

final _urlAboutIOS =
    Uri.parse("https://generic.ything.app/ything_radio/about_ios.txt");

late final String _displayAbout;

Future<void> loadAboutUrl() async {
  final reqUrl = kIsWeb || !Platform.isIOS ? _urlAbout : _urlAboutIOS;

  var about = await loadStringFromUrl(reqUrl);

  if (about != null) {
    _displayAbout = about;
  } else {
    _displayAbout = _fallbackAbout;
  }
}

String getAboutText() => _displayAbout;

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

Future<Source> getSource({bool fallback = false}) async {
  var radioUrl = fallback == false
      ? await loadStringFromUrl(_urlSource)
      : await loadStringFromUrl(_fallbackSource);
  if (radioUrl != null) {
    return UrlSource(radioUrl, mimeType: "audio/mpeg");
  } else {
    return getInternetError();
  }
}

Source getInternetError() =>
    AssetSource("audio/internet_error.mp3", mimeType: "audio/mpeg");

Future<bool> startAudioSession() async {
  return await _session.setActive(true);
}

Future<void> stopAudioSession() async {
  await _session.setActive(false);
}
