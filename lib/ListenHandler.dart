import 'package:audio_service/audio_service.dart';
import 'package:audioplayers/audioplayers.dart';

class ListenHandler extends BaseAudioHandler {
  final _player = AudioPlayer();

  setup_player() {
    _player.setReleaseMode(ReleaseMode.release);

    _player
        .setSourceUrl("https://generic.ything.app/music/separation-185196.mp3");
  }

  ListenHandler() {
    setup_player();
  }

  @override
  Future<void> play() => _player.resume();

  @override
  Future<void> pause() => _player.stop();

  @override
  Future<void> stop() => _player.stop();
}
