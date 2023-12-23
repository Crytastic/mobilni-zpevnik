import 'package:get_it/get_it.dart';
import 'package:mobilni_zpevnik/service/song_service.dart';

class IoCContainer {
  static void setup() {
    GetIt.I.registerSingleton(SongService());
  }
}
