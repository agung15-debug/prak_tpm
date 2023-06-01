import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tugas_akhir_praktpm/Music/musicDetail.dart';
import 'package:tugas_akhir_praktpm/local_storage/local_storage.dart';

import 'Music/Models/track.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  LocalStorage localStorage = LocalStorage();
  late Box box;

  void getInit() async {
    box = await localStorage.openBox();
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
        body: Column(
          children: [
            Flexible(
              child: FutureBuilder(
                future: localStorage.openBox(),
                builder: (context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasError) {
                    Text("Error");
                  }
                  if (snapshot.hasData) {
                    return Container(
                      child: ListView.builder(
                        itemCount: localStorage.getFavorite(box).length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailLyric(
                                      track:
                                          localStorage.getFavorite(box)[index]),
                                )),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 5),
                              child: Card(
                                color: Color(0xFFB3C890),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  localStorage
                                                      .getFavorite(box)[index]
                                                      .trackName,
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                width: 200,
                                                child: Text(
                                                    localStorage
                                                        .getFavorite(box)[index]
                                                        .artistName,
                                                    overflow:
                                                        TextOverflow.ellipsis),
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
                                                .contains(localStorage
                                                    .getFavorite(box)[index])) {
                                              localStorage.removeFromFavorite(
                                                  box,
                                                  localStorage
                                                      .getFavorite(box)[index]);
                                              SnackBar snackBar = SnackBar(
                                                content: Text(
                                                    "Removed from favorite"),
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            } else {
                                              localStorage.addToFavorite(
                                                  box,
                                                  localStorage
                                                      .getFavorite(box)[index]);
                                            }
                                          });
                                        },
                                        icon: Icon(localStorage
                                                .getFavorite(box)
                                                .contains(localStorage
                                                    .getFavorite(box)[index])
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
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
