import 'package:flutter/material.dart';
import 'package:instagram_stories_demo/constant/color_config.dart';
import 'package:instagram_stories_demo/constant/size_config.dart';

import '../model/Story.dart';

class StoryAvatar extends StatelessWidget {
  final Story? user;

  const StoryAvatar({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildAvatar(user?.profileUrl),
        _buildUsername(user?.username),
      ],
    );
  }

  Widget _buildAvatar(String? imageUrl) {
    return Container(
      width: SizeConfig.instance.widthStoryAvatar,
      height: SizeConfig.instance.heightStoryAvatar,
      margin: SizeConfig.instance.marginStoryAvatar,
      decoration: _outerGradientDecoration(),
      child: Padding(
        padding: SizeConfig.instance.paddingStoryAvatarImageCircle,
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Padding(
            padding: SizeConfig.instance.paddingStoryAvatarImage,
            child: _imageContainer(imageUrl),
          ),
        ),
      ),
    );
  }

  BoxDecoration _outerGradientDecoration() {
    return BoxDecoration(
      shape: BoxShape.circle,
      gradient: LinearGradient(
        colors: ColorConfig.instance.storyAvatarCircle,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    );
  }

  Widget _imageContainer(String? imageUrl) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
            color: ColorConfig.instance.storyAvatarUsername, width: 1),
      ),
      child: ClipOval(
        child: Image.network(
          imageUrl ?? '',
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _buildUsername(String? username) {
    return Text(
      username ?? '',
    );
  }
}
