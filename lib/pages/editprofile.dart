
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:patientapp/NetworkHandler.dart';
import 'package:patientapp/models/profileModel.dart';
import 'package:patientapp/pages/HomePage.dart';


class EditProfile extends StatefulWidget {
 // editProfile({Key key}) : super(key: key);
EditProfile(this.profilemodel);

  final ProfileModel profilemodel;
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

    final networkHandler = NetworkHandler();
  bool circular = false;
  PickedFile _imageFile;
  final _globalkey = GlobalKey<FormState>();
 //   String email = '';
  TextEditingController _username ;
  TextEditingController _tel ;
  TextEditingController _adress ;
  String username,tel,adress;
  final ImagePicker _picker = ImagePicker();
    @override
  void initState() {
    super.initState();
//email = widget.profilemodel.email;

 _username =
new TextEditingController(text: widget.profilemodel.username);

 _tel =
new TextEditingController(text: widget.profilemodel.tel);
   _adress =
new TextEditingController(text: widget.profilemodel.adress);  
   fetchData();
  }
 ProfileModel profileModel = ProfileModel();
  void fetchData() async {
    
    var response = await networkHandler.get("/profile/getData");
    setState(() {
      profileModel = ProfileModel.fromJson(response["data"]);
      circular = false;
    });
  }
  @override
  Widget build(BuildContext context) {
  //fetchData();
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
                                
                       _globalkey.currentState.save();
                  
                       networkHandler.patch("/profile/update", data);
               
                   
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                          (route) => false);
                    
                        }  
                       
                        
                    
                   
                },
              
              child: Center(
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: circular
                        ? CircularProgressIndicator()
                        : Text(
                            "update",
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
              ? AssetImage("assets/asma.jpg")
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
              color: Colors.greenAccent[400],
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
            "Choose Profile photo",
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
    return  TextFormField(
                    controller: _username,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'name',
                      fillColor: Colors.grey[300],
                      filled: true,
                    ),
                    validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter country';
                                  }
                                  return null;
                                },
                  onSaved: (value) => username= value,
                  );
  
  }

  Widget telTextField() {
    return  TextFormField(
                    controller: _tel,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'tel',
                      fillColor: Colors.grey[300],
                      filled: true,
                    ),
                    validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter country';
                                  }
                                  return null;
                                },
                      onSaved: (value) => tel = value,
                  );
  }

  Widget adressField() {
    return TextFormField(
                    controller: _adress,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'adress',
                      fillColor: Colors.grey[300],
                      filled: true,
                    ),
                    validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter country';
                                  }
                                  return null;
                                },
                      onSaved: (value) => adress = value,
                  
                  );
  }

}