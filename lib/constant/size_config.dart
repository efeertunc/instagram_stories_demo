import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SizeConfig {
  SizeConfig._();
  static SizeConfig? _instance;

  static SizeConfig get instance {
    if (_instance != null) {
      return _instance!;
    }
    _instance = SizeConfig._();
    return _instance!;
  }

  // StoryAvatar
  double heightStoryAvatar = 38.sp;
  double widthStoryAvatar = 38.sp;
  EdgeInsets marginStoryAvatar = EdgeInsets.all(8.sp);
  EdgeInsets paddingStoryAvatarImage = EdgeInsets.all(8.sp);
  EdgeInsets paddingStoryAvatarImageCircle = EdgeInsets.all(6.5.sp);

  // UserStoryView
  EdgeInsets paddingUserStoryViewProgressBar =
      EdgeInsets.fromLTRB(0.5.w, 5.h, 0.5.w, 0);
  EdgeInsets paddingUserStoryViewHeader = EdgeInsets.fromLTRB(2.w, 9.h, 0, 0);
  EdgeInsets paddingUserStoryViewHeaderImage =
      EdgeInsets.fromLTRB(2.w, 1.h, 2.w, 1.h);
}
