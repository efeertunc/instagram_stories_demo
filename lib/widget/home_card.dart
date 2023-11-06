import 'package:flutter/material.dart';
import 'package:instagram_stories_demo/model/Story.dart';
import 'package:instagram_stories_demo/view/cube_page_view.dart';
import 'package:instagram_stories_demo/widget/story_avatar.dart';

class HomeCard extends StatelessWidget {
  final List<Story> homeCardModelList;
  final int index;

  const HomeCard(this.index, this.homeCardModelList, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PageViewCube(homeCardModelList, initialPage: index)),
          );
        },
        child: StoryAvatar(user: homeCardModelList[index]));
  }
}
