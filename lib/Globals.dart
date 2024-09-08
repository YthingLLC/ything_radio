import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';

import 'ListenHandler.dart';

late final ListenHandler _listenHandler;
late final AudioSession _session;

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
}

ListenHandler getListenHandlder() => _listenHandler;

Future<bool> startAudioSession() async {
  return await _session.setActive(true);
}

Future<void> stopAudioSession() async {
  await _session.setActive(false);
}
