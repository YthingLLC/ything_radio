import 'package:audio_service/audio_service.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:ything_radio/Globals.dart';

class ListenHandler extends BaseAudioHandler {
  final _player = AudioPlayer();

  setup_player() {
    _player.setReleaseMode(ReleaseMode.release);

    _player.setSourceUrl(
      "https://generic.ything.app/music/separation-185196.mp3",
      mimeType: "audio/mpeg",
    );
  }

  ListenHandler() {
    setup_player();
  }

  @override
  Future<void> play() async {
    if (await startAudioSession()) {
      _player.resume();
    }
  }

  @override
  Future<void> pause() async {
    await stopAudioSession();
    _player.stop();
  }

  @override
  Future<void> stop() => pause();
}
