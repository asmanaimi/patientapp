
import 'package:flutter/material.dart';
import 'package:patientapp/NetworkHandler.dart';
import 'package:patientapp/models/profileModel.dart';
import 'package:patientapp/pages/editprofile.dart';

class MainProfile extends StatefulWidget {
  MainProfile({Key key}) : super(key: key);

  @override
  _MainProfileState createState() => _MainProfileState();
}

class _MainProfileState extends State<MainProfile> {
  bool circular = true;
  NetworkHandler networkHandler = NetworkHandler();
  ProfileModel profileModel = ProfileModel();
  @override
  void initState() {
    super.initState();

    fetchData();
  }

  void fetchData() async {
    var response = await networkHandler.get("/profile/getData");
    setState(() {
      profileModel = ProfileModel.fromJson(response["data"]);
      circular = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () {},
        //   color: Colors.black,
        // ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {

                Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => EditProfile(this.profileModel)),
                            (route) => false);
                      
            },
            color:  Color(0xFF00E676),
          ),
        ],
      ),
      body: circular
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: <Widget>[
            Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkHandler().getImage(profileModel.email),
            ),
          ),
                 Center(
                   child: Text(profileModel.email?? ' ',
    style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
),
                 ), 
          SizedBox(
            height: 10,
          ),
  
        ],
      ),
    ),
                Divider(
                  thickness: 0.3,
                ),
                otherDetails("Nom", profileModel.username?? ' '),
                otherDetails("Tél", profileModel.tel?? ' '),
                otherDetails("Adresse", profileModel.adress?? ' '),
                Divider(
                  thickness: 0.3,
                ),
                SizedBox(
                  height: 20,
                ),
              /*Ordonnances(
  url: "/ordonnances/getownordonnances",

              ),*/
              ],
            ),
    );
  }


  Widget otherDetails(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Text(
              
              "$label :",
              style: TextStyle(
              color:  Color(0xFF00E676),
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          SizedBox(
            height: 5,
          ),
          Center(
            child: Text(
              value,
              style: TextStyle(fontSize: 15),
            ),
          )
        ],
      ),
    );
  }
}