import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_stories_demo/model/Story.dart';
import 'package:instagram_stories_demo/state/home_page_state.dart';

class StoryRepository {
  final storyCollection = FirebaseFirestore.instance.collection('story');

  Future<HomePageState> getStories() async {
    try {
      var snapshot = await storyCollection.get();
      return HomePageStateSuccess(
          snapshot.docs.map((doc) => Story.fromJson(doc.data())).toList());
    } catch (e) {
      return HomePageStateFailure(e.toString());
    }
  }
}
