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

class _PlayControlsState extends State<PlayControls> {
  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
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
