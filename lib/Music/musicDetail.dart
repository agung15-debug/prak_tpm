import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:tugas_akhir_praktpm/Music/HttpDependencies/ApiDataSource.dart';
import 'package:tugas_akhir_praktpm/Music/Models/lyricSummary.dart';
import 'package:tugas_akhir_praktpm/Music/Models/track.dart';

class DetailLyric extends StatefulWidget {
  final TrackDetail track;

  const DetailLyric({super.key, required this.track});

  @override
  State<DetailLyric> createState() => _DetailLyricState();
}

class _DetailLyricState extends State<DetailLyric> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF5F0BB),
        appBar: AppBar(
          backgroundColor: Color(0xFFB3C890),
          title: Text("Lyrics"),
        ),
        body: Center(
          child: FutureBuilder(
            future: ApiDataSource.instance.getSongLyric(widget.track.trackId),
            builder: (context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasError || widget.track.hasLyrics == false) {
                return _buildErrorSection();
              }
              if (snapshot.hasData) {
                LyricSummary model = LyricSummary.fromJson(snapshot.data);
                return _buildSuccessSection(model);
              }
              return _buildLoadingSection();
            },
          ),
        ));
  }

  Widget _buildErrorSection() {
    return Center(
        child: Text(
      "Error, Caused Either by data error or Track doesn't have lyrics registered",
      textAlign: TextAlign.center,
    ));
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(LyricSummary model) {
    Lyrics lyric = model.message!.body!.lyric;

    return ListView(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Column(children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Image.asset("assets/images/icon_music.png",
                  fit: BoxFit.cover),
            ),
            Text(
              widget.track.trackName,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black),
              textAlign: TextAlign.center,
            ),
            Text(
              widget.track.artistName,
              style: TextStyle(
                  fontWeight: FontWeight.w100,
                  fontSize: 15,
                  color: Colors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            Text(lyric.lyricsBody,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black)),
            SizedBox(
              height: 20,
            ),
          ]),
        ),
      ],
    );
  }
}
