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

  final ListenHandler _listenHandler = getListenHandlder();

  @override
  initState() {
    super.initState();

    print("Listen init");

    _listenHandler.playbackState.listen((PlaybackState state) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();

    _listenHandler.stop();
  }

  Future<void> playPause() async {
    print("playPause called");
    _listenHandler.isPlaying()
        ? await _listenHandler.stop()
        : await _listenHandler.play();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    print("Running build - Listen");

    return ClipOval(
      child: Material(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: InkWell(
          splashColor: Theme.of(context).colorScheme.onPrimaryContainer,
          onTap: () async {
            await playPause();
            setState(() {});
          },
          child: SizedBox(
            width: 100,
            height: 100,
            child: Icon(
              _listenHandler.isPlaying() ? Icons.stop : Icons.play_arrow,
              color: Colors.white,
              size: 50,
            ),
          ),
        ),
      ),
    );
  }
}
