import 'package:flutter/material.dart';
import 'package:tugas_akhir_praktpm/Authentication/login.dart';
import 'package:tugas_akhir_praktpm/Music/music.dart';
import 'package:tugas_akhir_praktpm/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future getAccessToken() async {
    SharedPreferences pref = await _prefs;
    String? accessToken = pref.getString("accessToken");
    return accessToken;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tugas  Akhir',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: getAccessToken(),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.data != null) {
            return Home();
          } else {
            return Login();
          }
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
