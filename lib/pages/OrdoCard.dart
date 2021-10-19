import 'package:flutter/material.dart';
import 'package:patientapp/NetworkHandler.dart';
import 'package:patientapp/models/AddOrdoModel.dart';
import 'package:patientapp/pages/HomePage.dart';
import 'package:patientapp/pages/HomeScreen.dart';

class OrdoCard extends StatelessWidget {
  const  OrdoCard({Key key, this.addOrdoModel, this.networkHandler})
      : super(key: key);

  final AddOrdoModel addOrdoModel;
  final NetworkHandler networkHandler;

  @override
  Widget build(BuildContext context) {
   /* Future<bool> _onDelete() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Are you sure?'),
            content: Text('You are going to delete data'),
            actions: <Widget>[
              FlatButton(
                child: Text('NO'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text('YES'),
                onPressed: () {
                  networkHandler.delete("/ordonnances/delete/${addOrdoModel.id}",addOrdoModel);
               // Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        });
}*/
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
                Text('Voulez-vous vraiment supprimer cette ordononnance ?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Oui'),
              onPressed: () {
              

        networkHandler.delete(
              "/ordonnances/delete/${addOrdoModel.id}",addOrdoModel);
Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePage()),
                          (route) => false);    
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
    
    return Container(
      height: 380,
      padding: EdgeInsets.symmetric(horizontal: 13, vertical: 8),
      width: 370,
      child: Column(
         children: <Widget>[
        Card(
          child: Stack(
            children: <Widget>[
              Container(
                height: 275,
                width: 280,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: networkHandler.getImage(addOrdoModel.id),
                      fit: BoxFit.fill
                      ),
                ),
              ),
             /* Positioned(
                bottom: 2,
                child: Container(
                  padding: EdgeInsets.all(7),
                  height: 60,
                  width: MediaQuery.of(context).size.width - 30,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                 

             
                ),
              ),*/
                
 
              
            ],
          ),
        ),
            Center(
                child: IconButton(
                icon: Icon(Icons.delete,color:Color(0xFF00E676)),
             
                 
                onPressed: () {
               _confirmDialog();
             //  _onDelete();
                },
            
                
            
                color: Color(0xFF27313B),
                  iconSize: 30,
                   padding:EdgeInsets.only(bottom:50)
                  
            ),
              ),
         ],
      ),
      
    );
  }
}