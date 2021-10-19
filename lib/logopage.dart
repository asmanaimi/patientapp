import 'dart:async';
import 'package:flutter/material.dart';
import 'package:patientapp/pages/SignInPage.dart';
import 'package:patientapp/pages/welcomepage.dart';


class Logopage extends StatefulWidget {
  @override
  _LogopageState createState() => _LogopageState();
}

class _LogopageState extends State<Logopage> {
  @override
  void initState() {
    super.initState();
   
   
              
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     //#2CD889
      backgroundColor: Colors.white,
      body: Column(
           crossAxisAlignment:CrossAxisAlignment.center,
          children: <Widget>[
          //  Stack(
           // children: <Widget>[
              
                
                Container(
                  
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 110,
                      ),
                    
                      
                      Center(
                        child: Image.asset('assets/logoc.png',
        height:160,
        width: 220,
                         // color: Colors.white,

        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    
                    ],
                  ),
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                      color: Colors.white,),
                ),
              
           // ],
         // ),
             SizedBox(
            height:150,
          ),
            Container(
              width: 300,
              height: 50,
             
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
 gradient: LinearGradient(
                          colors: [Color(0xFF69F0AE), Color(0xFF00E676)])              ),
              child: FlatButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) =>SplashScreen()));
                },
                child: Text(
                  "Bienvenue chez Dweya ",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ]),
    );
  }
  
}


class WaveClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);

    var firstEndPoint = Offset(size.width * 0.6, size.height - 20 - 50);
    var firstControlPoint = Offset(size.width * .25, size.height - 60 - 50);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 60);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 50);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }

  
}