import 'package:flutter/material.dart';
import 'package:instagram_stories_demo/model/home_card_model.dart';
import 'package:instagram_stories_demo/widget/cube_page_view.dart';

class HomeCard extends StatelessWidget {
  final List<HomeCardModel> homeCardModelList;
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
      child: Card(
        elevation: 2,
        child: Text(homeCardModelList[index].username ?? ''),
      ),
    );
  }
}
