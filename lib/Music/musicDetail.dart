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
        appBar: AppBar(),
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
              child: Image.network(
                'https://w7.pngwing.com/pngs/250/419/png-transparent-musical-note-song-rectangle-logo-number-thumbnail.png',
              ),
            ),
            Text(
              widget.track.trackName,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            Text(
              widget.track.artistName,
              style: TextStyle(fontWeight: FontWeight.w100, fontSize: 15),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              lyric.lyricsBody,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
          ]),
        ),
      ],
    );
  }
}
