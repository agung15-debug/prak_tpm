import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tugas_akhir_praktpm/Music/HttpDependencies/ApiDataSource.dart';
import 'package:tugas_akhir_praktpm/Music/Models/track.dart';
import 'package:tugas_akhir_praktpm/Music/musicDetail.dart';
import 'package:tugas_akhir_praktpm/local_storage/local_storage.dart';

class MusicLyrics extends StatefulWidget {
  const MusicLyrics({super.key});

  @override
  State<MusicLyrics> createState() => _MusicLyricsState();
}

class _MusicLyricsState extends State<MusicLyrics> {
  TextEditingController searchController = TextEditingController();
  String search = "";
  String terms = "";
  List<bool> _selections = [true, false];
  LocalStorage localStorage = LocalStorage();
  late Box box;
  bool isFavorite = false;

  void getInit() async {
    box = await localStorage.openBox();
    print(await localStorage.getFavorite(box));
  }

  @override
  void initState() {
    getInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F0BB),
      body: Container(
          child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 7 / 8,
            height: 60,
            alignment: Alignment.center,
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Color(0xFF73A9AD)),
                suffix: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF73A9AD)),
                  child: Text("Search"),
                  onPressed: () {
                    setState(() {
                      search = searchController.text;
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: Color(0xFF73A9AD), width: 2.0)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: Color(0xFF73A9AD), width: 2.0)),
                hintText: 'Enter a search term',
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          ToggleButtons(
              color: Color(0xFF73A9AD),
              selectedBorderColor: Color(0xFF73A9AD),
              selectedColor: Colors.white,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Track',
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text('Artist'),
                ),
              ],
              isSelected: _selections,
              onPressed: (index) {
                setState(() {
                  for (int buttonIndex = 0;
                      buttonIndex < _selections.length;
                      buttonIndex++) {
                    if (buttonIndex == index) {
                      _selections[buttonIndex] = true;
                    } else {
                      _selections[buttonIndex] = false;
                    }
                  }
                });
              }),
          SizedBox(
            height: 15,
          ),
          Flexible(
            child: FutureBuilder(
              future: (_selections[0] == true)
                  ? ApiDataSource.instance.trackSearchBySong(search)
                  : ApiDataSource.instance.trackSearchByArtist(search),
              builder: (context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasError) {
                  return _buildErrorSection();
                }
                if (snapshot.hasData) {
                  TrackModel model = TrackModel.fromJson(snapshot.data);

                  // print(model.message!.body!.trackList![0].trackDetail);

                  return _buildSuccessSection(model);
                }
                return _buildLoadingSection();
              },
            ),
          )
        ],
      )),
    );
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(TrackModel model) {
    List<Track> list = model.message!.body!.trackList;

    return Container(
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DetailLyric(track: list[index].trackDetail),
                )),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              child: Card(
                color: Color(0xFFB3C890),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Container(
                            width: 100,
                            child: Image.asset(
                              'assets/images/icon_music.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(list[index].trackDetail.trackName,
                                  style: TextStyle(fontSize: 12),
                                  overflow: TextOverflow.ellipsis),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: 200,
                                child: Text(list[index].trackDetail.artistName,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ],
                          )),
                        ],
                      ),
                    ),
                    IconButton(
                        onPressed: () async {
                          setState(() {
                            if (localStorage
                                .getFavorite(box)
                                .contains(list[index].trackDetail)) {
                              localStorage.removeFromFavorite(
                                  box, list[index].trackDetail);
                              SnackBar snackBar = SnackBar(
                                content: Text("Removed from favorite"),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              localStorage.addToFavorite(
                                  box, list[index].trackDetail);
                              SnackBar snackBar = SnackBar(
                                content: Text("Add to favorite"),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          });
                        },
                        icon: Icon(localStorage
                                .getFavorite(box)
                                .contains(list[index].trackDetail)
                            ? Icons.favorite
                            : Icons.favorite_border))
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
