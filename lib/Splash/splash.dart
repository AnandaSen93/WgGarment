
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wg_garment/Login/login.dart';
import 'dart:async';

import 'package:wg_garment/Menu/menu.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

    Future<bool> getLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isLoggedIn") ?? false;
  }

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    print("start");
    Timer(const Duration(seconds: 3), () {
      print("end");
      //Navigator.pushNamed(context, 'howItsWorks');
     getLoginStatus().then((isLoggedIn) {
             Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
            builder: (context) => isLoggedIn ? MenuView() : LoginView(),
  ),
  (Route<dynamic> route) => false,
  );
});
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/images/app_logo.png",
           width: 300,
          // height: double.infinity,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}