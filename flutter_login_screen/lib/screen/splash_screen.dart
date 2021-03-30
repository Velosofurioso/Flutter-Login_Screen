import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login_screen/screen/login_screen.dart';
import 'package:rive/rive.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Artboard artboard;
  RiveAnimationController _controller;

  @override
  void initState() {
    super.initState();

    rootBundle.load("assets/loading.riv").then(
            (data) async {

          final file = RiveFile();
          if (file.import(data)) {

            final _artboard = file.mainArtboard;
            _artboard.addController(_controller = SimpleAnimation("color"));
            
            setState(() {
              artboard = _artboard;
            });

          }
        });

    Future.delayed(Duration(seconds: 5)).then((value) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginScreen())
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        child: artboard == null
        ? Container()
        : Rive(artboard: artboard),
      ),
    );
  }
}

