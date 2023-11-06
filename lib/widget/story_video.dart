import 'package:flutter/material.dart';
import 'package:instagram_stories_demo/provider/story_video_provider.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class StoryVideo extends StatefulWidget {
  final String videoURL;
  final VoidCallback? onLoaded;

  const StoryVideo({required this.videoURL, this.onLoaded, Key? key})
      : super(key: key);

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
        if (storyProvider.controller.value.hasError) {
          return Center(
            child: Text(
                'Bir hata oluştu: ${storyProvider.controller.value.errorDescription}'),
          );
        }

        if (storyProvider.controller.value.isInitialized) {
          widget.onLoaded?.call();
          return Center(
            child: AspectRatio(
              aspectRatio: storyProvider.controller.value.aspectRatio,
              child: VideoPlayer(storyProvider.controller),
            ),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _storyVideoPlayerController.disposeProvider();
  }
}
