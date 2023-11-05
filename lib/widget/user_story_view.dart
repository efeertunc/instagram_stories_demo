import 'package:flutter/material.dart';
import 'package:instagram_stories_demo/model/Story.dart';
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
    _innerPageController = PageController();
    _innerPageController.addListener(_pageChanged);
    final currentIndex =
        Provider.of<CubePageControllerProvider>(context, listen: false)
                .userStoryIndices?[widget.user.username] ??
            0;
    Future.delayed(Duration.zero, () {
      _innerPageController.jumpToPage(currentIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.black,
        child: GestureDetector(
          onTapDown: (details) {
            final screenWidth = MediaQuery.of(context).size.width;
            if (details.localPosition.dx > screenWidth / 2) {
              onTapRight(context);
            } else {
              onTapLeft(context);
            }
          },
          child: Stack(
            children: [
              PageView.builder(
                  controller: _innerPageController,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: widget.user.stories?.length,
                  itemBuilder: (context, indexUserStory) {
                    return Stack(
                      children: [
                        Center(
                          child: Image.network(
                            widget.user.stories?[indexUserStory] ?? '',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Center(
                          child: Text(
                            'index $indexUserStory',
                            style: TextStyle(color: Colors.white, fontSize: 50),
                          ),
                        ),
                      ],
                    );
                  }),
              Text(
                widget.user.username ?? '',
                style: TextStyle(color: Colors.white, fontSize: 50),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _pageChanged() {
    Provider.of<CubePageControllerProvider>(context, listen: false)
            .userStoryIndices?[widget.user.username ?? ''] =
        _innerPageController.page!.toInt();
  }

  void onTapRight(BuildContext context) {
    if (_innerPageController.page == (widget.user.stories?.length ?? 1) - 1) {
      Provider.of<CubePageControllerProvider>(context, listen: false)
          .nextPage();
    } else {
      _innerPageController.nextPage(
          duration: Duration(milliseconds: 10), curve: Curves.ease);
    }
  }

  void onTapLeft(BuildContext context) {
    if (_innerPageController.page == 0) {
      Provider.of<CubePageControllerProvider>(context, listen: false)
          .previousPage();
    } else {
      _innerPageController.previousPage(
          duration: Duration(milliseconds: 10), curve: Curves.ease);
    }
  }

  @override
  void dispose() {
    _innerPageController.removeListener(
        _pageChanged); // Remove listener before disposing the controller
    _innerPageController.dispose(); // Dispose of the PageController
    super.dispose();
  }
}
