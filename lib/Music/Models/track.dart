import 'dart:convert';

class TrackModel {
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

class Message {
  final Body? body;

  Message({required this.body});

  Message.fromJson(Map<String, dynamic> json)
      : body = Body.fromJson(json["body"]);
}

class Body {
  final List<Track> trackList;
  Body({required this.trackList});

  Body.fromJson(Map<String, dynamic> json)
      : trackList =
            (json["track_list"] as List).map((e) => Track.fromJson(e)).toList();

  Map<String, dynamic> toJson() => {
        'trackList': trackList.map((e) => e.toJson()).toList(),
      };
}

class Track {
  final TrackDetail trackDetail;

  Track({required this.trackDetail});

  Track.fromJson(Map<String, dynamic> json)
      : trackDetail = TrackDetail.fromJson(json["track"]);

  Map<String, dynamic> toJson() => {
        'trackDetail': trackDetail,
      };
}

class TrackDetail {
  final String trackId;
  final String trackName;
  final String artistId;
  final String artistName;
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
