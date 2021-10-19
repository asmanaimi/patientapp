import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class OverlayCard extends StatelessWidget {
  const OverlayCard({Key key, this.imagefile,this.medecin}) : super(key: key);
  final PickedFile imagefile;
  final String medecin;

  @override
  Widget build(BuildContext context) {
     return Container(
      height: 450,
      padding: EdgeInsets.all(0),
      width: 280,
      child: Stack(
        children: <Widget>[
          Center(
            child: Container(
              height:220,
              width: 180,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: FileImage(
                      File(imagefile.path),
                    ),
                    fit: BoxFit.fitWidth),
              ),
            ),
          ),
          Positioned(
            bottom: 2,
            child: Container(
              padding: EdgeInsets.all(8),
              height: 55,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: Center(
                child: Text(
                  "Le nom du médecin : "+medecin,
                  style: TextStyle(
                     color: Color(0xFF00E676),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}