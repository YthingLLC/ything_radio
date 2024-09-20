import 'package:audio_service/audio_service.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:ything_radio/Globals.dart';

class ListenHandler extends BaseAudioHandler {
  final _player = AudioPlayer();

  final UrlSource _radioSource = UrlSource(
      "https://generic.ything.app/music/separation-185196.mp3",
      mimeType: "audio/mpeg");

  setup_player() {
    _player.setReleaseMode(ReleaseMode.release);
  }

  ListenHandler() {
    setup_player();
  }

  bool isPlaying() => super.playbackState.value.playing;

  @override
  Future<void> play() async {
    if (await startAudioSession()) {
      _player.play(_radioSource, mode: PlayerMode.mediaPlayer);
      super.playbackState.add(PlaybackState(
            controls: [
              MediaControl.stop,
              MediaControl.pause,
            ],
            systemActions: {
              MediaAction.stop,
              MediaAction.pause,
            },
            playing: true,
          ));
    }
  }

  @override
  Future<void> pause() async {
    super.playbackState.add(PlaybackState(
          controls: [],
          systemActions: {},
          playing: false,
        ));
    await stopAudioSession();
    _player.stop();
  }

  @override
  Future<void> stop() => pause();
}
