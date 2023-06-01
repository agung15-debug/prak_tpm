import 'package:hive/hive.dart';
import 'package:tugas_akhir_praktpm/Music/Models/track.dart';
import 'package:tugas_akhir_praktpm/local_storage/base_local_storage.dart';

class LocalStorage extends BaseLocalStorage {
  String boxName = 'favorite_music';
  @override
  Future<Box> openBox() async {
    Box box = await Hive.openBox<TrackDetail>(boxName);
    return box;
  }

  @override
  List<TrackDetail> getFavorite(Box box) {
    return box.values.toList() as List<TrackDetail>;
  }

  @override
  Future<void> addToFavorite(Box box, TrackDetail track) async {
    await box.put(track.trackId, track);
  }

  @override
  Future<void> removeFromFavorite(Box box, TrackDetail track) async {
    await box.delete(track.trackId);
  }

  @override
  Future<void> clearFavorite(Box box) async {
    await box.clear();
  }
}
