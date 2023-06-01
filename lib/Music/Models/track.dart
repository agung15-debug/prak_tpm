import 'package:hive/hive.dart';
part 'track.g.dart';

@HiveType(typeId: 1)
class TrackModel {
  @HiveField(0)
  final Message? message;

  TrackModel({
    required this.message,
  });

  TrackModel.fromJson(Map<String, dynamic> json)
      : message = (Message.fromJson(json['message']));

  Map<String, dynamic> toJson() => {
        'message': message,
      };
}

@HiveType(typeId: 2)
class Message {
  @HiveField(1)
  final Body? body;

  Message({required this.body});

  Message.fromJson(Map<String, dynamic> json)
      : body = Body.fromJson(json["body"]);
}

class Body {
  @HiveField(2)
  final List<Track> trackList;
  @HiveField(3)
  Body({required this.trackList});

  Body.fromJson(Map<String, dynamic> json)
      : trackList =
            (json["track_list"] as List).map((e) => Track.fromJson(e)).toList();

  Map<String, dynamic> toJson() => {
        'trackList': trackList.map((e) => e.toJson()).toList(),
      };
}

@HiveType(typeId: 3)
class Track {
  @HiveField(4)
  final TrackDetail trackDetail;
  @HiveField(5)
  Track({required this.trackDetail});

  Track.fromJson(Map<String, dynamic> json)
      : trackDetail = TrackDetail.fromJson(json["track"]);

  Map<String, dynamic> toJson() => {
        'trackDetail': trackDetail,
      };
}

@HiveType(typeId: 4)
class TrackDetail {
  @HiveField(6)
  final String trackId;
  @HiveField(7)
  final String trackName;
  @HiveField(8)
  final String artistId;
  @HiveField(9)
  final String artistName;
  @HiveField(10)
  final bool hasLyrics;

  TrackDetail({
    required this.trackId,
    required this.artistId,
    required this.trackName,
    required this.artistName,
    required this.hasLyrics,
  });

  TrackDetail.fromJson(Map<String, dynamic> json)
      : trackId = json["track_id"].toString(),
        artistId = json["artist_id"].toString(),
        trackName = json["track_name"],
        artistName = json["artist_name"],
        hasLyrics = (json["has_lyrics"] == 1) ? true : false;

  Map<String, dynamic> toJson() => {
        'trackId': trackId,
        'artistId': artistId,
        'trackName': trackName,
        'artistName': artistName,
        'hasLyrics': hasLyrics,
      };
}
