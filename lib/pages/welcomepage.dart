import 'dart:async';
import 'package:flutter/material.dart';
import 'package:patientapp/pages/SignInPage.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (
              BuildContext context
              ) =>SignInPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     //#2CD889
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/logo.png'),
      ),
    );
  }

  
}
