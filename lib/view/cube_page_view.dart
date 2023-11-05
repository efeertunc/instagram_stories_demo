import 'package:cube_transition_plus/cube_transition_plus.dart';
import 'package:flutter/material.dart';
import 'package:instagram_stories_demo/model/Story.dart';
import 'package:instagram_stories_demo/provider/cube_page_controller_provider.dart';
import 'package:instagram_stories_demo/view/user_story_view.dart';
import 'package:provider/provider.dart';

class PageViewCube extends StatefulWidget {
  final List<Story> homeCardModelList;
  final int? initialPage;

  const PageViewCube(this.homeCardModelList, {this.initialPage, Key? key})
      : super(key: key);

  @override
  _PageViewCubeState createState() => _PageViewCubeState();
}

class _PageViewCubeState extends State<PageViewCube> {
  late CubePageControllerProvider _cubePageControllerProvider;
  final GlobalKey _pageViewKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _cubePageControllerInitialize();
    _showStoriesSelectedUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: _buildCubePageView(context),
      ),
    );
  }

  CubePageView _buildCubePageView(BuildContext context) {
    return CubePageView.builder(
      key: _pageViewKey,
      controller:
          Provider.of<CubePageControllerProvider>(context, listen: false)
              .controller,
      itemCount: widget.homeCardModelList.length,
      itemBuilder: (context, index, notifier) {
        var user = widget.homeCardModelList[index];
        return _userStory(index, notifier, user);
      },
    );
  }

  CubeWidget _userStory(int index, double notifier, Story user) {
    return CubeWidget(
      index: index,
      pageNotifier: notifier,
      child: UserStoryView(user: user),
    );
  }

  void _showStoriesSelectedUser() {
    Future.delayed(Duration.zero, () {
      _cubePageControllerProvider.jumpToPage(widget.initialPage ?? 0);
    });
  }

  void _cubePageControllerInitialize() {
    _cubePageControllerProvider =
        Provider.of<CubePageControllerProvider>(context, listen: false);
    _cubePageControllerProvider.initialize();
  }

  @override
  void dispose() {
    _cubePageControllerProvider.disposeProvider();
    super.dispose();
  }
}
