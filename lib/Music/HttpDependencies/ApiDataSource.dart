import 'BaseNetwork.dart';

class ApiDataSource {
  static ApiDataSource instance = ApiDataSource();

  Future<Map<String, dynamic>> trackSearchBySong(String songName) {
    String url = "track.search?q_track=" + songName;
    return BaseNetwork.get(url);
  }

  Future<Map<String, dynamic>> trackSearchByArtist(String artistName) {
    String url = "track.search?q_artist=" + artistName;
    return BaseNetwork.get(url);
  }

  Future<Map<String, dynamic>> getSongLyric(String trackId) {
    String url = "track.lyrics.get?track_id=" + trackId;
    return BaseNetwork.get(url);
  }

  Future<Map<String, dynamic>> getSongChart() {
    String url =
        "chart.tracks.get?chart_name=hot&page=1&page_size=5&country=it&f_has_lyrics=1";
    return BaseNetwork.get(url);
  }
}
