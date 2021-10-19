
import 'package:flutter/material.dart';
import 'package:patientapp/pages/ordonnances.dart';



class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: 
      SingleChildScrollView(
       child: Ordonnances(
  url: "/ordonnances/getownordonnances",
 
              ),
      ),
 
    );
  }
}

