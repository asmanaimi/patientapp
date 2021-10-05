import 'package:flutter/material.dart';
import 'package:patientapp/NetworkHandler.dart';
import 'package:patientapp/models/AddOrdoModel.dart';
import 'package:patientapp/pages/HomePage.dart';

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
          title: Text('Warning!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure want delete this item?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
              

        networkHandler.delete(
              "/ordonnances/delete/${addOrdoModel.id}",addOrdoModel);
Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePage()),
                          (route) => false);              },
            ),
            FlatButton(
              child: const Text('No'),
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
      height: 696,
      padding: EdgeInsets.symmetric(horizontal: 13, vertical: 8),
      width: MediaQuery.of(context).size.width,
      child: Column(
         children: <Widget>[
        Card(
          child: Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
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
                icon: Icon(Icons.delete),
             
                 
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