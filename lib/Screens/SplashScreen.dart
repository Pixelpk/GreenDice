import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greendice/Screens/WelcomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HomeScreen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<String> Loadprefs() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token') ?? '';
  }

  @override
  void initState() {
    super.initState();
    Loadprefs().then((token) {
      print("TOKEN IS SPLASH SCREEN $token");
      if (token == '' || token == null) {
        Timer(
            Duration(seconds: 2),
                () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => WelcomeScreen(
                  title: 'WelcomeScreen',
                ))));
      } else {

        Timer(
            Duration(seconds: 2),
                () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => HomeScreen(title: token))));


        // WelcomeScreen(title: 'WelcomeScreen',);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        //fit: StackFit.expand,
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/green_bg.png",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/grid.png"),
                fit: BoxFit.cover,
                //scale: 0.5
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.height * 0.2,
            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //     image: AssetImage("assets/images/logo.png"),
            //     fit: BoxFit.cover,
            //   ),
            // ),
            child:  SvgPicture.asset(
                  "assets/images/splashLogo.svg"
                      ,
              color: Colors.white,

              )
          )
        ],
      ),
    );
  }
}
