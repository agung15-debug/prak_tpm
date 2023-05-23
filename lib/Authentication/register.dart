import 'dart:convert';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:tugas_akhir_praktpm/Authentication/HttpDependencies/ApiDataSource.dart';
import 'package:tugas_akhir_praktpm/Authentication/Models/UserModel.dart';
import 'package:tugas_akhir_praktpm/Authentication/login.dart';
import 'package:tugas_akhir_praktpm/home.dart';
import 'package:crypto/crypto.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _LoginState();
}

class _LoginState extends State<Register> {
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void register() async {
    try {
      if (confirmPasswordController.text != passwordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Check Password terlebih dahulu'),
            duration: Duration(seconds: 1),
          ),
        );
      } else {
        var passwordbytes = utf8.encode(passwordController.text);
        var passwordHash = sha256.convert(passwordbytes).toString();

        dynamic res = await ApiDataSource.instance.register({
          "email": emailController.text,
          "username": usernameController.text,
          "password": passwordHash
        });

        if (res["message"] == "success") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Login()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Register Gagal'),
              duration: Duration(seconds: 1),
            ),
          );
        }
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
                height: 80,
                width: 80,
                margin: const EdgeInsets.symmetric(vertical: 50),
                child: Image.asset('assets/images/hero.png'),
              ),
              SizedBox(
                  height: 300,
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
                        controller: usernameController,
                        style: const TextStyle(fontSize: 15),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          hintText: "Username",
                        ),
                      ),
                      TextField(
                        controller: passwordController,
                        style: const TextStyle(fontSize: 15),
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
                      TextField(
                        controller: confirmPasswordController,
                        style: const TextStyle(fontSize: 15),
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          hintText: "Confirm Password",
                        ),
                      ),
                      ElevatedButton(
                        onPressed: register,
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 50),
                          child: Text("Register"),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "already have an account?",
                            style: TextStyle(color: Colors.grey),
                          ),
                          TextButton(
                              onPressed: () => {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Login()))
                                  },
                              child: const Text(
                                "Login",
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
