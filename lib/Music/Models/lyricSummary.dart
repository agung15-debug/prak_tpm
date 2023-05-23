class LyricSummary {
  final Message? message;

  LyricSummary({
    required this.message,
  });

  LyricSummary.fromJson(Map<String, dynamic> json)
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
  final Lyrics lyric;
  Body({required this.lyric});

  Body.fromJson(Map<String, dynamic> json)
      : lyric = Lyrics.fromJson(json["lyrics"]);

  Map<String, dynamic> toJson() => {
        'lyric': lyric,
      };
}

class Lyrics {
  final String lyricsId;
  final String lyricsBody;

  Lyrics({
    required this.lyricsId,
    required this.lyricsBody,
  });

  Lyrics.fromJson(Map<String, dynamic> json)
      : lyricsId = json["lyrics_id"].toString(),
        lyricsBody = json["lyrics_body"];
}
