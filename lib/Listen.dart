import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class Listen extends StatelessWidget {
  const Listen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: PlayControls(),
    );
  }
}

class PlayControls extends StatefulWidget {
  const PlayControls({super.key});

  @override
  State<PlayControls> createState() => _PlayControlsState();
}

class _PlayControlsState extends State<PlayControls>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  bool isPlaying = false;

  late final AudioPlayer player;

  //final ListenHandler _listenHandler = getListenHandlder();

  final UrlSource _radioSource = UrlSource(
      "https://generic.ything.app/music/separation-185196.mp3",
      mimeType: "audio/mpeg");

  @override
  initState() {
    super.initState();

    print("Listen init");

    //_listenHandler.playbackState.listen((PlaybackState event) {
    //  if (isPlaying == event.playing) {
    //    print("State unchanged, skipping setState()");
    //    return;
    //  }
    //  setState(() {
    //    isPlaying = event.playing;
    //    print("Updated playing state to $isPlaying");
    //  });
    //});

    player = AudioPlayer();

    player.setReleaseMode(ReleaseMode.release);

    //player
    //    .setSourceUrl("https://generic.ything.app/music/separation-185196.mp3");
  }

  @override
  void dispose() {
    super.dispose();

    //player.stop();

    //player.dispose();

    //_listenHandler.stop();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    print("Running build - Listen");

    if (isPlaying) {
      player.play(_radioSource, mode: PlayerMode.mediaPlayer);
      //player.resume();
      //_listenHandler.play();
      //_listenHandler.playbackState.add(PlaybackState(
      //  controls: [
      //    MediaControl.stop,
      //    MediaControl.pause,
      //  ],
      //  systemActions: {
      //    MediaAction.stop,
      //    MediaAction.pause,
      //  },
      //  playing: true,
      //));
    } else {
      player.stop();
      //_listenHandler.stop();
      //_listenHandler.playbackState.add(PlaybackState(
      //  controls: [],
      //  systemActions: {},
      //  playing: false,
      //));
    }
    return ClipOval(
      child: Material(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: InkWell(
          splashColor: Theme.of(context).colorScheme.onPrimaryContainer,
          onTap: () {
            setState(() {
              isPlaying = !isPlaying;
            });
          },
          child: SizedBox(
            width: 100,
            height: 100,
            child: Icon(
              isPlaying ? Icons.stop : Icons.play_arrow,
              color: Colors.white,
              size: 50,
            ),
          ),
        ),
      ),
    );
  }
}
