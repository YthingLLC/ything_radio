import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';

import 'Globals.dart';
import 'ListenHandler.dart';

class Listen extends StatelessWidget {
  const Listen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/app-background.jpg'),
          fit: BoxFit.cover,
          opacity: 0.4,
        ),
      ),
      child: const Center(
        child: PlayControls(),
      ),
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

  final ListenHandler _listenHandler = getListenHandlder();

  @override
  initState() {
    super.initState();

    print("Listen init");

    _listenHandler.playbackState.listen((PlaybackState event) {
      if (isPlaying == event.playing) {
        print("State unchanged, skipping setState()");
        return;
      }
      setState(() {
        isPlaying = event.playing;
        print("Updated playing state to $isPlaying");
      });
    });
  }

  @override
  void dispose() {
    super.dispose();

    _listenHandler.stop();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    print("Running build - Listen");

    if (isPlaying) {
      _listenHandler.play();
      _listenHandler.playbackState.add(PlaybackState(
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
    } else {
      _listenHandler.stop();
      _listenHandler.playbackState.add(PlaybackState(
        controls: [],
        systemActions: {},
        playing: false,
      ));
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
