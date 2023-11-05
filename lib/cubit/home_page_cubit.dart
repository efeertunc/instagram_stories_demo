import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_stories_demo/repo/story_repository.dart';
import 'package:instagram_stories_demo/state/home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(HomePageStateInitial());

  var repo = StoryRepository();

  Future<void> getStories() async {
    emit(HomePageStateLoading());
    try {
      var state = await repo.getStories();
      if (state is HomePageStateSuccess) {
        emit(HomePageStateSuccess(state.data));
      } else if (state is HomePageStateFailure) {
        emit(HomePageStateFailure(state.error));
      }
    } catch (e) {
      emit(HomePageStateFailure(e.toString()));
    }
  }
}
