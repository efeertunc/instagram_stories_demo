import 'package:cube_transition_plus/cube_transition_plus.dart';
import 'package:flutter/material.dart';
import 'package:instagram_stories_demo/model/home_card_model.dart';
import 'package:instagram_stories_demo/provider/cube_page_controller_provider.dart';
import 'package:instagram_stories_demo/widget/user_story_view.dart';
import 'package:provider/provider.dart';

class PageViewCube extends StatefulWidget {
  final List<HomeCardModel> homeCardModelList;
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
    _cubePageControllerProvider =
        Provider.of<CubePageControllerProvider>(context, listen: false);
    _cubePageControllerProvider.initialize();

    Future.delayed(Duration.zero, () {
      _cubePageControllerProvider.jumpToPage(widget.initialPage ?? 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: CubePageView.builder(
          key: _pageViewKey,
          controller:
              Provider.of<CubePageControllerProvider>(context, listen: false)
                  .controller,
          itemCount: widget.homeCardModelList.length,
          itemBuilder: (context, index, notifier) {
            print(index);
            var user = widget.homeCardModelList[index];
            return CubeWidget(
              index: index,
              pageNotifier: notifier,
              child: UserStoryView(user: user),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cubePageControllerProvider.disposeProvider();
    super.dispose();
  }
}
