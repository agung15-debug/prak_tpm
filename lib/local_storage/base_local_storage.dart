import 'package:hive_flutter/hive_flutter.dart';
import 'package:tugas_akhir_praktpm/Music/Models/track.dart';

abstract class BaseLocalStorage {
  Future<Box> openBox();
  List<TrackDetail> getFavorite(Box box);
  Future<void> addToFavorite(Box box, TrackDetail track);
  Future<void> removeFromFavorite(Box box, TrackDetail track);
  Future<void> clearFavorite(Box box);
}
