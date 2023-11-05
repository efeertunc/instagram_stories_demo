import 'package:flutter/material.dart';
import 'package:instagram_stories_demo/provider/story_video_provider.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class StoryVideo extends StatefulWidget {
  String videoURL;

  StoryVideo({required this.videoURL, super.key});

  @override
  _StoryVideoState createState() => _StoryVideoState();
}

class _StoryVideoState extends State<StoryVideo> {
  late StoryVideoProvider _storyVideoPlayerController;

  @override
  void initState() {
    super.initState();
    _storyVideoPlayerController =
        Provider.of<StoryVideoProvider>(context, listen: false);
    _storyVideoPlayerController.initialize(widget.videoURL);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StoryVideoProvider>(
      builder: (context, storyProvider, child) {
        return Center(
          child: storyProvider.controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: storyProvider.controller.value.aspectRatio,
                  child: VideoPlayer(storyProvider.controller),
                )
              : Container(), // You can also show a loader here
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _storyVideoPlayerController.disposeProvider();
  }
}
