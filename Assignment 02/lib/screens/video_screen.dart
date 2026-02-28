import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {

  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    )
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: controller.value.isInitialized
          ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: VideoPlayer(controller),
          ),
          ElevatedButton(
            onPressed: () {
              controller.value.isPlaying
                  ? controller.pause()
                  : controller.play();
            },
            child: Text("Play/Pause"),
          )
        ],
      )
          : CircularProgressIndicator(),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}