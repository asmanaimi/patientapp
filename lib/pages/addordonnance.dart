


import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:patientapp/CustomWidget/OverlayCard.dart';
import 'package:patientapp/NetworkHandler.dart';
import 'package:patientapp/models/AddOrdoModel.dart';
import 'package:patientapp/models/Pharmacy.dart';
import 'package:patientapp/pages/HomePage.dart';
class Addordonnance extends StatefulWidget {
  Addordonnance({Key key}) : super(key: key);

  @override
  _AddordonnanceState createState() => _AddordonnanceState();
}

class _AddordonnanceState extends State<Addordonnance> {
   final _globalkey = GlobalKey<FormState>();
   TextEditingController _medecin = TextEditingController();
  TextEditingController _priseencharge = TextEditingController();
  TextEditingController _listpharmacy = TextEditingController();
  ImagePicker _picker = ImagePicker();
  PickedFile _imageFile;
  IconData iconphoto = Icons.image;
  List listitempharmacy =  List();
  NetworkHandler networkHandler = NetworkHandler();
  var  selectedType;
  List<String> priseencharge = <String>[
    'cnss',
    'cnrps',
    'cnam',
  
  ];

   Future getListPharmacie()async{
   var response= await http.get("http://172.16.20.35:3000/pharmaciens/list-pha");
   if(response.statusCode == 200){
     var jsonData = json.decode(response.body);
   
     setState((){
     listitempharmacy =jsonData;
     
     });
   }
 }
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
  //  fetchData();
     // futureData = fetchData();
getListPharmacie();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar:AppBar(

    backgroundColor: Colors.white54,
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.clear,
              color: Colors.black,
           ), onPressed: () { Navigator.pop(context); },
        ),
    actions: <Widget>[
FlatButton(
            onPressed: (){    
               if (_imageFile.path != null &&
                  _globalkey.currentState.validate()) {
              
              showModalBottomSheet(
                  context: context,
                  builder: ((builder) => OverlayCard(
                   imagefile: _imageFile,   
                    medecin: _medecin.text,
                      )),
                );
                  }
                },
            child: Text(
              "Preview",
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
          )

    ],     
),


body:Form(
  key:_globalkey,
  child:   ListView(
  
    children:<Widget>[
  
  
  
      medecinTextField(),
  
      chargeTextField() ,
  
      SizedBox(
  
                height: 20,
  
              ),
  listepharmacy(),
      SizedBox(
  
                height: 20,
  
              ),

              addButton(),
  
    ],
  
  
  
  ),
),

    );
}



  Widget medecinTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: TextFormField(
        controller: _medecin,
        validator: (value) {
          if (value.isEmpty) {
            return "name of medecin can't be empty";
          } else if (value.length > 100) {
            return "name of medecin should be <=30";
          }
          return null;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            ),
          ),
          labelText: "Add ordonnance and name",
          prefixIcon: IconButton(
            icon: Icon(
                            iconphoto,

              color: Colors.teal,
            ), onPressed:  takeCoverPhoto,
          
          ),
        ),
        maxLength: 30,
        maxLines: null,
      ),
    );
  }

  Widget chargeTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child:         Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black45),
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.black12,  //add it here
        ),
        
        child:    new PopupMenuButton<String>(
                        icon: const Icon(Icons.arrow_drop_down),
                        onSelected: (String value) {
                          _priseencharge.text = value;
                        },
                        itemBuilder: (BuildContext context) {
                          return priseencharge.map<PopupMenuItem<String>>((String value) {
                            return new PopupMenuItem(child: new Text(value), value: value);
                          }).toList();
                        },
                      ),
      ),
    );
  }

   Widget listepharmacy() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child:         Container(
        
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black45),
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.black12,  //add it here
        ),
       
        child:  
  
    
          new PopupMenuButton<String>(
                        icon: const Icon(Icons.arrow_drop_down),
                        onSelected: (String value) {
                          _listpharmacy.text = value;
                        },
                        itemBuilder: (BuildContext context) {
                          return listitempharmacy.map<PopupMenuItem<String>>((pharmacy) {
                            return new PopupMenuItem(child: new Text(pharmacy['listp']),  value:pharmacy['listp']);
                          }).toList();
                        },
                      ),
          
      
      ),
    );
  }
   
   Widget addButton() {
      return InkWell(
      onTap: () async {
        if (_imageFile != null && _globalkey.currentState.validate()) {
          AddOrdoModel addOrdoModel =
               AddOrdoModel(medecin: _medecin.text, priseencharge: _priseencharge.text,listp: _listpharmacy.text);
          var response = await networkHandler.post1(
              "/ordonnances/add", addOrdoModel.toJson());
          print(response.body);

          if (response.statusCode == 200 || response.statusCode == 201) {
            String id = json.decode(response.body)["data"];
            var imageResponse = await networkHandler.patchImage(
                "/ordonnances/add/coverImage/$id", _imageFile.path);
            print(imageResponse.statusCode);
            if (imageResponse.statusCode == 200 ||
                imageResponse.statusCode == 201) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                  (route) => false);
            }
          }
        }
      },
 

      child: Center(
          child: Container(
            height: 50,
            width: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.teal),
            child: Center(
                child: Text(
              "Add Ordonnance",
              style: TextStyle(
                  color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            )),
          ),
        
      ),
    );
    
  }
  void takeCoverPhoto() async {
    final coverPhoto = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = coverPhoto;
      iconphoto = Icons.check_box;
    });
  }
}
