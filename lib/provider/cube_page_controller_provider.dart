import 'package:flutter/material.dart';

class CubePageControllerProvider with ChangeNotifier {
  PageController? controller;
  Map<String, int>? userStoryIndices;

  void initialize() {
    controller = PageController();
    userStoryIndices = {};
  }

  void nextPage() {
    controller?.nextPage(
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  void previousPage() {
    controller?.previousPage(
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  void disposeProvider() {
    controller = null;
    userStoryIndices = null;
  }

  void jumpToPage(int pageIndex) {
    controller?.jumpToPage(pageIndex);
  }
}
