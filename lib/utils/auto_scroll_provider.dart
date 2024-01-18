import 'package:flutter/material.dart';

class AutoScrollProvider extends ChangeNotifier {
  final ScrollController scrollController = ScrollController();
  bool _autoScrolling = false;

  AutoScrollProvider() {
    // Adding a listener to react to user scrolls while auto-scrolling
    scrollController.addListener(_userScrollListener);
  }

  void _userScrollListener() {
    notifyListeners();
  }

  bool get isScrolling => _autoScrolling;

  void toggleAutoScroll() {
    if (isScrolling) {
      _stopAutoScroll();
      _autoScrolling = false;
    } else {
      _startAutoScroll();
      _autoScrolling = true;
    }
    notifyListeners();
  }

  void _startAutoScroll() async {
    final double endPosition = scrollController.position.maxScrollExtent;
    final double currentPosition = scrollController.position.pixels;
    final double positionDelta = endPosition - currentPosition;
    final Duration animDuration =
        Duration(milliseconds: (positionDelta * 100).round());

    await scrollController
        .animateTo(
      endPosition,
      duration: animDuration,
      curve: Curves.linear,
    )
        .then((_) {
      _autoScrolling = false;
      notifyListeners();
    });
  }

  void _stopAutoScroll() {
    scrollController.position.hold(() {});
  }
}
