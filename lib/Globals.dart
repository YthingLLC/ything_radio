import 'package:audio_service/audio_service.dart';

import 'ListenHandler.dart';

late final ListenHandler _listenHandler;

Future<void> setupListenHandler() async {
  _listenHandler = await AudioService.init(
    builder: () => ListenHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'net.ything.radio.channel.audio',
      androidNotificationChannelName: 'Ything Radio Playback',
    ),
  );
}

ListenHandler getListenHandlder() => _listenHandler;
