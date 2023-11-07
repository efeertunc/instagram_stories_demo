import 'package:flutter/material.dart';
import 'package:instagram_stories_demo/constant/color_config.dart';
import 'package:instagram_stories_demo/constant/size_config.dart';
import 'package:instagram_stories_demo/model/Story.dart';
import 'package:instagram_stories_demo/provider/story_video_provider.dart';
import 'package:instagram_stories_demo/widget/story_image.dart';
import 'package:instagram_stories_demo/widget/story_timer.dart';
import 'package:instagram_stories_demo/widget/story_video.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../provider/cube_page_controller_provider.dart';

class UserStoryView extends StatefulWidget {
  final Story user;

  const UserStoryView({
    super.key,
    required this.user,
  });

  @override
  _UserStoryViewState createState() => _UserStoryViewState();
}

class _UserStoryViewState extends State<UserStoryView> {
  late final PageController _innerPageController;
  late final StoryTimer _storyTimer;

  @override
  void initState() {
    super.initState();
    _storyTimer = StoryTimer(
      onStoryEnd: _onTapRight,
    );

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
      color: ColorConfig.instance.userStoryViewBackgraundColor,
      child: GestureDetector(
        onLongPress: _handleLongPressStart,
        onLongPressEnd: _handleLongPressEnd,
        onTapUp: _handleTapUp,
        onVerticalDragEnd: _handleVerticalDrag,
        child: Stack(
          children: [
            _buildPageView(),
            _buildHeaderStory(),
            _buildProgressBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    return Positioned(
      top: 3.h,
      left: 0,
      right: 0,
      child: Row(
        children: List.generate(
          widget.user.stories?.length ?? 0,
          (index) => _individualProgressBar(index),
        ).toList(),
      ),
    );
  }

  Expanded _individualProgressBar(int index) {
    return Expanded(
      child: Padding(
        padding: SizeConfig.instance.paddingUserStoryViewProgressBar,
        child: ValueListenableBuilder<double>(
          valueListenable: _storyTimer.progressNotifier,
          builder: (context, progress, child) {
            final currentPage = _innerPageController.page;
            if (currentPage == null) return const SizedBox.shrink();
            return SizedBox(
              height: 2.0,
              child: LinearProgressIndicator(
                value: index == currentPage.toInt()
                    ? progress
                    : index < currentPage.toInt()
                        ? 1
                        : 0,
                backgroundColor: ColorConfig
                    .instance.userStoryViewProgressBarBackgroundColor,
                valueColor:
                    ColorConfig.instance.userStoryViewProgressBarValueColor,
              ),
            );
          },
        ),
      ),
    );
  }

  PageView _buildPageView() {
    return PageView.builder(
      controller: _innerPageController,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.user.stories?.length,
      itemBuilder: _buildStoryPage,
    );
  }

  Widget _buildStoryPage(BuildContext context, int index) {
    String? storyUrl = widget.user.stories?[index];

    Widget storyWidget;
    if (storyUrl != null && storyUrl.endsWith('.mp4')) {
      storyWidget = StoryVideo(
        videoURL: storyUrl,
        onLoaded: () {
          _storyTimer.start();
        },
        onVideoDurationFetched: (duration) {
          _storyTimer.updateDuration(duration);
        },
      );
    } else {
      storyWidget = StoryImage(
        imageUrl: storyUrl,
        onLoaded: () {
          _storyTimer.start();
        },
      );
    }
    return Stack(
      children: [
        Center(
          child: storyWidget,
        ),
      ],
    );
  }

  Padding _buildHeaderStory() {
    return Padding(
      padding: SizeConfig.instance.paddingUserStoryViewHeader,
      child: SizedBox(
        height: 50,
        child: Row(
          children: [
            Padding(
                padding: SizeConfig.instance.paddingUserStoryViewHeaderImage,
                child: ClipOval(
                    child: Image.network(widget.user.profileUrl ?? ""))),
            Text(
              widget.user.username ?? '',
              style: TextStyle(
                  color: ColorConfig.instance.userStoryViewHeaderUsernameColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close),
              color: ColorConfig.instance.userStoryViewHeaderIconColor,
            )
          ],
        ),
      ),
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

  void _handleVerticalDrag(DragEndDetails details) {
    if (details.velocity.pixelsPerSecond.dy > 500) {
      Navigator.of(context).pop();
    }
  }

  void _onTapRight() {
    if (!mounted) return;

    _storyTimer.resetWithoutCallback();
    if (_innerPageController.page == (widget.user.stories?.length ?? 1) - 1) {
      _moveToNextUser();
    } else {
      _moveToNextImage();
    }
  }

  void _onTapLeft() {
    if (!mounted) return;

    _storyTimer.resetWithoutCallback();
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
        duration: const Duration(milliseconds: 10), curve: Curves.ease);
  }

  void _moveToPreviousImage() {
    _innerPageController.previousPage(
        duration: const Duration(milliseconds: 10), curve: Curves.ease);
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
    _storyTimer.dispose();
    super.dispose();
  }

  void _disposeController() {
    _innerPageController.removeListener(_updateStoryIndex);
    _innerPageController.dispose();
  }

  void _handleLongPressStart() {
    if (_isCurrentStoryVideo()) {
      final videoDuration =
          Provider.of<StoryVideoProvider>(context, listen: false)
              .getCurrentPosition();
      _storyTimer.updateElapsedTime(videoDuration);
      Provider.of<StoryVideoProvider>(context, listen: false).pause();
    }
    _storyTimer.pause();
  }

  void _handleLongPressEnd(LongPressEndDetails details) {
    if (_isCurrentStoryVideo()) {
      Provider.of<StoryVideoProvider>(context, listen: false).resume();
    }
    _storyTimer.resume();
  }

  bool _isCurrentStoryVideo() {
    int? currentIndex = _innerPageController.page?.toInt();
    String? storyUrl = widget.user.stories?[currentIndex ?? 0];
    return storyUrl != null && storyUrl.endsWith('.mp4');
  }
}
