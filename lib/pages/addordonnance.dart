


import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';
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
   var response= await http.get("http://192.168.43.145:3000/pharmaciens/list-pha");
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

    backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.clear,
              color: Color(0xFF00E676),
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
              "Aperçu",
              style: TextStyle(fontSize: 18, color:Color(0xFF00E676)),
            ),
          )

    ],     
),


body:Form(
  key:_globalkey,
  child:   ListView(
  
    children:<Widget>[
  
  SizedBox(
  
                height: 60,
  
              ),
  
      medecinTextField(),
  
      chargeTextField() ,
  
      SizedBox(
  
                height: 20,
  
              ),
  listepharmacy(),
      SizedBox(
  
                height: 80,
  
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
            return "tous les champs sont obilgatoires";
          } else if (value.length > 100) {
            return "le nom du médecin ne dépasse pas le 30 caractéres";
          }
          return null;
        },
        decoration: InputDecoration(
         
          border: OutlineInputBorder(
            borderSide: BorderSide(
    color: Color(0xFF00E676),
                ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF00E676),
              width: 2,
            ),
          ),
          labelText: "Ajouter votre ordonnance avec le nom du docteur",
          labelStyle:TextStyle(
                  color:Colors.grey,
                  ),
          prefixIcon: IconButton(
            icon: Icon(
                            iconphoto,

              color: Color(0xFF00E676),
            ),  onPressed:(){showModalBottomSheet(
                      context: context, builder: ((builder) => bottomSheet()));}
          
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
            border: Border.all(color:Color(0xFF00E676)),
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white, 
            
          ),
   
        child: /*  new PopupMenuButton<String>(
                        icon: const Icon(Icons.arrow_drop_down,color:Colors.white),
                        onSelected: (String value) {
                          _priseencharge.text = value;
                        },
                        itemBuilder: (BuildContext context) {
                          return priseencharge.map<PopupMenuItem<String>>((String value) {
                            return new PopupMenuItem(child: new Text(value), value: value);
                          }).toList();
                        },
                      ),*/
           DropdownSearch<String>(
    mode: Mode.MENU,
    items: priseencharge,
    
    label: "Prise en charge",

    hint: "saisir le type de prise en charge",
    onChanged: (String value) {
                          _priseencharge.text = value;
                        },
                      
    selectedItem: _priseencharge.text,
    
    ),        
      ),
    );
  }

   Widget listepharmacy() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child:         Container(
             height: 50,
              width: 360,
          decoration: BoxDecoration(
            border: Border.all(color:Color(0xFF00E676)),
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white, 
            
          ),
         
          child:  
 
      
          new PopupMenuButton<String>(
            child: Center(child: Text('choisissez une pharmacie',style: TextStyle(color:Colors.grey))),

                         // icon: const Icon(Icons.arrow_drop_down,color:Color(0xFF00E676)),
                          onSelected: (String value) {
                            _listpharmacy.text = value;
                            final snackBar = SnackBar(content: Text('vous avez choisissez le pharmacy du '+value,style: TextStyle(color:Colors.white)),            backgroundColor:Color(0xFF00E676),
);
ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          },
                          itemBuilder: (BuildContext context) {
                            return listitempharmacy.map<PopupMenuItem<String>>((pharmacy) {
                              return new PopupMenuItem(child: new Text(pharmacy['listp']),value:pharmacy['listp']);
                            }).toList();
                          },
                        ),
      
            /* DropdownSearch<dynamic>(
               
      mode: Mode.MENU,
      items: listitempharmacy,
      label: "liste des pharmaciens",
      onChanged: (  pharmacy) {
                             _listpharmacy.text = pharmacy['listp'];
                          },
      selectedItem: _listpharmacy.text,
      ),  */
        
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
            width: 250,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color:Color(0xFF00E676)),
            child: Center(
                child: Text(
              "Ajouter",
              style: TextStyle(
                  color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            )),
          ),
        
      ),
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
        child: Column(children: <Widget>[
          Text(
            "sélectionner une photo",
            style: TextStyle(fontSize: 20.0),
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
              label: Text("Caméra"),
            ),
            FlatButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: Text("Gallerie"),
            ),
          ])
        ]));
  }

  void takePhoto(ImageSource source) async {
    final PickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = PickedFile;
      
    });
  }
}
