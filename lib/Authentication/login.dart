import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:tugas_akhir_praktpm/Authentication/HttpDependencies/ApiDataSource.dart';
import 'package:tugas_akhir_praktpm/Authentication/Models/UserModel.dart';
import 'package:tugas_akhir_praktpm/Authentication/register.dart';
import 'package:tugas_akhir_praktpm/home.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Map<String, dynamic> loginStatus = {};

  void login() async {
    try {
      var passwordbytes = utf8.encode(passwordController.text);
      var passwordHash = sha256.convert(passwordbytes).toString();

      dynamic res = await ApiDataSource.instance
          .login({"email": emailController.text, "password": passwordHash});

      if (res["message"] == "Login success") {
        Model data = Model.fromJson(res);

        SharedPreferences pref = await _prefs;
        pref.setString('accessToken', data.data.accessToken);
        pref.setString('username', data.data.user.name);
        pref.setString('email', data.data.user.email);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login Gagal'),
            duration: Duration(seconds: 1),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          height: 500,
          width: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 120,
                width: 120,
                margin: const EdgeInsets.symmetric(vertical: 50),
                child: Image.asset('assets/images/hero.png'),
              ),
              SizedBox(
                  height: 220,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextField(
                        controller: emailController,
                        style: const TextStyle(fontSize: 15),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          hintText: "Email",
                        ),
                      ),
                      TextField(
                        controller: passwordController,
                        style: TextStyle(fontSize: 15),
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          hintText: "Password",
                        ),
                      ),
                      ElevatedButton(
                        onPressed: login,
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 50),
                          child: Text("Login"),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Didn't have any account?",
                            style: TextStyle(color: Colors.grey),
                          ),
                          TextButton(
                              onPressed: () => {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Register()))
                                  },
                              child: const Text(
                                "Register",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ))
                        ],
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
