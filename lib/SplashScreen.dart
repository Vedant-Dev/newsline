import 'dart:async';
import 'package:create_atom/create_atom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news/ModHomePage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => ModHomePage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Atom(
              size: 200.0,
              orbit1Angle: 3.12 / 1.9,
              orbit2Angle: 3.17 / 5,
              orbit3Angle: -3.17 / 7,
              orbitsColor: Color(0xFFEED9B7),
              electronsColor: Color(0xFFEED9B7),
              nucleusColor: Color(0xFFEED9B7),
            ),
            Padding(
              padding: EdgeInsets.only(top: 4.0),
              child: new Text(
                "Loading News...",
                maxLines: 1,
                style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                    color: Colors.grey),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 4.0),
              child: new Text(
                "NewsLine",
                maxLines: 1,
                style: TextStyle(
                    fontSize: 24.0,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                    color: Colors.black54),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
