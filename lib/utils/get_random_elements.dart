import 'package:collection/collection.dart';

List<T> getRandomElements<T>(int n, List<T> source) => source.sample(n);
