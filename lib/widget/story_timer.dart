import 'dart:async';

import 'package:flutter/material.dart';

class StoryTimer {
  int storyDuration;
  final Function() onStoryEnd;
  final Function? onStoryPause;
  final Function? onStoryResume;
  ValueNotifier<double> progressNotifier = ValueNotifier<double>(0);

  Timer? timer;
  int _elapsedTime = 0;

  StoryTimer({
    this.storyDuration = 5000,
    required this.onStoryEnd,
    this.onStoryPause,
    this.onStoryResume,
  });

  void updateDuration(int newDuration) {
    storyDuration = newDuration;
  }

  void start() {
    if (timer != null && timer!.isActive) timer!.cancel();

    final startTime =
        DateTime.now().subtract(Duration(milliseconds: _elapsedTime));

    timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      final elapsed = DateTime.now().difference(startTime).inMilliseconds;
      final progress = elapsed / storyDuration;
      progressNotifier.value = progress;
      if (progress >= 1) {
        timer.cancel();
        _elapsedTime = 0;
        onStoryEnd();
      }
    });
  }

  void pause() {
    if (timer != null && timer!.isActive) {
      _elapsedTime = (progressNotifier.value * storyDuration).toInt();
      timer!.cancel();
      if (onStoryPause != null) onStoryPause!();
    }
  }

  void resume() {
    start();
    if (onStoryResume != null) onStoryResume!();
  }

  void dispose() {
    if (timer != null && timer!.isActive) timer!.cancel();
  }

  void reset() {
    resetWithoutCallback();
    onStoryEnd();
  }

  void updateElapsedTime(int newElapsedTime) {
    _elapsedTime = newElapsedTime;
  }

  void resetWithoutCallback() {
    _elapsedTime = 0;
    storyDuration = 5000;
    timer?.cancel();
  }
}
