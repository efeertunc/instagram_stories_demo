import 'package:flutter/material.dart';
import 'package:instagram_stories_demo/model/home_card_model.dart';
import 'package:instagram_stories_demo/widget/home_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final List<HomeCardModel> homeCardList;

  @override
  void initState() {
    homeCardList = [];
    homeCardList.add(HomeCardModel(1, "a", "efe", [
      'asset/images/story_1.jpg',
      'asset/images/story_2.jpg',
    ]));
    homeCardList.add(HomeCardModel(2, "b", "ahmet", [
      'asset/images/story_1.jpg',
      'asset/images/story_1.jpg',
    ]));
    homeCardList.add(HomeCardModel(3, "c", "mehmet", [
      'asset/images/story_1.jpg',
      'asset/images/story_1.jpg',
      'asset/images/story_1.jpg',
    ]));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Instagram"),
      ),
      body: Container(
        height: 50,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: homeCardList.length,
            itemBuilder: (context, index) {
              return HomeCard(index, homeCardList);
            }),
      ),
    );
  }
}
