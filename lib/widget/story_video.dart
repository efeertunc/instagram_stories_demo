import 'package:flutter/material.dart';
import 'package:instagram_stories_demo/provider/story_video_provider.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class StoryVideo extends StatefulWidget {
  final String videoURL;
  final VoidCallback? onLoaded;
  final Function(int duration)? onVideoDurationFetched;

  const StoryVideo({
    super.key,
    required this.videoURL,
    required this.onLoaded,
    this.onVideoDurationFetched,
  });

  @override
  _StoryVideoState createState() => _StoryVideoState();
}

class _StoryVideoState extends State<StoryVideo> {
  late StoryVideoProvider _storyVideoPlayerController;
  bool isLoadedCalled = false;
  bool isPlaying = false;

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
          if (!isLoadedCalled) {
            widget.onLoaded?.call();
            isLoadedCalled = true;
            final duration = _storyVideoPlayerController.getVideoDuration();
            if (duration != null) {
              widget.onVideoDurationFetched?.call(duration);
            }
          }
          isPlaying = true;
          return Center(
            child: AspectRatio(
              aspectRatio: storyProvider.controller.value.aspectRatio,
              child: VideoPlayer(storyProvider.controller),
            ),
          );
        }
        return isPlaying
            ? const SizedBox.shrink()
            : const CircularProgressIndicator();
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _storyVideoPlayerController.disposeProvider();
  }
}
