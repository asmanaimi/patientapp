
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:patientapp/NetworkHandler.dart';
import 'package:patientapp/pages/HomePage.dart';

class CreatProfile extends StatefulWidget {
  CreatProfile({Key key}) : super(key: key);

  @override
  _CreatProfileState createState() => _CreatProfileState();
}

class _CreatProfileState extends State<CreatProfile> {
  final networkHandler = NetworkHandler();
  bool circular = false;
  PickedFile _imageFile;
  final _globalkey = GlobalKey<FormState>();
  TextEditingController _username = TextEditingController();
  TextEditingController _tel = TextEditingController();
  TextEditingController _adress = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _globalkey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          children: <Widget>[
            imageProfile(),
            SizedBox(
              height: 20,
            ),
            nameTextField(),
            SizedBox(
              height: 20,
            ),
            telTextField(),
            SizedBox(
              height: 20,
            ),
            adressField(),
            SizedBox(
              height: 20,
            ),
           
            InkWell(
              onTap: () async {
                setState(() {
                  circular = true;
                });
                if (_globalkey.currentState.validate()) {
                  Map<String, String> data = {
                    "username": _username.text,
                    "tel": _tel.text,
                    "adress": _adress.text,
                    
                  };
                  var response =
                      await networkHandler.post("/profile/add", data);
                  if (response.statusCode == 200 ||
                      response.statusCode == 201) {
                    if (_imageFile.path != null) {
                      var imageResponse = await networkHandler.patchImage(
                          "/profile/add/image", _imageFile.path);
                      if (imageResponse.statusCode == 200) {
                        setState(() {
                          circular = false;
                        });
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => HomePage()),
                            (route) => false);
                      }
                    } else {
                      setState(() {
                        circular = false;
                      });
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => HomePage()),
                          (route) => false);
                    }
                  }
                }
              },
              child: Center(
                child: Container(
                  width: 250,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xFF00E676),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: circular
                        ? CircularProgressIndicator()
                        : Text(
                            "Cr??er votre profile",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget imageProfile() {
    return Center(
      child: Stack(children: <Widget>[
        CircleAvatar(
          radius: 80.0,
          backgroundImage: _imageFile == null
              ? AssetImage("assets/d.png")
              : FileImage(File(_imageFile.path)),
        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet()),
              );
            },
            child: Icon(
              Icons.camera_alt,
              color: Color(0xFF00E676),
              size: 28.0,
            ),
          ),
        ),
      ]),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choisir une photo de profile",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: Text("Camera"),
            ),
            FlatButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile;
    });
  }

  Widget nameTextField() {
    return TextFormField(
      controller: _username,
      validator: (value) {
        if (value.isEmpty) return "Tous les champs sont onligatoires";

        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
         color:Color(0xFF00E676),
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
         color: Color(0xFF00E676),
          width: 2,
        )),
        prefixIcon: Icon(
          Icons.person,
         color: Color(0xFF00E676),
        ),
        labelText: "Nom",
        helperText: "Saisir votre nom s'il vous plait ",
        hintText: " exemple:naimi ",
      ),
    );
  }

  Widget telTextField() {
    return TextFormField(
      controller: _tel,
      validator: (value) {
        if (value.isEmpty) return "Tous les champs sont onligatoires";

        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color:Color(0xFF00E676),
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
           color: Color(0xFF00E676),
          width: 2,
        )),
        prefixIcon: Icon(
          Icons.call,
          color: Color(0xFF00E676),
        ),
        labelText: "T??l",
        helperText: "Saisir votre num??ro s'il vous plait",
        hintText: " exemple: 27147963 ",
      ),
    );
  }

  Widget adressField() {
    return TextFormField(
      controller: _adress,
      validator: (value) {
        if (value.isEmpty) return "Tous les champs sont onligatoires";

        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
       color: Color(0xFF00E676),
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
         color: Color(0xFF00E676),
          width: 2,
        )),
        prefixIcon: Icon(
          Icons.home,
          color:Color(0xFF00E676),
        ),
        labelText: "Adresse",
        helperText: "Saisir votre adresse s'il vous plait",
        hintText: " exemple:12 rue ibn haithem tunis ",
      ),
    );
  }

}