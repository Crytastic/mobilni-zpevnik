import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AutoScrollProvider extends ChangeNotifier {
  final ScrollController scrollController = ScrollController();
  int _scrollSpeed = 3;
  bool _autoScrolling = false;

  AutoScrollProvider() {
    // Adding a listener to react to user scrolls while auto-scrolling
    scrollController.addListener(_userScrollListener);
  }

  void _userScrollListener() {
    final userScrolling =
        scrollController.position.userScrollDirection != ScrollDirection.idle;
    if (userScrolling) {
      _autoScrolling = false;
    }
    notifyListeners();
  }

  bool get isScrolling => _autoScrolling;

  int get scrollSpeed => _scrollSpeed;

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
        Duration(milliseconds: (positionDelta / _scrollSpeed).round() * 200);

    if (!scrollController.hasClients) {
      return;
    }

    await scrollController
        .animateTo(
      endPosition,
      duration: animDuration,
      curve: Curves.linear,
    )
        .then((_) {
      if (scrollController.position.pixels >= endPosition) {
        _autoScrolling = false;
        notifyListeners();
      }
    });
  }

  void _stopAutoScroll() {
    scrollController.position.hold(() {});
  }

  /// Updates auto scroll speed
  /// Reasonable values are 1-10
  void updateAutoScrollSpeed(int newSpeed) {
    _scrollSpeed = newSpeed;
    if (_autoScrolling) {
      // restart scroll animation with new speed
      _startAutoScroll();
      _autoScrolling = true;
      notifyListeners();
    }
  }

  /// Increase auto scroll speed
  void increaseAutoScrollSpeed() {
    if (_scrollSpeed < 10) {
      updateAutoScrollSpeed(_scrollSpeed + 1);
    }
  }

  /// Decrease auto scroll speed
  void decreaseAutoScrollSpeed() {
    if (_scrollSpeed > 1) {
      updateAutoScrollSpeed(_scrollSpeed - 1);
    }
  }
}
