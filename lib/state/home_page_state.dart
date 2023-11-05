import 'package:instagram_stories_demo/model/Story.dart';

abstract class HomePageState {}

class HomePageStateInitial extends HomePageState {}

class HomePageStateLoading extends HomePageState {}

class HomePageStateSuccess extends HomePageState {
  final List<Story> data;

  HomePageStateSuccess(this.data);
}

class HomePageStateFailure extends HomePageState {
  final String error;

  HomePageStateFailure(this.error);
}
