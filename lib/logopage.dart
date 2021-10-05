import 'dart:async';
import 'package:flutter/material.dart';
import 'package:patientapp/pages/welcomepage.dart';


class Logopage extends StatefulWidget {
  @override
  _LogopageState createState() => _LogopageState();
}

class _LogopageState extends State<Logopage> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (
              BuildContext context
              ) =>SplashScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     //#2CD889
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/logo4.png',
        height: 250,
        width: 250,
        ),
        
      ),
    );
  }

  
}