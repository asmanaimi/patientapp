
import 'package:flutter/material.dart';
import 'package:patientapp/NetworkHandler.dart';
import 'package:patientapp/models/AddOrdoModel.dart';
import 'package:patientapp/models/globalmodel.dart';
import 'package:patientapp/pages/OrdoCard.dart';



class Ordonnances extends StatefulWidget {
  Ordonnances({Key key, this.url}) : super(key: key);
  final String url;
     
 
  @override
  _OrdonnancesState createState() => _OrdonnancesState();
}

class _OrdonnancesState extends State<Ordonnances> {
  NetworkHandler networkHandler = NetworkHandler();
 
globalmodel globalModel = globalmodel();
  List<AddOrdoModel> data = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }
 void fetchData() async {
    var response = await networkHandler.get(widget.url);
    globalModel  = globalmodel.fromJson(response);
    setState(() {
      data = globalModel.data;
    }
    );
  }


  @override
  Widget build(BuildContext context) {
   Future<void> _confirmDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alerte!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Voulez-vous vraiment supprimer cet élément ?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Oui'),
              onPressed: () {
                AddOrdoModel addOrdoModel = AddOrdoModel();


        networkHandler.delete(
              "/ordonnances/delete/${addOrdoModel.id}",addOrdoModel);
                Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
              },
            ),
            FlatButton(
              child: const Text('Non'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
    return data.length > 0
        ? Column(
            children: data
                .map((item) => Column(
                      children: <Widget>[
                        InkWell(
                          
                          onTap: () {
                          },
                         
                          child: OrdoCard(
                           addOrdoModel: item,
                            networkHandler: networkHandler,
                          ),

                          
                        ),
                  
                        SizedBox(
                          height: 0,
                        ),
               /*Center(
                child: IconButton(
                icon: Icon(Icons.delete),
             
                 
                onPressed: () {
               _confirmDialog();
             //  _onDelete();
                },
            
                
            
                color: Color(0xFF27313B),
                  iconSize: 30,
                   padding:EdgeInsets.only(bottom:50)
                  
            ),
               ),*/
                     ],
                    ))
                .toList(),
          )
        : Center(
            child: Text("Vous n'avez pas ajouter  une ordonnace"),
          );
  }
  
}
