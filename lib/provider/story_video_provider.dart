import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class StoryVideoProvider with ChangeNotifier {
  late VideoPlayerController controller;
  bool _isControllerInitialized = false;

  bool get isControllerInitialized => _isControllerInitialized;

  void initialize(String videoURL) {
    controller = VideoPlayerController.networkUrl(Uri.parse(videoURL))
      ..initialize().then((_) {
        _isControllerInitialized = true;
        notifyListeners();
        if (controller.value.isInitialized) {
          controller.play();
        }
      });
  }

  void pause() {
    if (isControllerInitialized && controller.value.isPlaying) {
      controller.pause();
      notifyListeners();
    }
  }

  void resume() {
    if (isControllerInitialized && !controller.value.isPlaying) {
      controller.play();
      notifyListeners();
    }
  }

  void disposeProvider() {
    if (isControllerInitialized) {
      controller.dispose();
    }
  }
}
