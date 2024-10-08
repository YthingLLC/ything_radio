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

  bool _isLoading = false;

  final ListenHandler _listenHandler = getListenHandlder();

  @override
  initState() {
    super.initState();

    print("Listen init");

    _listenHandler.playbackState.listen((PlaybackState state) {
      print("Playback state changed");
      setState(() {
        //if state changed, we're no longer loading!
        //doesn't matter if we're playing or not!
        _isLoading = false;
      });
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
            if (_isLoading) {
              //skip doing anything else if we're still loading...
              return;
            }
            setState(() {
              if (!_listenHandler.isPlaying()) {
                _isLoading = true;
              }
            });
            await playPause();
          },
          child: SizedBox(
            width: 100,
            height: 100,
            child: Icon(
              _isLoading
                  ? Icons.hourglass_empty
                  : _listenHandler.isPlaying()
                      ? Icons.stop
                      : Icons.play_arrow,
              color: Colors.white,
              size: 50,
            ),
          ),
        ),
      ),
    );
  }
}
