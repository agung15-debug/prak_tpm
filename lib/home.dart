import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas_akhir_praktpm/Authentication/Models/UserModel.dart';
import 'package:tugas_akhir_praktpm/Authentication/logout.dart';
import 'package:tugas_akhir_praktpm/Music/music.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  int _selectedOptions = 0;
  int _previousSelection = 0;

  String? username = "";
  String? email = "";
  String? accessToken = "";

  List<Widget> menu = [
    MusicLyrics(),
  ];

  @override
  void initState() {
    super.initState();
    _prefs.then((SharedPreferences value) {
      setState(() {
        username = value.getString('username');
        email = value.getString('email');
        accessToken = value.getString('accessToken');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tugas Akhir TPM"),
      ),
      body: menu[_selectedOptions],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.music_note), label: 'Lirik'),
          BottomNavigationBarItem(icon: Icon(Icons.logout), label: 'Logout'),
        ],
        onTap: (index) {
          setState(() {
            _previousSelection = _selectedOptions;
            _selectedOptions = index;

            if (_selectedOptions == 1) {
              _selectedOptions = _previousSelection;

              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Logout()));
            }
          });
        },
        selectedItemColor: Colors.blue,
        currentIndex: _selectedOptions,
        unselectedItemColor: Colors.grey,
      ),
      drawer: _buildDrawer(),
    );
  }

  //widget ini adalah isi dari sidebar atau drawer
  Widget _buildDrawer() {
    return SizedBox(
      //membuat menu drawer
      child: Drawer(
        //membuat list,
        //list digunakan untuk melakukan scrolling jika datanya terlalu panjang
        child: ListView(
          padding: EdgeInsets.zero,
          //di dalam listview ini terdapat beberapa widget drawable
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                foregroundImage: AssetImage("assets/images/avatar.jpg"),
                radius: 20,
              ),
              //membuat nama akun
              accountName:
                  (username == "") ? const Text("Undefined") : Text(username!),
              //membuat nama email
              accountEmail: Text(email!),
              //memberikan background
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://cdn.pixabay.com/photo/2016/04/24/20/52/laundry-1350593_960_720.jpg"),
                      fit: BoxFit.cover)),
            ),
          ],
        ),
      ),
    );
  }
}
