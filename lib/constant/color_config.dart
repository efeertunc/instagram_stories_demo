import 'package:flutter/material.dart';

class ColorConfig {
  ColorConfig._();
  static ColorConfig? _instance;

  static ColorConfig get instance {
    if (_instance != null) {
      return _instance!;
    }
    _instance = ColorConfig._();
    return _instance!;
  }

  // StoryAvatar
  List<Color> storyAvatarCircle = [
    const Color.fromRGBO(243, 18, 119, 1.0),
    const Color.fromRGBO(129, 52, 175, 1.0),
    const Color.fromRGBO(236, 28, 117, 1.0),
    const Color.fromRGBO(245, 133, 41, 1.0),
    const Color.fromRGBO(254, 218, 119, 1.0),
  ];
  Color storyAvatarUsername = Colors.grey;

  // UserStoryView
  Color userStoryViewBackgraundColor = Colors.black;
  Color userStoryViewProgressBarBackgroundColor = Colors.grey.withOpacity(0.5);
  Color userStoryViewHeaderUsernameColor = Colors.white;
  Color userStoryViewHeaderIconColor = Colors.white;
  AlwaysStoppedAnimation<Color> userStoryViewProgressBarValueColor =
      const AlwaysStoppedAnimation<Color>(Colors.white);

  // CubePageView
  Color cubePageViewBackgroundColor = Colors.black;
}
