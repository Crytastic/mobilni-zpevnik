import 'package:flutter/material.dart';

class AutoScrollProvider extends ChangeNotifier {
  final ScrollController scrollController = ScrollController();

  bool get isScrolling =>
      scrollController.hasClients &&
      scrollController.position.isScrollingNotifier.value;

  void toggleAutoScroll() {
    isScrolling ? _stopAutoScroll() : _startAutoScroll();
  }

  void _startAutoScroll() async {
    double endPosition = scrollController.position.maxScrollExtent;
    double currentPosition = scrollController.position.pixels;
    double positionDelta = endPosition - currentPosition;
    Duration animDuration =
        Duration(milliseconds: (positionDelta * 100).round());

    scrollController.animateTo(
      endPosition,
      duration: animDuration,
      curve: Curves.linear,
    );

    notifyListeners();
  }

  void _stopAutoScroll() {
    scrollController.position.hold(() {});
    notifyListeners();
  }
}
