import 'dart:collection';
import 'package:json_annotation/json_annotation.dart';

part 'queue_set.g.dart';

@JsonSerializable()
class QueueSet<E> {
  final Queue<E> _queue = Queue();
  final Set<E> _set = Set();
  final int? maxLength;

  QueueSet(this.maxLength);

  void add(E element) {
    if (!_set.contains(element)) {
      _queue.add(element);
      _set.add(element);

      if (maxLength != null && _queue.length > maxLength!) {
        final removedElement = _queue.removeLast();
        _set.remove(removedElement);
      }
    } else {
      _queue.removeWhere((e) => e == element);
      _queue.add(element);
    }
  }

  E? remove() {
    if (_queue.isNotEmpty) {
      final element = _queue.removeLast();
      _set.remove(element);
      return element;
    }
    return null;
  }

  bool contains(E element) {
    return _queue.contains(element);
  }

  bool get isEmpty => _queue.isEmpty;

  int get length => _queue.length;

  void clear() {
    _queue.clear();
    _set.clear();
  }

  List<E> toList() {
    return _queue.toList();
  }

  factory QueueSet.fromJson(Map<String, dynamic> json) => _$QueueSetFromJson(json);

  Map<String, dynamic> toJson() => _$QueueSetToJson(this);
}
