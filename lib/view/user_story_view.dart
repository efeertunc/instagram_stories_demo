import 'package:flutter/material.dart';
import 'package:instagram_stories_demo/model/Story.dart';
import 'package:instagram_stories_demo/provider/story_video_provider.dart';
import 'package:instagram_stories_demo/widget/story_image.dart';
import 'package:instagram_stories_demo/widget/video_player.dart';
import 'package:provider/provider.dart';

import '../provider/cube_page_controller_provider.dart';

class UserStoryView extends StatefulWidget {
  final Story user;

  UserStoryView({
    required this.user,
  });

  @override
  _UserStoryViewState createState() => _UserStoryViewState();
}

class _UserStoryViewState extends State<UserStoryView> {
  late final PageController _innerPageController;

  @override
  void initState() {
    super.initState();
    _initializeController();
    _configureStoryListener();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _buildContainer(),
    );
  }

  Widget _buildContainer() {
    return Container(
      color: Colors.black,
      child: GestureDetector(
        onLongPress: _handleLongPressStart,
        onLongPressEnd: _handleLongPressEnd,
        onTapUp: _handleTapUp,
        child: Stack(
          children: [
            _buildPageView(),
            _buildUserNameText(),
          ],
        ),
      ),
    );
  }

  PageView _buildPageView() {
    return PageView.builder(
      controller: _innerPageController,
      physics: NeverScrollableScrollPhysics(),
      itemCount: widget.user.stories?.length,
      itemBuilder: _buildStoryPage,
    );
  }

  Widget _buildStoryPage(BuildContext context, int index) {
    String? storyUrl = widget.user.stories?[index];

    Widget storyWidget;
    if (storyUrl != null && storyUrl.endsWith('.mp4')) {
      storyWidget = StoryVideo(videoURL: storyUrl);
    } else {
      storyWidget = StoryImage(imageUrl: storyUrl);
    }

    return Stack(
      children: [
        Center(
          child: storyWidget,
        ),
        Center(
          child: Text(
            'index $index',
            style: TextStyle(color: Colors.white, fontSize: 50),
          ),
        ),
      ],
    );
  }

  Text _buildUserNameText() {
    return Text(
      widget.user.username ?? '',
      style: TextStyle(color: Colors.white, fontSize: 50),
    );
  }

  void _handleTapUp(TapUpDetails details) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (details.localPosition.dx > screenWidth / 2) {
      _onTapRight();
    } else {
      _onTapLeft();
    }
  }

  void _onTapRight() {
    if (_innerPageController.page == (widget.user.stories?.length ?? 1) - 1) {
      _moveToNextUser();
    } else {
      _moveToNextImage();
    }
  }

  void _onTapLeft() {
    if (_innerPageController.page == 0) {
      _moveToPreviousUser();
    } else {
      _moveToPreviousImage();
    }
  }

  void _initializeController() {
    _innerPageController = PageController();
  }

  void _configureStoryListener() {
    _innerPageController.addListener(_updateStoryIndex);
    final currentIndex = _getCurrentUserStoryIndex();
    Future.delayed(Duration.zero, () {
      _innerPageController.jumpToPage(currentIndex);
    });
  }

  void _moveToNextUser() {
    Provider.of<CubePageControllerProvider>(context, listen: false).nextPage();
  }

  void _moveToPreviousUser() {
    Provider.of<CubePageControllerProvider>(context, listen: false)
        .previousPage();
  }

  void _moveToNextImage() {
    _innerPageController.nextPage(
        duration: Duration(milliseconds: 10), curve: Curves.ease);
  }

  void _moveToPreviousImage() {
    _innerPageController.previousPage(
        duration: Duration(milliseconds: 10), curve: Curves.ease);
  }

  void _updateStoryIndex() {
    Provider.of<CubePageControllerProvider>(context, listen: false)
            .userStoryIndices?[widget.user.username ?? ''] =
        _innerPageController.page!.toInt();
  }

  int _getCurrentUserStoryIndex() {
    return Provider.of<CubePageControllerProvider>(context, listen: false)
            .userStoryIndices?[widget.user.username] ??
        0;
  }

  @override
  void dispose() {
    _disposeController();
    super.dispose();
  }

  void _disposeController() {
    _innerPageController.removeListener(_updateStoryIndex);
    _innerPageController.dispose();
  }

  void _handleLongPressStart() {
    Provider.of<StoryVideoProvider>(context, listen: false).pause();
  }

  void _handleLongPressEnd(LongPressEndDetails details) {
    Provider.of<StoryVideoProvider>(context, listen: false).resume();
  }
}
