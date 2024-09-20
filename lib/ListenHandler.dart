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
    _player.onPlayerStateChanged.listen((event) {
      print("Received audioplayers event: $event");

      switch (event) {
        case PlayerState.playing:
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
          break;
        case PlayerState.paused:
        case PlayerState.stopped:
        case PlayerState.completed:
        case PlayerState.disposed:
          super.playbackState.add(PlaybackState(
                controls: [],
                systemActions: {},
                playing: false,
              ));
          break;
      }
    });
  }

  ListenHandler() {
    setup_player();
  }

  bool isPlaying() => super.playbackState.value.playing;

  double _duckVol = 0;

  void duck() {
    //TODO: Confirm I need to do this manually, it looks like audioplayers already does this
    print("Duck requested");
    //_duckVol = _player.volume;

    //_player.setVolume(_duckVol - 0.4 > 0 ? _duckVol - 0.4 : 0.0);
  }

  void unDuck() {
    //TODO: Confirm I need to do this manually, it looks like audioplayers already does this
    print("Unduck requested");
    //_player.setVolume(_duckVol);
  }

  @override
  Future<void> play() async {
    if (await startAudioSession()) {
      _player.play(_radioSource, mode: PlayerMode.mediaPlayer);
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
