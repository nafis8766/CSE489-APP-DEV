import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioScreen extends StatefulWidget {
  @override
  _AudioScreenState createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {

  late AudioPlayer player;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
  }

  Future<void> toggleAudio() async {
    if (isPlaying) {
      await player.pause();
      setState(() {
        isPlaying = false;
      });
    } else {
      await player.play(
        UrlSource(
          "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3",
        ),
      );
      setState(() {
        isPlaying = true;
      });
    }
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: toggleAudio,
        child: Text(isPlaying ? "Pause Audio" : "Play Audio"),
      ),
    );
  }
}